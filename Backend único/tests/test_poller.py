"""Tests del poller OctoPrint (BE-02/BE-04/BE-07/BE-26)."""

import asyncio
import json
from pathlib import Path

import httpx
import pytest
from sqlalchemy import create_engine, select
from sqlalchemy.orm import sessionmaker

from app.config import settings
from app.db import Base
from app.models import OrderItem, PrintJob, Printer
from app.security import encrypt_secret
from app.seed import seed_demo
from app.services import poller as poller_mod
from app.services.adapters import octoprint as oa


@pytest.fixture()
def db(tmp_path):
    engine = create_engine(
        f"sqlite:///{tmp_path / 'poller.db'}",
        connect_args={"check_same_thread": False},
    )
    Base.metadata.create_all(engine)
    factory = sessionmaker(bind=engine, autoflush=False,
                           expire_on_commit=False)
    session = factory()
    seed_demo(session)
    session.commit()
    session.close()
    # El poller abre/cierra su sesión; el test usa otra del mismo engine.
    session = factory()
    yield session
    session.close()
    poller_mod._failures.clear()


@pytest.fixture(autouse=True)
def _no_storage(tmp_path, monkeypatch):
    monkeypatch.setattr(settings, "storage_dir", str(tmp_path / "data"))


def _mock_adapter(monkeypatch, printer_payload, job_payload=None,
                  fail=False):
    def fake_get_printer(self):
        if fail:
            raise oa.OctoPrintError("caído")
        return printer_payload

    def fake_get_job(self):
        if fail:
            raise oa.OctoPrintError("caído")
        return job_payload or {"state": "Operational", "progress": {},
                               "file": {}}

    monkeypatch.setattr(oa.OctoPrintAdapter, "get_printer", fake_get_printer)
    monkeypatch.setattr(oa.OctoPrintAdapter, "get_job", fake_get_job)


def _poll(monkeypatch, db, printer_ids=None):
    factory = sessionmaker(bind=db.get_bind(), autoflush=False,
                           expire_on_commit=False)
    monkeypatch.setattr(poller_mod, "get_session_factory", lambda: factory)
    monkeypatch.setattr(settings, "poller_enabled", False)
    asyncio.run(poller_mod.poll_once(printer_ids))
    db.expire_all()


def _ender(db) -> Printer:
    p = db.scalar(select(Printer).where(Printer.name == "Ender 3 V3"))
    assert p is not None
    return p


def test_poll_updates_state_and_temps(db, monkeypatch):
    p = _ender(db)
    p.state = "idle"
    db.commit()
    _mock_adapter(monkeypatch, {
        "state": {"text": "Printing", "flags": {"operational": True,
                                                "printing": True,
                                                "error": False,
                                                "closedOrError": False}},
        "temperature": {"tool0": {"actual": 205.0, "target": 210.0},
                        "bed": {"actual": 60.0, "target": 60.0}},
    }, {
        "state": "Printing",
        "progress": {"completion": 55.0, "printTimeLeft": 600},
        "file": {"name": "vaso.gcode"},
    })
    _poll(monkeypatch, db, [p.id])
    db.refresh(p)
    assert p.state == "printing"
    assert p.progress == 55.0
    assert p.remaining_seconds == 600
    assert p.nozzle_temp == 205.0
    assert p.bed_temp == 60.0
    assert p.current_file == "vaso.gcode"
    assert p.last_seen is not None


def test_poll_offline_after_failures(db, monkeypatch):
    p = _ender(db)
    _mock_adapter(monkeypatch, {}, fail=True)
    for _ in range(poller_mod.OFFLINE_AFTER):
        _poll(monkeypatch, db, [p.id])
    db.refresh(p)
    assert p.state == "offline"
    assert poller_mod._failures[p.id] == poller_mod.OFFLINE_AFTER


def test_poll_auto_completes_finished_job(db, monkeypatch):
    p = _ender(db)
    p.state = "printing"
    item = db.scalar(select(OrderItem).where(OrderItem.state != "printing")
                     .limit(1))
    item.state = "printing"
    item.printer_id = p.id
    job = PrintJob(item_id=item.id, printer_id=p.id, state="printing")
    db.add(job)
    db.commit()
    # OctoPrint terminó: Operational sin job activo
    _mock_adapter(monkeypatch, {
        "state": {"text": "Operational", "flags": {"operational": True,
                                                   "error": False,
                                                   "closedOrError": False}},
        "temperature": {"tool0": {"actual": 30.0, "target": 0.0},
                        "bed": {"actual": 28.0, "target": 0.0}},
    }, {"state": "Operational", "progress": {"completion": None},
        "file": {}})
    _poll(monkeypatch, db, [p.id])
    db.refresh(job)
    db.refresh(p)
    assert job.state == "printed"
    assert job.finished_at is not None
    assert p.state == "idle"


def test_poll_saves_snapshot_while_printing(db, monkeypatch, tmp_path):
    p = _ender(db)
    p.state = "printing"
    cam = "http://cam.local/?action=snapshot"
    p.camera_urls = json.dumps([cam, "http://cam2.local/snapshot.jpg"])
    db.commit()
    jpeg = b"\xff\xd8\xff\xe0" + b"FAKEJPEG" * 4

    def fake_get(url, **kwargs):
        return httpx.Response(200, content=jpeg)

    monkeypatch.setattr(oa.httpx, "get", fake_get)
    _mock_adapter(monkeypatch, {
        "state": {"text": "Printing", "flags": {"operational": True,
                                                "printing": True,
                                                "error": False,
                                                "closedOrError": False}},
        "temperature": {},
    }, {"state": "Printing", "progress": {"completion": 10.0},
        "file": {}})
    _poll(monkeypatch, db, [p.id])
    snap0 = Path(settings.storage_dir) / "snapshots" / str(p.id) / "0.jpg"
    snap1 = Path(settings.storage_dir) / "snapshots" / str(p.id) / "1.jpg"
    assert snap0.read_bytes() == jpeg
    assert snap1.read_bytes() == jpeg


def test_no_snapshot_when_idle(db, monkeypatch):
    p = _ender(db)
    p.state = "idle"
    p.camera_urls = json.dumps(["http://cam.local/?action=snapshot"])
    db.commit()
    _mock_adapter(monkeypatch, {
        "state": {"text": "Operational", "flags": {"operational": True,
                                                   "error": False,
                                                   "closedOrError": False}},
        "temperature": {},
    })
    _poll(monkeypatch, db, [p.id])
    snap0 = Path(settings.storage_dir) / "snapshots" / str(p.id) / "0.jpg"
    assert not snap0.exists()


def test_encrypted_key_used_for_poll(db, monkeypatch):
    """El poller descifra la API key antes de llamar al adapter (BE-20)."""
    p = _ender(db)
    p.api_key_encrypted = encrypt_secret("clave-secreta")
    db.commit()
    seen = {}

    def fake_init(self, base_url, api_key=None, timeout=5.0):
        seen["api_key"] = api_key
        self.base_url = base_url
        self.api_key = api_key
        self.timeout = timeout

    monkeypatch.setattr(oa.OctoPrintAdapter, "__init__", fake_init)
    _mock_adapter(monkeypatch, {
        "state": {"text": "Operational", "flags": {}},
        "temperature": {},
    })
    _poll(monkeypatch, db, [p.id])
    assert seen["api_key"] == "clave-secreta"
