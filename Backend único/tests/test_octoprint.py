"""Tests del adapter OctoPrint (BE-01..BE-06) y cifrado de API keys (BE-20)."""

import json

import httpx
import pytest

from app.security import decrypt_secret, encrypt_secret
from app.services.adapters import octoprint as oa

BASE = "http://octopi.local"


def _version_payload():
    return {"api": "0.1", "server": "1.10.3", "text": "OctoPrint 1.10.3"}


def _printer_payload(state_text="Operational", actual=210.0, target=215.0):
    return {
        "state": {"text": state_text, "flags": {"operational": True,
                                                "printing": state_text == "Printing",
                                                "paused": False,
                                                "error": False,
                                                "closedOrError": False}},
        "temperature": {
            "tool0": {"actual": actual, "target": target},
            "bed": {"actual": 55.0, "target": 60.0},
        },
    }


def _job_payload(state="printing", completion=42.5, left=1234):
    return {
        "state": state,
        "progress": {"completion": completion, "printTimeLeft": left,
                     "printTime": 900},
        "file": {"name": "pieza.gcode"},
    }


def _patch_transport(monkeypatch, handler):
    transport = httpx.MockTransport(handler)
    real_get = httpx.get
    real_post = httpx.post

    def fake_get(url, **kwargs):
        return transport.handle_request(
            httpx.Request("GET", url, headers=kwargs.get("headers")))

    def fake_post(url, **kwargs):
        request = httpx.Request("POST", url, headers=kwargs.get("headers"))
        return transport.handle_request(request)

    monkeypatch.setattr(oa.httpx, "get", fake_get)
    monkeypatch.setattr(oa.httpx, "post", fake_post)
    return real_get, real_post


# --- adapter ---------------------------------------------------------------
def test_test_connection_ok(monkeypatch):
    def handler(request):
        assert request.url.path == "/api/version"
        assert request.headers["X-Api-Key"] == "sekret"
        return httpx.Response(200, json=_version_payload())

    _patch_transport(monkeypatch, handler)
    adapter = oa.OctoPrintAdapter(BASE, "sekret")
    data = adapter.test_connection()
    assert data["server"] == "1.10.3"


def test_test_connection_bad_key(monkeypatch):
    def handler(request):
        return httpx.Response(401, json={})

    _patch_transport(monkeypatch, handler)
    adapter = oa.OctoPrintAdapter(BASE, "wrong")
    with pytest.raises(oa.OctoPrintError) as exc:
        adapter.test_connection()
    assert "API key" in str(exc.value)


def test_test_connection_unreachable(monkeypatch):
    def handler(request):
        raise httpx.ConnectError("refused")

    _patch_transport(monkeypatch, handler)
    adapter = oa.OctoPrintAdapter(BASE)
    with pytest.raises(oa.OctoPrintError):
        adapter.test_connection()


def test_get_job_and_parse(monkeypatch):
    def handler(request):
        assert request.url.path == "/api/job"
        return httpx.Response(200, json=_job_payload())

    _patch_transport(monkeypatch, handler)
    parsed = oa.parse_job(oa.OctoPrintAdapter(BASE).get_job())
    assert parsed["progress"] == 42.5
    assert parsed["remaining_seconds"] == 1234
    assert parsed["current_file"] == "pieza.gcode"


def test_parse_temps():
    temps = oa.parse_temps(_printer_payload())
    assert temps["nozzle_temp"] == 210.0
    assert temps["nozzle_target"] == 215.0
    assert temps["bed_temp"] == 55.0


def test_map_state():
    assert oa.map_state(_printer_payload("Printing"),
                        _job_payload("printing")) == "printing"
    assert oa.map_state(_printer_payload("Operational"),
                        _job_payload("offline")) == "idle"
    assert oa.map_state(_printer_payload("Pausing"), _job_payload()) == "paused"
    err = _printer_payload()
    err["state"]["flags"]["error"] = True
    assert oa.map_state(err, _job_payload()) == "error"


def test_upload_and_start(monkeypatch, tmp_path):
    gcode = tmp_path / "pieza.gcode"
    gcode.write_text("G28\nG1 X10\n")
    seen = {}

    def fake_post(url, **kwargs):
        seen["url"] = url
        seen["files"] = kwargs.get("files")
        seen["data"] = kwargs.get("data")

        def handler(request):
            return httpx.Response(201, json={"done": True})

        return httpx.MockTransport(handler).handle_request(
            httpx.Request("POST", url))

    monkeypatch.setattr(oa.httpx, "post", fake_post)
    result = oa.OctoPrintAdapter(BASE, "k").upload_and_start(gcode, "pieza.gcode")
    assert result["done"] is True
    assert seen["url"] == f"{BASE}/api/files/local"
    assert seen["data"] == {"select": "true", "print": "true"}
    assert seen["files"]["file"][0] == "pieza.gcode"


# --- BE-20 cifrado ---------------------------------------------------------
def test_encrypt_decrypt_roundtrip():
    stored = encrypt_secret("mi-api-key")
    assert stored is not None and stored.startswith("fernet:")
    assert "mi-api-key" not in stored
    assert decrypt_secret(stored) == "mi-api-key"


def test_encrypt_none_and_plaintext_legacy():
    assert encrypt_secret(None) is None
    assert encrypt_secret("") == ""
    # Valores legacy sin cifrar se devuelven tal cual (seed/demo).
    assert decrypt_secret("plain-key-legacy") == "plain-key-legacy"
    assert decrypt_secret(None) is None


def test_decrypt_wrong_key_returns_none(monkeypatch):
    stored = encrypt_secret("secreto")
    from app.config import settings

    monkeypatch.setattr(settings, "secret_key", "otra-clave-completamente")
    assert decrypt_secret(stored) is None


# --- esquemas de prueba de conexión ----------------------------------------
def test_connection_test_schema_shape():
    from app.schemas import PrinterConnectionTest

    ok = PrinterConnectionTest(ok=True, message="ok", version="1.10.3")
    assert json.loads(ok.model_dump_json())["ok"] is True
