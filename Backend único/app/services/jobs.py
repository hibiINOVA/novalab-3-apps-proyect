"""Ciclo de vida de jobs (BE-04/BE-05/BE-12): complete/fail compartidos
entre el router de print_jobs y el poller OctoPrint."""

from datetime import UTC, datetime

from sqlalchemy.orm import Session

from app.models import PrintJob
from app.services.queue import bump_version


def complete_job(db: Session, job: PrintJob) -> int:
    """BE-04: registra tiempo real y avanza el item (BE-12). Devuelve versión."""
    now = datetime.now(UTC)
    job.state = "printed"
    job.finished_at = now
    if job.started_at is not None:
        started = job.started_at
        if started.tzinfo is None:  # SQLite guarda naive; asumir UTC
            started = started.replace(tzinfo=UTC)
        job.minutes_real = max(0, int((now - started).total_seconds() // 60))
    item = job.item
    item.printed_quantity = min(item.quantity, item.printed_quantity + 1)
    if item.printed_quantity >= item.quantity:
        item.state = "printed"
    else:
        item.state = "pending"  # aún faltan unidades
        item.printer_id = None
    printer = job.printer
    if printer.state == "printing":
        printer.state = "idle"
        printer.current_file = None
        printer.progress = None
        printer.remaining_seconds = None
    db.flush()
    return bump_version(db)


def fail_job(db: Session, job: PrintJob, reason: str) -> int:
    """Falla un job y libera la impresora. Devuelve versión de cola."""
    job.state = "failed"
    job.finished_at = datetime.now(UTC)
    job.failure_reason = reason
    item = job.item
    item.state = "failed"
    item.printer_id = None
    printer = job.printer
    if printer.state == "printing":
        printer.state = "idle"
        printer.current_file = None
        printer.progress = None
        printer.remaining_seconds = None
    db.flush()
    return bump_version(db)
