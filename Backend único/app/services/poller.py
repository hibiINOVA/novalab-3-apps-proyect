"""Poller de impresoras OctoPrint (BE-02/BE-03) y snapshots (BE-07).

Tarea asyncio iniciada en el lifespan de `main.py`. Por cada impresora con
`octoprint_url` configurado:
  - consulta `/api/printer` + `/api/job` cada `poll_interval_printing` (5 s)
    si está imprimiendo o `poll_interval_idle` (30 s) en reposo;
  - actualiza estado/progreso/tiempo/temps/`last_seen` y publica por WS;
  - N fallos consecutivos → `offline` (BE-26);
  - si NOVALAB cree que está imprimiendo y OctoPrint reporta job terminado →
    completa el job (BE-04: registra `minutes_real`);
  - mientras haya job activo y cámaras configuradas, guarda el último
    snapshot por impresora/cámara en `data/snapshots/` (BE-07).

Nunca envía G-code desde aquí: el inicio solo ocurre por confirmación
explícita del operador (BE-05).
"""

import asyncio
import logging
import time
from datetime import UTC, datetime

from sqlalchemy import select

from app.config import settings
from app.db import get_session_factory
from app.events import hub
from app.models import PrintJob, Printer
from app.security import decrypt_secret
from app.services.adapters import octoprint as oa
from app.services.camera import camera_urls, fetch_snapshot, snapshots_dir
from app.services.jobs import complete_job

log = logging.getLogger("novalab.poller")

# Fallos consecutivos por printer_id → offline tras umbral (BE-26).
_failures: dict[int, int] = {}
OFFLINE_AFTER = 3


async def poll_once(printer_ids: list[int] | None = None) -> None:
    """Una pasada de polling (todas las impresoras con adapter o solo `ids`)."""
    factory = get_session_factory()
    db = factory()
    try:
        stmt = select(Printer).where(Printer.octoprint_url.is_not(None))
        if printer_ids is not None:
            stmt = stmt.where(Printer.id.in_(printer_ids))
        printers = db.scalars(stmt).all()
        for printer in printers:
            try:
                await _poll_printer(db, printer)
            except Exception:
                log.exception("poller: error con %s", printer.name)
        db.commit()
    finally:
        db.close()


async def _poll_printer(db, printer: Printer) -> None:
    api_key = decrypt_secret(printer.api_key_encrypted)
    adapter = oa.OctoPrintAdapter(printer.octoprint_url or "", api_key)
    try:
        # httpx síncrono → thread para no bloquear el event loop.
        printer_info, job_info = await asyncio.gather(
            asyncio.to_thread(adapter.get_printer),
            asyncio.to_thread(adapter.get_job),
        )
    except oa.OctoPrintError:
        _failures[printer.id] = _failures.get(printer.id, 0) + 1
        if (_failures[printer.id] >= OFFLINE_AFTER
                and printer.state != "offline"):
            printer.state = "offline"
            db.flush()
            await hub.broadcast("printer.state", "printer", printer.id,
                                {"state": "offline"})
        return

    _failures[printer.id] = 0
    printer.last_seen = datetime.now(UTC)
    new_state = oa.map_state(printer_info, job_info)
    parsed = oa.parse_job(job_info)
    temps = oa.parse_temps(printer_info)

    # BE-04: NOVALAB creía imprimiendo pero OctoPrint reporta terminado.
    active_job = db.scalar(
        select(PrintJob).where(PrintJob.printer_id == printer.id,
                               PrintJob.state == "printing")
    )
    if (active_job is not None and printer.state == "printing"
            and new_state == "idle"):
        complete_job(db, active_job)
        await hub.broadcast("print_job.completed", "print_job", active_job.id,
                            {"item_id": active_job.item_id})
        await hub.broadcast("printer.state", "printer", printer.id,
                            {"state": printer.state})
        return

    changed = printer.state != new_state
    printer.state = new_state
    printer.progress = parsed["progress"]
    printer.remaining_seconds = parsed["remaining_seconds"]
    printer.nozzle_temp = temps["nozzle_temp"]
    printer.nozzle_target = temps["nozzle_target"]
    printer.bed_temp = temps["bed_temp"]
    printer.bed_target = temps["bed_target"]
    if parsed["current_file"]:
        printer.current_file = parsed["current_file"]
    db.flush()
    if changed:
        await hub.broadcast("printer.state", "printer", printer.id,
                            {"state": printer.state})

    # BE-07: snapshot solo mientras haya un job activo.
    if printer.state == "printing" and camera_urls(printer):
        await asyncio.to_thread(_refresh_snapshots, printer)


def _refresh_snapshots(printer: Printer) -> None:
    for index in range(len(camera_urls(printer))):
        data = fetch_snapshot(printer, index)
        if data:
            target = snapshots_dir() / str(printer.id) / f"{index}.jpg"
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(data)


async def poller_loop() -> None:
    """Bucle infinito: tick cada segundo; cada printer respeta su intervalo."""
    next_due: dict[int, float] = {}
    while True:
        now = time.monotonic()
        factory = get_session_factory()
        db = factory()
        try:
            printers = db.scalars(
                select(Printer).where(Printer.octoprint_url.is_not(None))
            ).all()
            due_ids = []
            for p in printers:
                interval = (settings.poll_interval_printing
                            if p.state == "printing"
                            else settings.poll_interval_idle)
                if now >= next_due.get(p.id, 0.0):
                    due_ids.append(p.id)
                    next_due[p.id] = now + interval
        finally:
            db.close()
        if due_ids:
            await poll_once(due_ids)
        await asyncio.sleep(1.0)
