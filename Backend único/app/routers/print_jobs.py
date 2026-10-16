"""Impresión: start (BE-05), complete, fail, reprint. Nunca auto-inicia."""

from datetime import UTC, datetime

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.db import get_db
from app.deps import get_current_user
from app.events import hub
from app.models import OrderItem, PrintJob, Printer
from app.schemas import (
    PrintJob as PrintJobSchema,
    PrintJobFailRequest,
    PrintJobStartRequest,
)
from app.services.queue import bump_version

router = APIRouter(prefix="/api/print-jobs", tags=["print-jobs"])


def _job_schema(job: PrintJob) -> PrintJobSchema:
    return PrintJobSchema(
        id=job.id,
        item_id=job.item_id,
        printer_id=job.printer_id,
        printer_name=job.printer.name if job.printer else None,
        state=job.state,  # type: ignore[arg-type]
        started_at=job.started_at,
        finished_at=job.finished_at,
        grams_real=job.grams_real,
        minutes_real=job.minutes_real,
        failure_reason=job.failure_reason,
    )


@router.post("", operation_id="startPrintJob", response_model=PrintJobSchema,
             status_code=201)
async def start(body: PrintJobStartRequest, db: Session = Depends(get_db),
                _user=Depends(get_current_user)):
    """BE-05: solo con confirmación explícita (el frontend ya la pidió)."""
    item = db.get(OrderItem, body.item_id)
    printer = db.get(Printer, body.printer_id)
    if item is None or printer is None:
        raise HTTPException(404, {"code": "not_found",
                                  "message": "Item o impresora no encontrados."})
    if printer.state not in ("idle", "paused"):
        raise HTTPException(
            409,
            {"code": "printer_unavailable",
             "message": f"{printer.name} no está disponible."},
        )
    # Marca el item como imprimiendo y asigna la impresora.
    item.printer_id = printer.id
    item.state = "printing"
    printer.state = "printing"
    printer.current_file = item.product.name
    printer.progress = 0.0
    job = PrintJob(
        item_id=item.id,
        printer_id=printer.id,
        state="printing",
        started_at=datetime.now(UTC),
    )
    db.add(job)
    db.flush()
    version = bump_version(db)
    await hub.broadcast("print_job.started", "print_job", job.id,
                        {"item_id": item.id, "printer_id": printer.id})
    await hub.broadcast("printer.state", "printer", printer.id,
                        {"state": printer.state})
    await hub.broadcast("queue.updated", "queue", payload={"version": version})
    return _job_schema(job)


@router.post("/{job_id}/complete", operation_id="completePrintJob",
             response_model=PrintJobSchema)
async def complete(job_id: int, db: Session = Depends(get_db),
                   _user=Depends(get_current_user)):
    job = db.get(PrintJob, job_id)
    if job is None:
        raise HTTPException(404, {"code": "not_found",
                                  "message": "Job no encontrado."})
    job.state = "printed"
    job.finished_at = datetime.now(UTC)
    # BE-12: unidad completada → printed_quantity += 1.
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
    db.flush()
    version = bump_version(db)
    await hub.broadcast("print_job.completed", "print_job", job.id,
                        {"item_id": job.item_id})
    await hub.broadcast("printer.state", "printer", printer.id,
                        {"state": printer.state})
    await hub.broadcast("queue.updated", "queue", payload={"version": version})
    return _job_schema(job)


@router.post("/{job_id}/fail", operation_id="failPrintJob",
             response_model=PrintJobSchema)
async def fail(job_id: int, body: PrintJobFailRequest,
               db: Session = Depends(get_db),
               _user=Depends(get_current_user)):
    job = db.get(PrintJob, job_id)
    if job is None:
        raise HTTPException(404, {"code": "not_found",
                                  "message": "Job no encontrado."})
    job.state = "failed"
    job.finished_at = datetime.now(UTC)
    job.failure_reason = body.reason
    item = job.item
    item.state = "failed"
    item.printer_id = None
    printer = job.printer
    if printer.state == "printing":
        printer.state = "idle"
        printer.current_file = None
        printer.progress = None
    db.flush()
    version = bump_version(db)
    await hub.broadcast("print_job.failed", "print_job", job.id,
                        {"item_id": job.item_id, "reason": body.reason})
    await hub.broadcast("printer.state", "printer", printer.id,
                        {"state": printer.state})
    await hub.broadcast("queue.updated", "queue", payload={"version": version})
    return _job_schema(job)


@router.post("/{job_id}/reprint", operation_id="reprintJob",
             response_model=PrintJobSchema, status_code=201)
async def reprint(job_id: int, db: Session = Depends(get_db),
                  _user=Depends(get_current_user)):
    """P-10: reimpresión crea un job nuevo en `queued` (no lo auto-inicia)."""
    old = db.get(PrintJob, job_id)
    if old is None:
        raise HTTPException(404, {"code": "not_found",
                                  "message": "Job no encontrado."})
    item = old.item
    item.state = "queued"
    item.printer_id = old.printer_id
    job = PrintJob(item_id=item.id, printer_id=old.printer_id, state="queued")
    db.add(job)
    db.flush()
    version = bump_version(db)
    await hub.broadcast("print_job.queued", "print_job", job.id,
                        {"item_id": item.id})
    await hub.broadcast("queue.updated", "queue", payload={"version": version})
    return _job_schema(job)
