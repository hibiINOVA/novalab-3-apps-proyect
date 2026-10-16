"""API pública (BE-21/BE-22): solo datos propios del cliente, nunca costos ni
otros clientes. Anónima con rate limit (BE-19)."""

from fastapi import APIRouter, Depends, HTTPException, Request, Response
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.db import get_db
from app.deps import limit_lookup, limit_public
from app.models import Business, Order, OrderItem
from app.schemas import (
    Branding,
    OrderDetail,
    OrderItem as OrderItemSchema,
    PublicLookupRequest,
    PublicLookupResponse,
    Shipment,
    StatusHistoryEntry,
)
from app.services.camera import get_public_snapshot
from app.services.state_machine import derive_status, due_state

router = APIRouter(prefix="/api/public", tags=["public"])


@router.get("/branding", operation_id="getBranding", response_model=Branding)
def branding(db: Session = Depends(get_db), _=Depends(limit_public)):
    b = db.scalar(select(Business).limit(1))
    if b is None:
        return Branding(business_name="NOVALAB", primary_color="#0B132B",
                        accent_color="#00FF87", background_color="#FFFFFF",
                        currency="MXN", timezone="America/Mexico_City",
                        language="es-MX")
    return Branding.model_validate(b)


def _history_rows(order: Order, current: str) -> list[StatusHistoryEntry]:
    """Timeline (C-02): solo hasta el estado actual."""
    timeline = ["confirmed", "queued", "printing", "printed", "packed",
                "shipped", "delivered"]
    if current == "cancelled":
        timeline = ["confirmed", "cancelled"]
    rows: list[StatusHistoryEntry] = []
    for s in timeline:
        rows.append(StatusHistoryEntry(status=s, occurred_at=order.created_at))
        if s == current:
            break
    return rows


def build_public_order(order: Order, items: list[OrderItem]) -> OrderDetail:
    """BE-22: nunca costos/ganancias ni datos de otros clientes."""
    status = derive_status(order, items)
    shipment = None
    if order.carrier:
        shipment = Shipment(
            carrier=order.carrier,
            tracking_number=order.tracking_number,
            tracking_url=order.tracking_url,
            shipped_at=order.shipped_at,
            delivered_at=order.delivered_at,
        )
    return OrderDetail(
        id=order.id,
        folio=order.folio,
        customer_name=order.customer.name if order.customer else "Cliente",
        status=status,
        promised_date=order.promised_date,
        due_state=due_state(order.promised_date),  # type: ignore[arg-type]
        total=order.total,
        items_count=sum(i.quantity for i in items),
        printed_count=sum(i.printed_quantity for i in items),
        created_at=order.created_at,
        tracking_token=order.tracking_token,
        notes=None,  # notas internas no se exponen públicamente
        customer=None,  # nunca datos personales extra
        items=[
            OrderItemSchema(
                id=i.id,
                product_id=i.product_id,
                product_name=i.product.name,
                color=i.color or i.product.color,
                quantity=i.quantity,
                printed_quantity=i.printed_quantity,
                missing_quantity=max(0, i.quantity - i.printed_quantity),
                state=i.state,  # type: ignore[arg-type]
                printer_id=None,  # no exponer impresora interna
                printer_name=None,
            )
            for i in items
        ],
        history=_history_rows(order, status),
        shipment=shipment,
    )


@router.get("/track/{token}", operation_id="getPublicTrack",
            response_model=OrderDetail)
def track(token: str, db: Session = Depends(get_db),
          _=Depends(limit_public)):
    order = db.scalar(select(Order).where(Order.tracking_token == token))
    if order is None:
        raise HTTPException(404, {"code": "not_found",
                                  "message": "Seguimiento no encontrado."})
    items = db.scalars(
        select(OrderItem).where(OrderItem.order_id == order.id)
    ).all()
    return build_public_order(order, items)


@router.get("/track/{token}/camera", operation_id="getPublicTrackCamera")
def track_camera(token: str, db: Session = Depends(get_db),
                 _=Depends(limit_public)):
    """Snapshot JPEG del job activo del pedido (C-06). 204 si no hay."""
    order = db.scalar(select(Order).where(Order.tracking_token == token))
    if order is None:
        raise HTTPException(404, {"code": "not_found",
                                  "message": "Seguimiento no encontrado."})
    image = get_public_snapshot(db, order.id)
    if image is None:
        return Response(status_code=204)
    return Response(content=image, media_type="image/jpeg")


@router.post("/lookup", operation_id="lookupOrderToken",
             response_model=PublicLookupResponse)
def lookup(body: PublicLookupRequest, request: Request,
           db: Session = Depends(get_db)):
    """C-01: folio + últimos 4 dígitos del teléfono → token de seguimiento."""
    limit_lookup(request)
    orders = db.scalars(
        select(Order).join(Order.customer).where(Order.folio == body.folio)
    ).all()
    for order in orders:
        phone = order.customer.phone if order.customer else None
        if phone and phone.replace(" ", "").endswith(body.phone_last4):
            return PublicLookupResponse(tracking_token=order.tracking_token)
    raise HTTPException(
        404,
        {"code": "not_found", "message": "Pedido no encontrado."},
    )
