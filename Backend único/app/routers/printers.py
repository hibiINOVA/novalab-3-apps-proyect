"""Impresoras: CRUD, prueba de conexión (BE-01) y snapshot de cámara."""

import json

from fastapi import APIRouter, Depends, HTTPException, Response
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.db import get_db
from app.deps import get_current_user
from app.events import hub
from app.models import OrderItem, Printer
from app.schemas import (
    OrderRef,
    Printer as PrinterSchema,
    PrinterConnectionTest,
    PrinterConnectionTestRequest,
    PrinterCreateRequest,
    PrinterUpdateRequest,
    SpoolRef,
)
from app.security import decrypt_secret, encrypt_secret
from app.services.adapters.octoprint import OctoPrintAdapter, OctoPrintError
from app.services.camera import get_snapshot
from app.services.state_machine import derive_status  # noqa: F401 (deriva order ref)

router = APIRouter(prefix="/api/printers", tags=["printers"])


def _order_ref(db: Session, printer_id: int) -> OrderRef | None:
    item = db.scalar(
        select(OrderItem)
        .where(OrderItem.printer_id == printer_id,
               OrderItem.state == "printing")
        .limit(1)
    )
    if item is None:
        return None
    order = item.order
    return OrderRef(
        id=order.id,
        folio=order.folio,
        customer_name=order.customer.name if order.customer else "Cliente",
        promised_date=order.promised_date,
    )


def _camera_urls(p: Printer) -> list[str]:
    if p.camera_urls:
        try:
            urls = json.loads(p.camera_urls)
            if isinstance(urls, list):
                return [str(u) for u in urls]
        except ValueError:
            pass
    return [p.snapshot_url] if p.snapshot_url else []


def to_printer_schema(db: Session, p: Printer) -> PrinterSchema:
    return PrinterSchema(
        id=p.id,
        name=p.name,
        model=p.model,
        state=p.state,  # type: ignore[arg-type]
        progress=p.progress,
        remaining_seconds=p.remaining_seconds,
        nozzle_temp=p.nozzle_temp,
        nozzle_target=p.nozzle_target,
        bed_temp=p.bed_temp,
        bed_target=p.bed_target,
        current_file=p.current_file,
        camera_available=p.camera_available,
        cameras=_camera_urls(p),
        loaded_spool=SpoolRef.model_validate(p.loaded_spool)
        if p.loaded_spool else None,
        current_order=_order_ref(db, p.id),
        last_seen=p.last_seen,
    )


async def _test_octoprint(url: str, api_key: str | None) -> PrinterConnectionTest:
    try:
        adapter = OctoPrintAdapter(url, api_key)
        version = adapter.test_connection()
        str_version = version.get("server") if isinstance(version, dict) else None
        return PrinterConnectionTest(
            ok=True,
            message="Conexión exitosa con OctoPrint.",
            version=str_version,
        )
    except OctoPrintError as exc:
        return PrinterConnectionTest(ok=False, message=str(exc))


@router.get("", operation_id="listPrinters", response_model=list[PrinterSchema],
            dependencies=[Depends(get_current_user)])
def list_printers(db: Session = Depends(get_db)):
    printers = db.scalars(select(Printer).order_by(Printer.id)).all()
    return [to_printer_schema(db, p) for p in printers]


@router.post("", operation_id="createPrinter", response_model=PrinterSchema,
             status_code=201, dependencies=[Depends(get_current_user)])
async def create_printer(body: PrinterCreateRequest, db: Session = Depends(get_db)):
    printer = Printer(
        name=body.name,
        model=body.model,
        octoprint_url=body.octoprint_url,
        api_key_encrypted=encrypt_secret(body.api_key),  # BE-20
        camera_urls=json.dumps(body.cameras) if body.cameras else None,
        bed_width=body.bed_width,
        bed_depth=body.bed_depth,
        camera_available=body.camera_available,
        state="idle",
    )
    db.add(printer)
    db.flush()
    await hub.broadcast("printer.created", "printer", printer.id)
    return to_printer_schema(db, printer)


@router.post("/test", operation_id="testPrinterConnection",
             response_model=PrinterConnectionTest,
             dependencies=[Depends(get_current_user)])
async def test_connection(body: PrinterConnectionTestRequest):
    """BE-01: probar URL + API key antes de dar de alta la impresora."""
    return await _test_octoprint(body.octoprint_url, body.api_key)


@router.post("/{printer_id}/test", operation_id="testPrinterConnectionById",
             response_model=PrinterConnectionTest,
             dependencies=[Depends(get_current_user)])
async def test_connection_stored(printer_id: int, db: Session = Depends(get_db)):
    """BE-01: probar la conexión guardada de una impresora existente."""
    printer = db.get(Printer, printer_id)
    if printer is None or not printer.octoprint_url:
        raise HTTPException(
            404,
            {"code": "not_found",
             "message": "Impresora sin URL de OctoPrint configurada."},
        )
    api_key = decrypt_secret(printer.api_key_encrypted)
    return await _test_octoprint(printer.octoprint_url, api_key)


@router.get("/{printer_id}", operation_id="getPrinter", response_model=PrinterSchema,
            dependencies=[Depends(get_current_user)])
def get_printer(printer_id: int, db: Session = Depends(get_db)):
    printer = db.get(Printer, printer_id)
    if printer is None:
        raise HTTPException(404, {"code": "not_found", "message": "Impresora no encontrada."})
    return to_printer_schema(db, printer)


@router.patch("/{printer_id}", operation_id="updatePrinter", response_model=PrinterSchema,
              dependencies=[Depends(get_current_user)])
async def update_printer(printer_id: int, body: PrinterUpdateRequest, db: Session = Depends(get_db)):
    printer = db.get(Printer, printer_id)
    if printer is None:
        raise HTTPException(404, {"code": "not_found", "message": "Impresora no encontrada."})
    if body.name is not None:
        printer.name = body.name
    if body.model is not None:
        printer.model = body.model
    if body.octoprint_url is not None:
        printer.octoprint_url = body.octoprint_url
    if body.api_key is not None:
        printer.api_key_encrypted = encrypt_secret(body.api_key)  # BE-20
    if body.bed_width is not None:
        printer.bed_width = body.bed_width
    if body.bed_depth is not None:
        printer.bed_depth = body.bed_depth
    if body.camera_available is not None:
        printer.camera_available = body.camera_available
    if body.cameras is not None:
        printer.camera_urls = json.dumps(body.cameras) if body.cameras else None
    if body.state is not None:
        printer.state = body.state.value
    db.flush()
    await hub.broadcast("printer.updated", "printer", printer.id)
    return to_printer_schema(db, printer)


@router.delete("/{printer_id}", operation_id="deletePrinter", status_code=204,
               dependencies=[Depends(get_current_user)])
async def delete_printer(printer_id: int, db: Session = Depends(get_db)):
    printer = db.get(Printer, printer_id)
    if printer is None:
        raise HTTPException(404, {"code": "not_found", "message": "Impresora no encontrada."})
    
    # Desasignar items de cola asociados si estuvieran en esta impresora
    items = db.scalars(select(OrderItem).where(OrderItem.printer_id == printer_id)).all()
    for item in items:
        item.printer_id = None
        if item.state == "printing":
            item.state = "queued"

    db.delete(printer)
    db.flush()
    await hub.broadcast("printer.deleted", "printer", printer_id)
    await hub.broadcast("queue.updated", "queue")
    return Response(status_code=204)


@router.get("/{printer_id}/camera/snapshot",
            operation_id="getPrinterCameraSnapshot",
            dependencies=[Depends(get_current_user)])
def camera_snapshot(printer_id: int, index: int = 0,
                    db: Session = Depends(get_db)):
    """BE-09: el cliente recibe el snapshot del backend, nunca la IP.

    `index` selecciona la cámara (0 = principal; BE-07 multi-cámara).
    """
    printer = db.get(Printer, printer_id)
    if printer is None:
        raise HTTPException(404, {"code": "not_found",
                                  "message": "Impresora no encontrada."})
    data = get_snapshot(db, printer_id, index=index)
    if data is None:
        return Response(status_code=204)
    media = "image/jpeg" if data[:2] == b"\xff\xd8" else "image/png"
    return Response(content=data, media_type=media)
