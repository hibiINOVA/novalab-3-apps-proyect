"""Almacenamiento de archivos subidos (G-code de jobs, logos de orgs).

Los archivos viven bajo `settings.storage_dir` (default `data/`):
  data/gcode/{job_id}/{archivo}.gcode
  data/logos/{org_id}/logo.{ext}
"""

from pathlib import Path

from fastapi import HTTPException, UploadFile

from app.config import settings

MAX_GCODE_BYTES = 50 * 1024 * 1024  # 50 MB
MAX_LOGO_BYTES = 5 * 1024 * 1024  # 5 MB
GCODE_EXTENSIONS = {".gcode", ".gco", ".g"}
LOGO_EXTENSIONS = {".png", ".jpg", ".jpeg", ".webp"}
LOGO_MEDIA_TYPES = {
    ".png": "image/png",
    ".jpg": "image/jpeg",
    ".jpeg": "image/jpeg",
    ".webp": "image/webp",
}


def storage_dir() -> Path:
    base = Path(settings.storage_dir)
    base.mkdir(parents=True, exist_ok=True)
    return base


def sanitize_filename(name: str) -> str:
    """Quita rutas y caracteres peligrosos del nombre original."""
    clean = Path(name.replace("\\", "/")).name
    clean = "".join(c if (c.isalnum() or c in "._- ()") else "_" for c in clean)
    clean = clean.strip("._") or "archivo"
    return clean[:150]


async def read_upload(file: UploadFile, max_bytes: int,
                      allowed: set[str], kind: str) -> tuple[str, bytes]:
    """Lee y valida un upload; lanza 415 (extensión) o 413 (tamaño)."""
    filename = sanitize_filename(file.filename or "")
    ext = Path(filename).suffix.lower()
    if ext not in allowed:
        raise HTTPException(
            415, {"code": "unsupported_media_type",
                  "message": f"Extensión no soportada: {ext or '(vacía)'}."},
        )
    data = await file.read()
    if len(data) > max_bytes:
        raise HTTPException(
            413, {"code": "file_too_large",
                  "message": f"El archivo supera el máximo de "
                             f"{max_bytes // (1024 * 1024)} MB."},
        )
    if not data:
        raise HTTPException(
            422, {"code": "empty_file", "message": "El archivo está vacío."},
        )
    return filename, data


def save_file(subdir: str, filename: str, data: bytes) -> Path:
    target_dir = storage_dir() / subdir
    target_dir.mkdir(parents=True, exist_ok=True)
    for old in target_dir.iterdir():
        if old.is_file():
            old.unlink()
    path = target_dir / filename
    path.write_bytes(data)
    return path


def delete_file(relative: str | None) -> None:
    if not relative:
        return
    path = storage_dir() / relative
    if path.is_file():
        path.unlink()
