"""Impresión: start (BE-05), complete, fail, reprint, gcode. Nunca auto-inicia.

Cuando la impresora tiene OctoPrint configurado, la subida del G-code lo
envía e inicia físicamente (BE-05/BE-06). El inicio solo ocurre por petición
explícita del operador (la confirmación la pide el frontend, P-05).
"""

from datetime import UTC, datetime

from fastapi import APIRouter, Depends, File, HTTPException, UploadFile
from fastapi.responses import FileResponse
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
from app.security import decrypt_secret
from app.services.adapters.octoprint import OctoPrintAdapter, OctoPrintError
from app.services.jobs import complete_job, fail_job
from app.services.queue import bump_version
from app.storage import (
    GCODE_EXTENSIONS,
    MAX_GCODE_BYTES,
    read_upload,
    save_file,
    storage_dir,
)

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
        current_file=job.current_file,
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


@router.post("/{job_id}/gcode", operation_id="uploadPrintJobGcode",
             response_model=PrintJobSchema)
async def upload_gcode(job_id: int, file: UploadFile = File(...),
                       db: Session = Depends(get_db),
                       _user=Depends(get_current_user)):
    """BE-05: asocia un .gcode al job; si la impresora tiene OctoPrint, lo
    envía e inicia (solo tras la confirmación explícita del start)."""
    job = db.get(PrintJob, job_id)
    if job is None:
        raise HTTPException(404, {"code": "not_found",
                                  "message": "Job no encontrado."})
    filename, data = await read_upload(file, MAX_GCODE_BYTES,
                                       GCODE_EXTENSIONS, "gcode")
    path = save_file(f"gcode/{job.id}", filename, data)
    job.current_file = filename
    printer = job.printer
    if printer is not None:
        printer.current_file = filename
    db.flush()
    # Envío físico (BE-05/BE-06): solo a job en curso con adapter configurado.
    if (printer is not None and printer.octoprint_url
            and job.state == "printing"):
        api_key = decrypt_secret(printer.api_key_encrypted)
        try:
            OctoPrintAdapter(printer.octoprint_url, api_key).upload_and_start(
                path, filename
            )
        except OctoPrintError as exc:
            fail_job(db, job, f"OctoPrint rechazó el archivo: {exc}")
            await hub.broadcast("print_job.failed", "print_job", job.id,
                                {"item_id": job.item_id, "reason": str(exc)})
            await hub.broadcast("printer.state", "printer", printer.id,
                                {"state": printer.state})
            raise HTTPException(
                502,
                {"code": "octoprint_error",
                 "message": f"No se pudo enviar a la impresora: {exc}"},
            )
    return _job_schema(job)


@router.get("/{job_id}/gcode", operation_id="downloadPrintJobGcode")
def download_gcode(job_id: int, db: Session = Depends(get_db),
                   _user=Depends(get_current_user)):
    job = db.get(PrintJob, job_id)
    if job is None or not job.current_file:
        raise HTTPException(404, {"code": "not_found",
                                  "message": "Job sin archivo G-code."})
    path = storage_dir() / "gcode" / str(job.id) / job.current_file
    if not path.is_file():
        raise HTTPException(404, {"code": "not_found",
                                  "message": "Archivo G-code no encontrado."})
    return FileResponse(path, media_type="application/octet-stream",
                        filename=job.current_file)


@router.post("/{job_id}/complete", operation_id="completePrintJob",
             response_model=PrintJobSchema)
async def complete(job_id: int, db: Session = Depends(get_db),
                   _user=Depends(get_current_user)):
    job = db.get(PrintJob, job_id)
    if job is None:
        raise HTTPException(404, {"code": "not_found",
                                  "message": "Job no encontrado."})
    version = complete_job(db, job)
    await hub.broadcast("print_job.completed", "print_job", job.id,
                        {"item_id": job.item_id})
    await hub.broadcast("printer.state", "printer", job.printer_id,
                        {"state": job.printer.state})
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
    version = fail_job(db, job, body.reason)
    await hub.broadcast("print_job.failed", "print_job", job.id,
                        {"item_id": job.item_id, "reason": body.reason})
    await hub.broadcast("printer.state", "printer", job.printer_id,
                        {"state": job.printer.state})
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
