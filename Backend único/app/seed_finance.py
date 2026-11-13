"""Datos de demo de finanzas (F-04..F-11) para ver el panel con vida.

Crea, en la org demo (`ORG-NOVA-101`), 6 meses de pedidos con jobs
impresos/fallidos (→ material y luz), gastos por categoría (empaque, envío,
luz, comisiones, mantenimiento) y metas mensuales. Idempotente: marca
`settings.finance_demo_seeded`.

NO se llama desde `seed_demo` (los tests asumen el seed base). Ejecutar a
mano:

    python -m app.seed_finance
"""

from datetime import UTC, date, datetime, timedelta
from zoneinfo import ZoneInfo

from sqlalchemy import func, select
from sqlalchemy.orm import Session

from app.config import settings
from app.db import Base, get_engine, get_session_factory, init_db
from app.models import (
    Customer,
    Expense,
    MonthlyGoal,
    Organization,
    Order,
    OrderItem,
    OrderStatusHistory,
    PrintJob,
    Printer,
    Product,
    Setting,
)
from app.security import new_tracking_token

_FLAG = "finance_demo_seeded"
_TZ = ZoneInfo("America/Mexico_City")


def _month_start_utc(year: int, month: int) -> datetime:
    """15 de mes a mediodía local → UTC naive (cae siempre dentro del mes)."""
    local = datetime(year, month, 15, 12, 30, tzinfo=_TZ)
    return local.astimezone(UTC).replace(tzinfo=None)


def _add_month(year: int, month: int, delta: int) -> tuple[int, int]:
    idx = year * 12 + (month - 1) + delta
    return idx // 12, idx % 12 + 1


def seed_finance(db: Session) -> None:
    flag = db.scalar(
        select(Setting.value).where(Setting.key == _FLAG)
    )
    if flag is not None:
        print("seed_finance: ya estaba inyectado, nada que hacer.")
        return

    org = db.scalar(
        select(Organization).where(Organization.code == "ORG-NOVA-101")
    ) or db.scalar(select(Organization).order_by(Organization.id))
    if org is None:
        print("seed_finance: sin organización; corre antes el seed demo.")
        return

    products = list(db.scalars(
        select(Product).where(Product.organization_id == org.id)
        .order_by(Product.id)
    ).all())
    customers = list(db.scalars(
        select(Customer).where(Customer.organization_id == org.id)
        .order_by(Customer.id)
    ).all())
    printers = list(db.scalars(
        select(Printer).where(Printer.organization_id == org.id)
        .order_by(Printer.id)
    ).all())
    if not products or not customers or not printers:
        print("seed_finance: faltan productos/clientes/impresoras.")
        return

    now = datetime.now(UTC)
    local_now = now.astimezone(_TZ)
    year, month = local_now.year, local_now.month
    total_orders = db.scalar(
        select(func.count(Order.id)).where(Order.organization_id == org.id)
    ) or 0

    created_orders: list[Order] = []
    expenses: list[Expense] = []

    def make_order(created: datetime, prod_idx: int, qty: int,
                   manual: str | None, job_state: str | None) -> Order:
        nonlocal total_orders
        product = products[prod_idx % len(products)]
        customer = customers[prod_idx % len(customers)]
        printer = printers[prod_idx % len(printers)]
        total_orders += 1
        order = Order(
            folio=f"NL-{total_orders}",
            organization_id=org.id,
            customer_id=customer.id,
            status="confirmed",
            manual_status=manual,
            promised_date=(created + timedelta(days=7)).date(),
            total=product.base_price * qty,
            tracking_token=new_tracking_token(),
            created_at=created,
        )
        db.add(order)
        db.flush()
        item = OrderItem(
            organization_id=org.id,
            order_id=order.id,
            product_id=product.id,
            quantity=qty,
            printed_quantity=(qty if job_state == "printed" else 0),
            state=("printed" if job_state == "printed"
                   else ("failed" if job_state == "failed" else "pending")),
            printer_id=(printer.id if job_state else None),
            position=0,
            estimated_minutes=product.estimated_minutes,
        )
        db.add(item)
        db.flush()
        db.add(OrderStatusHistory(
            organization_id=org.id, order_id=order.id, status="confirmed",
            user_name="Demo Finanzas", occurred_at=created,
        ))
        if job_state:
            for unit in range(qty if job_state == "printed" else 1):
                minutes = product.estimated_minutes or 30
                started = created + timedelta(hours=2 + unit)
                job = PrintJob(
                    organization_id=org.id,
                    item_id=item.id,
                    printer_id=printer.id,
                    state=job_state,
                    started_at=started,
                    finished_at=started + timedelta(minutes=minutes),
                    grams_real=product.estimated_weight_g or 20.0,
                    minutes_real=minutes,
                    failure_reason=("Filamento atascado"
                                    if job_state == "failed" else None),
                )
                db.add(job)
        created_orders.append(order)
        return order

    # --- 5 meses atrás + el actual -----------------------------------------
    for offset in range(5, -1, -1):
        y, m = _add_month(year, month, -offset)
        base = _month_start_utc(y, m)
        # 1) entregado con trabajos impresos (material + luz reales)
        make_order(base, offset, 2, "delivered", "printed")
        # 2) empacado con un job impreso
        make_order(base, offset + 1, 1, "packed", "printed")
        # 3) fallido (2 meses) o cancelado (para ver ingreso 0)
        if offset in (1, 3, 5):
            make_order(base + timedelta(hours=6), offset + 2, 1,
                       None, "failed")
        else:
            make_order(base + timedelta(days=10), offset + 2, 1,
                       "cancelled", None)

        # --- gastos del mes (mayoría sin pedido → suman al resumen) --------
        delivered = created_orders[-3]
        expenses += [
            Expense(organization_id=org.id, date=date(y, m, 8),
                    category="luz", amount=180.0 + offset * 12),
            Expense(organization_id=org.id, date=date(y, m, 12),
                    category="empaque", amount=90.0 + offset * 8),
            # envío ligado al pedido empacado (entra en su desglose)
            Expense(organization_id=org.id, date=date(y, m, 18),
                    category="envio", amount=75.0 + offset * 4,
                    order_id=created_orders[-2].id),
            Expense(organization_id=org.id, date=date(y, m, 22),
                    category="comisiones",
                    amount=round(delivered.total * 0.03, 2)),
        ]
        if offset in (2, 4):  # mantenimiento puntual → meses en rojo
            expenses.append(Expense(
                organization_id=org.id, date=date(y, m, 25),
                category="mantenimiento", amount=350.0))

    # --- metas: mes actual y anterior (F-04/F-10) --------------------------
    db.add_all(expenses)
    cy, cm = _add_month(year, month, 0)
    py, pm = _add_month(year, month, -1)
    db.add(MonthlyGoal(organization_id=org.id,
                       month=f"{cy:04d}-{cm:02d}", goal_amount=20000.0))
    db.add(MonthlyGoal(organization_id=org.id,
                       month=f"{py:04d}-{pm:02d}", goal_amount=15000.0))
    db.add(Setting(key=_FLAG, value="1"))
    db.commit()
    print(f"seed_finance: {len(created_orders)} pedidos históricos, "
          f"{len(expenses)} gastos y 2 metas inyectados (org {org.code}).")


def main() -> None:
    init_db(settings.db_url)
    Base.metadata.create_all(get_engine())
    session = get_session_factory()()
    try:
        from app.seed import seed_demo
        seed_demo(session)  # idempotente; asegura org/productos/impresoras
        seed_finance(session)
    finally:
        session.close()


if __name__ == "__main__":
    main()
