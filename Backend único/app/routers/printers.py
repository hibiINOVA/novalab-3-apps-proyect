"""Impresoras: `GET /api/printers` y snapshot de cámara."""

from fastapi import APIRouter, Depends, HTTPException, Response
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.db import get_db
from app.deps import get_current_user
from app.models import OrderItem, Printer
from app.schemas import OrderRef, Printer as PrinterSchema, SpoolRef
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


def to_printer_schema(db: Session, p: Printer) -> PrinterSchema:
    return PrinterSchema(
        id=p.id,
        name=p.name,
        state=p.state,  # type: ignore[arg-type]
        progress=p.progress,
        remaining_seconds=p.remaining_seconds,
        nozzle_temp=p.nozzle_temp,
        nozzle_target=p.nozzle_target,
        bed_temp=p.bed_temp,
        bed_target=p.bed_target,
        current_file=p.current_file,
        camera_available=p.camera_available,
        loaded_spool=SpoolRef.model_validate(p.loaded_spool)
        if p.loaded_spool else None,
        current_order=_order_ref(db, p.id),
        last_seen=p.last_seen,
    )


@router.get("", operation_id="listPrinters", response_model=list[PrinterSchema],
            dependencies=[Depends(get_current_user)])
def list_printers(db: Session = Depends(get_db)):
    printers = db.scalars(select(Printer).order_by(Printer.id)).all()
    return [to_printer_schema(db, p) for p in printers]


@router.get("/{printer_id}/camera/snapshot",
            operation_id="getPrinterCameraSnapshot",
            dependencies=[Depends(get_current_user)])
def camera_snapshot(printer_id: int, db: Session = Depends(get_db)):
    """BE-09: el cliente recibe el snapshot del backend, nunca la IP."""
    printer = db.get(Printer, printer_id)
    if printer is None:
        raise HTTPException(404, {"code": "not_found",
                                  "message": "Impresora no encontrada."})
    data = get_snapshot(db, printer_id)
    if data is None:
        return Response(status_code=204)
    media = "image/jpeg" if data[:2] == b"\xff\xd8" else "image/png"
    return Response(content=data, media_type=media)
