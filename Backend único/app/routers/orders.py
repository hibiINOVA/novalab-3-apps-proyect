"""Pedidos: lista, detalle, creación y cambio manual de estado (P-07/P-08)."""

from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy import func, or_, select
from sqlalchemy.orm import Session

from app.db import get_db
from app.deps import get_current_user
from app.events import hub
from app.models import (
    Customer,
    Order,
    OrderItem,
    OrderStatusHistory,
    Product,
)
from app.schemas import (
    DueState,
    OrderCreateRequest,
    OrderDetail,
    OrderItem as OrderItemSchema,
    OrderStatus,
    OrderStatusUpdateRequest,
    OrderSummary,
    Shipment,
    StatusHistoryEntry,
)
from app.security import new_tracking_token, random_folio
from app.services.queue import bump_version
from app.services.state_machine import (
    can_transition,
    derive_status,
    due_state,
)

router = APIRouter(prefix="/api/orders", tags=["orders"])


def _summary(db: Session, order: Order) -> OrderSummary:
    items = db.scalars(
        select(OrderItem).where(OrderItem.order_id == order.id)
    ).all()
    status = derive_status(order, items)
    return OrderSummary(
        id=order.id,
        folio=order.folio,
        customer_name=order.customer.name if order.customer else "Cliente",
        status=status,  # type: ignore[arg-type]
        promised_date=order.promised_date,
        due_state=due_state(order.promised_date),  # type: ignore[arg-type]
        total=order.total,
        items_count=sum(i.quantity for i in items),
        printed_count=sum(i.printed_quantity for i in items),
        created_at=order.created_at,
    )


def _detail(db: Session, order: Order) -> OrderDetail:
    items = db.scalars(
        select(OrderItem).where(OrderItem.order_id == order.id)
    ).all()
    status = derive_status(order, items)
    history = db.scalars(
        select(OrderStatusHistory)
        .where(OrderStatusHistory.order_id == order.id)
        .order_by(OrderStatusHistory.occurred_at)
    ).all()
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
        **_summary(db, order).model_dump(),
        tracking_token=order.tracking_token,
        notes=order.notes,
        customer=order.customer,
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
                printer_id=i.printer_id,
                printer_name=i.printer.name if i.printer else None,
            )
            for i in items
        ],
        history=[
            StatusHistoryEntry(
                status=h.status,
                previous_status=h.previous_status,
                user_name=h.user_name,
                occurred_at=h.occurred_at,
            )
            for h in history
        ],
        shipment=shipment,
    )


@router.get("", operation_id="listOrders", response_model=list[OrderSummary])
def list_orders(
    db: Session = Depends(get_db),
    _user=Depends(get_current_user),
    status: OrderStatus | None = None,
    customer_id: int | None = None,
    q: str | None = Query(default=None, description="Búsqueda folio/cliente"),
    date_from: str | None = None,
    date_to: str | None = None,
    due: DueState | None = None,
):
    query = select(Order).order_by(Order.created_at.desc())
    if customer_id is not None:
        query = query.where(Order.customer_id == customer_id)
    if q:
        like = f"%{q}%"
        query = query.join(Customer, isouter=True).where(
            or_(Order.folio.like(like), Customer.name.like(like))
        )
    orders = db.scalars(query).all()
    summaries = [_summary(db, o) for o in orders]
    if status is not None:
        summaries = [s for s in summaries if s.status == status]
    if due is not None:
        summaries = [s for s in summaries if s.due_state == due]
    return summaries


@router.post("", operation_id="createOrder", response_model=OrderDetail,
             status_code=201)
async def create_order(
    body: OrderCreateRequest,
    db: Session = Depends(get_db),
    _user=Depends(get_current_user),
):
    # Cliente por id o por nombre (crea uno nuevo si hace falta).
    customer = None
    if body.customer_id is not None:
        customer = db.get(Customer, body.customer_id)
    elif body.customer_name:
        customer = Customer(
            name=body.customer_name, phone=body.customer_phone
        )
        db.add(customer)
        db.flush()
    if customer is None:
        raise HTTPException(
            422, {"code": "invalid", "message": "Se requiere un cliente."}
        )

    next_id = db.scalar(select(func.count(Order.id))) + 1
    order = Order(
        folio=random_folio(next_id),
        customer_id=customer.id,
        promised_date=body.promised_date,
        notes=body.notes,
        total=body.total or 0.0,
        tracking_token=new_tracking_token(),
        status="confirmed",
    )
    db.add(order)
    db.flush()

    total = body.total or 0.0
    position = 0
    for inp in body.items:
        product = db.get(Product, inp.product_id)
        if product is None:
            raise HTTPException(
                422, {"code": "invalid",
                      "message": f"Producto {inp.product_id} no existe."}
            )
        item = OrderItem(
            order_id=order.id,
            product_id=inp.product_id,
            color=inp.color,
            quantity=inp.quantity,
            state="pending",
            position=position,
        )
        db.add(item)
        position += 1
        if body.total is None:
            total += (product.base_price or 0.0) * inp.quantity
    order.total = total
    db.add(OrderStatusHistory(order_id=order.id, status="confirmed"))
    db.flush()
    await hub.broadcast("order.created", "order", order.id)
    await hub.broadcast("queue.updated", "queue")
    return _detail(db, order)


@router.get("/{order_id}", operation_id="getOrder",
            response_model=OrderDetail)
def get_order(order_id: int, db: Session = Depends(get_db),
              _user=Depends(get_current_user)):
    order = db.get(Order, order_id)
    if order is None:
        raise HTTPException(404, {"code": "not_found",
                                  "message": "Pedido no encontrado."})
    return _detail(db, order)


@router.patch("/{order_id}/status", operation_id="updateOrderStatus",
              response_model=OrderDetail)
async def update_status(
    order_id: int,
    body: OrderStatusUpdateRequest,
    db: Session = Depends(get_db),
    _user=Depends(get_current_user),
):
    order = db.get(Order, order_id)
    if order is None:
        raise HTTPException(404, {"code": "not_found",
                                  "message": "Pedido no encontrado."})
    items = db.scalars(
        select(OrderItem).where(OrderItem.order_id == order.id)
    ).all()
    current = derive_status(order, items)
    new_status = body.status.value
    if not can_transition(current, new_status):
        raise HTTPException(
            409,
            {"code": "invalid_transition",
             "message": f"No se puede pasar de {current} a {new_status}."},
        )
    order.manual_status = new_status
    order.status = new_status
    if new_status == "shipped" and not order.shipped_at:
        from datetime import date as _date

        order.shipped_at = _date.today()
    if new_status == "delivered" and not order.delivered_at:
        from datetime import date as _date

        order.delivered_at = _date.today()
    db.add(OrderStatusHistory(
        order_id=order.id, status=new_status, previous_status=current
    ))
    db.flush()
    await hub.broadcast("order.updated", "order", order.id,
                        {"status": new_status})
    return _detail(db, order)
