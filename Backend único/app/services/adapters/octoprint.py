"""Adapter OctoPrint (BE-01..BE-06). Sincrónico: los routers corren en el
threadpool de FastAPI y el poller usa `asyncio.to_thread`.

Habla la API REST estándar de OctoPrint con header `X-Api-Key`:
  GET  /api/version          → probar conexión (BE-01)
  GET  /api/printer          → estado, temperaturas (BE-03)
  GET  /api/job              → job activo, progreso, tiempo restante (BE-02/03)
  POST /api/files/local      → subir gcode e iniciar (BE-05, solo con
                                confirmación explícita del operador en el API)
"""

from pathlib import Path
from typing import Any

import httpx

DEFAULT_TIMEOUT = 5.0


class OctoPrintError(Exception):
    """Error alcanzable del adapter (HTTP no-2xx, timeout, red)."""

    def __init__(self, message: str, status_code: int | None = None):
        super().__init__(message)
        self.status_code = status_code


class OctoPrintAdapter:
    def __init__(self, base_url: str, api_key: str | None = None,
                 timeout: float = DEFAULT_TIMEOUT):
        if not base_url:
            raise OctoPrintError("URL de OctoPrint vacía.")
        self.base_url = base_url.rstrip("/")
        self.api_key = api_key
        self.timeout = timeout

    def _headers(self) -> dict[str, str]:
        return {"X-Api-Key": self.api_key} if self.api_key else {}

    def _get(self, path: str) -> dict[str, Any]:
        url = f"{self.base_url}{path}"
        try:
            resp = httpx.get(url, headers=self._headers(),
                             timeout=self.timeout)
        except httpx.HTTPError as exc:
            raise OctoPrintError(f"No se pudo contactar a OctoPrint: {exc}") from exc
        if resp.status_code == 401 or resp.status_code == 403:
            raise OctoPrintError("API key rechazada por OctoPrint.",
                                 status_code=resp.status_code)
        if resp.status_code != 200:
            raise OctoPrintError(
                f"OctoPrint respondió HTTP {resp.status_code}.",
                status_code=resp.status_code,
            )
        try:
            return resp.json()
        except ValueError as exc:
            raise OctoPrintError("Respuesta no-JSON de OctoPrint.") from exc

    def test_connection(self) -> dict[str, Any]:
        """BE-01: `GET /api/version`; valida URL + API key."""
        return self._get("/api/version")

    def get_printer(self) -> dict[str, Any]:
        """BE-03: estado del printer (temps actuales/objetivo, flags)."""
        return self._get("/api/printer")

    def get_job(self) -> dict[str, Any]:
        """BE-02/03: job activo (state, progress, printTimeLeft, filename)."""
        return self._get("/api/job")

    def upload_and_start(self, gcode_path: Path, filename: str) -> dict[str, Any]:
        """BE-05: sube el gcode a la biblioteca local y lo pone a imprimir.

        El backend NUNCA llama esto de forma autónoma: solo desde endpoints
        que el operador invocó con confirmación explícita.
        """
        url = f"{self.base_url}/api/files/local"
        try:
            with open(gcode_path, "rb") as fh:
                resp = httpx.post(
                    url,
                    headers=self._headers(),
                    files={"file": (filename, fh, "application/octet-stream")},
                    data={"select": "true", "print": "true"},
                    timeout=max(self.timeout, 60.0),  # gcode puede tardar
                )
        except httpx.HTTPError as exc:
            raise OctoPrintError(f"No se pudo subir el gcode: {exc}") from exc
        if resp.status_code not in (200, 201):
            raise OctoPrintError(
                f"OctoPrint rechazó el archivo (HTTP {resp.status_code}).",
                status_code=resp.status_code,
            )
        try:
            return resp.json()
        except ValueError as exc:
            raise OctoPrintError("Respuesta no-JSON de OctoPrint.") from exc


def map_state(printer_info: dict[str, Any], job_info: dict[str, Any]) -> str:
    """Mapea el estado de OctoPrint al enum NOVALAB (BE-02/BE-26).

    Operational+job printing → printing; Operational sin job → idle;
    Pausing/Paused → paused; Error → error; desconocido/offline → error.
    """
    state_block = (printer_info or {}).get("state") or {}
    flags = state_block.get("flags") or {}
    if flags.get("error") or flags.get("closedOrError"):
        return "error"
    state_text = (state_block.get("text") or "").lower()
    job_state = ((job_info or {}).get("state") or "").lower()
    if "paus" in state_text or job_state == "paused":
        return "paused"
    if job_state == "printing" or "print" in state_text and "operational" not in state_text:
        return "printing"
    if "operational" in state_text or "idle" in state_text:
        return "idle"
    if "offline" in state_text or "not" in state_text and "operational" in state_text:
        return "offline"
    return "error"


def parse_job(job_info: dict[str, Any]) -> dict[str, Any]:
    """Extrae campos útiles de `GET /api/job` (BE-03)."""
    job_info = job_info or {}
    progress = job_info.get("progress") or {}
    file_info = job_info.get("file") or {}
    completion = progress.get("completion")
    return {
        "state": job_info.get("state"),
        "progress": round(float(completion), 1)
        if completion is not None else None,
        "remaining_seconds": (lambda v: int(v) if v is not None else None)(
            progress.get("printTimeLeft")
        ),
        "current_file": file_info.get("name"),
    }


def parse_temps(printer_info: dict[str, Any]) -> dict[str, float | None]:
    """Extrae temperaturas actuales/objetivo de `GET /api/printer` (BE-03)."""
    temps = (printer_info or {}).get("temperature") or {}

    def _pair(block: dict | None) -> tuple[float | None, float | None]:
        if not block:
            return None, None
        actual = block.get("actual")
        target = block.get("target")
        return (
            round(float(actual), 1) if actual is not None else None,
            round(float(target), 1) if target is not None else None,
        )

    nozzle = _pair(temps.get("tool0"))
    bed = _pair(temps.get("bed"))
    return {
        "nozzle_temp": nozzle[0],
        "nozzle_target": nozzle[1],
        "bed_temp": bed[0],
        "bed_target": bed[1],
    }
