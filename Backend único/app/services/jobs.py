"""Ciclo de vida de jobs (BE-04/BE-05/BE-12): complete/fail compartidos
entre el router de print_jobs y el poller OctoPrint."""

from datetime import UTC, datetime

from sqlalchemy.orm import Session

from app.models import PrintJob
from app.services.queue import bump_version


def register_consumption(db: Session, job: PrintJob) -> None:
    """BE-04: registra gramos reales (si faltan) y descuenta del spool cargado.

    Idempotente: solo actúa la primera vez que el job termina
    (`finished_at` aún sin definir).
    """
    if job.finished_at is not None:
        return
    item = job.item
    if job.grams_real is None:
        job.grams_real = item.product.estimated_weight_g or 0.0
    printer = job.printer
    spool = printer.loaded_spool if printer is not None else None
    if spool is not None and job.grams_real:
        spool.grams_remaining = max(
            0.0, spool.grams_remaining - float(job.grams_real)
        )


def complete_job(db: Session, job: PrintJob) -> int:
    """BE-04: registra tiempo real y avanza el item (BE-12). Devuelve versión."""
    now = datetime.now(UTC)
    register_consumption(db, job)
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
    return bump_version(db, job.organization_id)


def fail_job(db: Session, job: PrintJob, reason: str) -> int:
    """Falla un job y libera la impresora. Devuelve versión de cola."""
    register_consumption(db, job)
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
    return bump_version(db, job.organization_id)
