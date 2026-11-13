"""Finanzas (F-04..F-11): resumen, pedidos, tendencia, productos, fallas,
gastos y metas. §3.8 — las fórmulas de negocio viven solo en el backend.

Multi-tenant: todo consulta la org activa del usuario. BE-17: solo `owner`.

Semántica de costos (§3.8, sin doble conteo):
- costo de pedido = jobs impresos (material + luz) + gastos ligados al pedido
  (`expense.order_id`), mapeados por categoría.
- resumen del mes = Σ costos de los pedidos del mes + gastos **sin** pedido
  del mes + costo de fallas del mes ("se reporta aparte y suma al costo del
  mes").
"""

import re
from datetime import UTC, date, datetime
from zoneinfo import ZoneInfo, ZoneInfoNotFoundError

from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy import or_, select
from sqlalchemy.orm import Session, selectinload

from app.db import get_db
from app.deps import require_owner
from app.models import (
    Business,
    Customer,
    Expense,
    MonthlyGoal,
    Order,
    OrderItem,
    Organization,
    PrintJob,
    Printer,
    Product,
    Spool,
    User,
)
from app.schemas import (
    Expense as ExpenseSchema,
    ExpenseCreateRequest,
    ExpenseUpdateRequest,
    FinanceFailure,
    FinanceOrder,
    FinanceOrderCostBreakdown,
    FinanceProduct,
    FinanceSummary,
    FinanceTrendPoint,
    MonthlyGoal as MonthlyGoalSchema,
    MonthlyGoalUpdate,
)
from app.services.finance import (
    costo_fallas,
    costo_luz,
    costo_material,
    faltante_meta,
    ganancia_pedido,
    margen,
    variacion_mensual,
)
from app.services.state_machine import derive_status

router = APIRouter(prefix="/api/finance", tags=["finance"])

_MONTH_RE = re.compile(r"^\d{4}-(0[1-9]|1[0-2])$")

# Categoría de gasto → campo del desglose de costos del pedido (§3.8).
_EXPENSE_FIELD = {
    "luz": "light",
    "empaque": "packaging",
    "envio": "shipping",
    "comisiones": "commissions",
    "mantenimiento": "other",
    "otro": "other",
}


# --- dependencias y utilidades de tiempo ------------------------------------
def _owner_org(
    user: User = Depends(require_owner),
    db: Session = Depends(get_db),
) -> Organization:
    """Org activa del usuario owner (BE-17 + aislamiento multi-tenant)."""
    if user.organization_id is None or user.membership_status != "active":
        raise HTTPException(
            403,
            {"code": "membership_not_active",
             "message": "No perteneces a una organización activa."},
        )
    org = db.get(Organization, user.organization_id)
    if org is None:
        raise HTTPException(
            403,
            {"code": "membership_not_active",
             "message": "La organización ya no existe."},
        )
    return org


def _tz(tz_name: str | None) -> ZoneInfo:
    try:
        return ZoneInfo(tz_name or "UTC")
    except (KeyError, ZoneInfoNotFoundError, ValueError):
        return ZoneInfo("UTC")


def _check_month(month: str) -> tuple[int, int]:
    if not _MONTH_RE.match(month or ""):
        raise HTTPException(
            400, {"code": "bad_request", "message": "Mes inválido: usa YYYY-MM."}
        )
    return int(month[:4]), int(month[5:])


def _shift_month(month: str, delta: int) -> str:
    year, mon = _check_month(month)
    idx = year * 12 + (mon - 1) + delta
    return f"{idx // 12:04d}-{idx % 12 + 1:02d}"


def _month_bounds(month: str, tz_name: str) -> tuple[datetime, datetime]:
    """[inicio, fin) del mes en la tz del negocio → UTC naive (así guarda la BD)."""
    year, mon = _check_month(month)
    tz = _tz(tz_name)
    start = datetime(year, mon, 1, tzinfo=tz)
    end = (datetime(year + 1, 1, 1, tzinfo=tz) if mon == 12
           else datetime(year, mon + 1, 1, tzinfo=tz))
    return (start.astimezone(UTC).replace(tzinfo=None),
            end.astimezone(UTC).replace(tzinfo=None))


def _date_bounds(month: str) -> tuple[date, date]:
    """Límites [inicio, fin) para `Expense.date` (fecha civil, sin hora)."""
    year, mon = _check_month(month)
    start = date(year, mon, 1)
    end = date(year + 1, 1, 1) if mon == 12 else date(year, mon + 1, 1)
    return start, end


def _current_month(tz_name: str) -> str:
    return datetime.now(UTC).astimezone(_tz(tz_name)).strftime("%Y-%m")


def _business(db: Session, org: Organization) -> Business:
    biz = db.scalar(
        select(Business).where(Business.organization_id == org.id)
    )
    if biz is None:  # no debería pasar (la org nace con su negocio)
        biz = Business(organization_id=org.id)
        db.add(biz)
        db.flush()
    return biz


# --- carga de datos de costos -----------------------------------------------
def _spool_costs(db: Session, org: Organization) -> dict[int, float]:
    """printer_id → costo por kg del spool cargado (BE-16)."""
    rows = db.execute(
        select(Printer.id, Spool.cost_per_kg)
        .join(Spool, Printer.loaded_spool_id == Spool.id)
        .where(Printer.organization_id == org.id)
    ).all()
    return {printer_id: cost for printer_id, cost in rows}


def _items_by_order(
    db: Session, org: Organization, order_ids: list[int]
) -> dict[int, list[OrderItem]]:
    if not order_ids:
        return {}
    rows = db.scalars(
        select(OrderItem)
        .where(OrderItem.organization_id == org.id,
               OrderItem.order_id.in_(order_ids))
        .options(selectinload(OrderItem.product))
        .order_by(OrderItem.id)
    ).all()
    out: dict[int, list[OrderItem]] = {}
    for item in rows:
        out.setdefault(item.order_id, []).append(item)
    return out


def _item_job_costs(
    db: Session, org: Organization, biz: Business, order_ids: list[int]
) -> dict[int, tuple[float, float]]:
    """item_id → (material, luz) de sus jobs impresos (state='printed')."""
    if not order_ids:
        return {}
    spool_cost = _spool_costs(db, org)
    stmt = (
        select(PrintJob, OrderItem, Product)
        .join(OrderItem, PrintJob.item_id == OrderItem.id)
        .join(Product, OrderItem.product_id == Product.id)
        .where(PrintJob.organization_id == org.id,
               OrderItem.organization_id == org.id,
               PrintJob.state == "printed",
               OrderItem.order_id.in_(order_ids))
    )
    out: dict[int, list[float]] = {}
    for job, item, product in db.execute(stmt).all():
        grams = job.grams_real
        if grams is None:
            grams = product.estimated_weight_g or 0.0
        minutes = job.minutes_real
        if minutes is None:
            minutes = (item.estimated_minutes
                       or product.estimated_minutes or 0)
        cpg = spool_cost.get(job.printer_id, 0.0)
        acc = out.setdefault(item.id, [0.0, 0.0])
        acc[0] += costo_material(float(grams), cpg)
        acc[1] += costo_luz(float(minutes) / 60.0, biz.printer_kw,
                            biz.electricity_tariff_kwh)
    return {item_id: (vals[0], vals[1]) for item_id, vals in out.items()}


def _expenses_by_order(
    db: Session, org: Organization, order_ids: list[int]
) -> dict[int, list[Expense]]:
    if not order_ids:
        return {}
    rows = db.scalars(
        select(Expense).where(Expense.organization_id == org.id,
                              Expense.order_id.in_(order_ids))
    ).all()
    out: dict[int, list[Expense]] = {}
    for exp in rows:
        out.setdefault(exp.order_id, []).append(exp)
    return out


def _finance_row(
    order: Order,
    items: list[OrderItem],
    item_costs: dict[int, tuple[float, float]],
    exp_list: list[Expense],
) -> FinanceOrder:
    material = light = packaging = shipping = commissions = other = 0.0
    for item in items:
        m, l = item_costs.get(item.id, (0.0, 0.0))
        material += m
        light += l
    for exp in exp_list:
        field = _EXPENSE_FIELD.get(exp.category, "other")
        if field == "light":
            light += exp.amount
        elif field == "packaging":
            packaging += exp.amount
        elif field == "shipping":
            shipping += exp.amount
        elif field == "commissions":
            commissions += exp.amount
        else:
            other += exp.amount
    costs = FinanceOrderCostBreakdown(
        material=material, light=light, packaging=packaging,
        shipping=shipping, commissions=commissions, other=other,
    )
    costs_total = (material + light + packaging + shipping
                   + commissions + other)
    status = derive_status(order, items)
    income = 0.0 if status == "cancelled" else order.total
    profit = ganancia_pedido(income, costs_total)
    return FinanceOrder(
        id=order.id,
        folio=order.folio,
        customer_name=order.customer.name if order.customer else "Cliente",
        status=status,
        total=order.total,
        income=income,
        costs=costs,
        profit=profit,
        margin=margen(profit, income),
        created_at=order.created_at,
        promised_date=order.promised_date,
    )


def _finance_rows(
    db: Session, org: Organization, biz: Business, orders: list[Order]
) -> list[FinanceOrder]:
    order_ids = [o.id for o in orders]
    items_map = _items_by_order(db, org, order_ids)
    item_costs = _item_job_costs(db, org, biz, order_ids)
    exp_map = _expenses_by_order(db, org, order_ids)
    return [
        _finance_row(order, items_map.get(order.id, []), item_costs,
                     exp_map.get(order.id, []))
        for order in orders
    ]


def _failed_tuples(
    db: Session, org: Organization, biz: Business,
    start: datetime, end: datetime,
) -> list[tuple[float, float, float]]:
    """Jobs fallidos en [start, end): (grams, cost_per_kg, minutes) (§3.8)."""
    spool_cost = _spool_costs(db, org)
    stmt = (
        select(PrintJob, OrderItem, Product)
        .join(OrderItem, PrintJob.item_id == OrderItem.id)
        .join(Product, OrderItem.product_id == Product.id)
        .where(PrintJob.organization_id == org.id,
               PrintJob.state == "failed")
    )
    out: list[tuple[float, float, float]] = []
    for job, item, product in db.execute(stmt).all():
        moment = job.finished_at or job.started_at
        if moment is None or not (start <= moment < end):
            continue
        grams = job.grams_real
        if grams is None:
            grams = product.estimated_weight_g or 0.0
        minutes = job.minutes_real
        if minutes is None:
            minutes = (item.estimated_minutes
                       or product.estimated_minutes or 0)
        out.append((float(grams), spool_cost.get(job.printer_id, 0.0),
                    float(minutes)))
    return out


def _month_report(
    db: Session, org: Organization, biz: Business, month: str
) -> dict:
    """Ingresos, costos y ganancia de un mes (fórmulas §3.8)."""
    start, end = _month_bounds(month, biz.timezone)
    d_start, d_end = _date_bounds(month)
    orders = db.scalars(
        select(Order)
        .where(Order.organization_id == org.id,
               Order.created_at >= start, Order.created_at < end)
        .options(selectinload(Order.customer))
    ).all()
    rows = _finance_rows(db, org, biz, orders)
    income = sum(row.income for row in rows)
    order_costs = sum(
        row.costs.material + row.costs.light + row.costs.packaging
        + row.costs.shipping + row.costs.commissions + row.costs.other
        for row in rows
    )
    unlinked = db.scalars(
        select(Expense).where(Expense.organization_id == org.id,
                              Expense.order_id.is_(None),
                              Expense.date >= d_start,
                              Expense.date < d_end)
    ).all()
    failed = _failed_tuples(db, org, biz, start, end)
    costs = (order_costs + sum(e.amount for e in unlinked)
             + costo_fallas(failed, biz.printer_kw,
                            biz.electricity_tariff_kwh))
    return {
        "orders": rows,
        "income": income,
        "costs": costs,
        "profit": ganancia_pedido(income, costs),
    }


def _goal_amount(
    db: Session, org: Organization, biz: Business, month: str
) -> float:
    amount = db.scalar(
        select(MonthlyGoal.goal_amount)
        .where(MonthlyGoal.organization_id == org.id,
               MonthlyGoal.month == month)
    )
    return biz.monthly_goal if amount is None else amount


# --- endpoints ---------------------------------------------------------------
@router.get("/summary", operation_id="financeSummary",
            response_model=FinanceSummary)
def summary(month: str = Query(...),
            org: Organization = Depends(_owner_org),
            db: Session = Depends(get_db)):
    """Resumen del mes: ingresos, costos, ganancia, meta y variación (F-04)."""
    biz = _business(db, org)
    current = _month_report(db, org, biz, month)
    previous = _month_report(db, org, biz, _shift_month(month, -1))
    goal = _goal_amount(db, org, biz, month)
    profit = current["profit"]
    return FinanceSummary(
        month=month,
        orders_count=len(current["orders"]),
        income=current["income"],
        costs=current["costs"],
        profit=profit,
        margin=margen(profit, current["income"]),
        previous_month_profit=previous["profit"],
        variation_pct=variacion_mensual(profit, previous["profit"]),
        goal=goal,
        goal_reached=profit,
        goal_missing=faltante_meta(goal, profit),
    )


@router.get("/orders", operation_id="listFinanceOrders",
            response_model=list[FinanceOrder])
def orders(month: str | None = Query(None),
           status: str | None = Query(None),
           q: str | None = Query(None),
           org: Organization = Depends(_owner_org),
           db: Session = Depends(get_db)):
    """Pedidos con desglose de costos y ganancia (F-05); filtros mes/estado/q."""
    biz = _business(db, org)
    stmt = (
        select(Order)
        .where(Order.organization_id == org.id)
        .options(selectinload(Order.customer))
    )
    if month:
        start, end = _month_bounds(month, biz.timezone)
        stmt = stmt.where(Order.created_at >= start, Order.created_at < end)
    if q:
        stmt = stmt.where(or_(
            Order.folio.ilike(f"%{q}%"),
            Order.customer.has(Customer.name.ilike(f"%{q}%")),
        ))
    rows = _finance_rows(db, org, biz,
                         db.scalars(stmt.order_by(Order.created_at.desc()))
                         .all())
    if status:
        rows = [row for row in rows if row.status == status]
    return rows


@router.get("/trend", operation_id="financeTrend",
            response_model=list[FinanceTrendPoint])
def trend(org: Organization = Depends(_owner_org),
          db: Session = Depends(get_db)):
    """Últimos 12 meses: ingresos, costos y ganancia (F-06)."""
    biz = _business(db, org)
    current = _current_month(biz.timezone)
    points: list[FinanceTrendPoint] = []
    for offset in range(11, -1, -1):
        month = _shift_month(current, -offset)
        report = _month_report(db, org, biz, month)
        points.append(FinanceTrendPoint(
            month=month, income=report["income"], costs=report["costs"],
            profit=report["profit"],
        ))
    return points


@router.get("/products", operation_id="financeProducts",
            response_model=list[FinanceProduct])
def products(org: Organization = Depends(_owner_org),
             db: Session = Depends(get_db)):
    """Rentabilidad por producto (F-07), histórico de la organización.

    El ingreso y los gastos del pedido se prorratean por cantidad entre sus
    items; material/luz aporta cada item con sus jobs impresos.
    """
    biz = _business(db, org)
    all_orders = db.scalars(
        select(Order).where(Order.organization_id == org.id)
        .options(selectinload(Order.customer))
    ).all()
    order_ids = [o.id for o in all_orders]
    items_map = _items_by_order(db, org, order_ids)
    item_costs = _item_job_costs(db, org, biz, order_ids)
    exp_map = _expenses_by_order(db, org, order_ids)

    agg: dict[int, dict] = {}
    for order in all_orders:
        items = items_map.get(order.id, [])
        total_qty = sum(item.quantity for item in items)
        if not items or total_qty <= 0:
            continue
        row = _finance_row(order, items, item_costs,
                           exp_map.get(order.id, []))
        exp_total = sum(e.amount for e in exp_map.get(order.id, []))
        for item in items:
            entry = agg.setdefault(item.product_id, {
                "name": item.product.name, "order_ids": set(),
                "income": 0.0, "costs": 0.0,
            })
            entry["order_ids"].add(order.id)
            share = item.quantity / total_qty
            entry["income"] += row.income * share
            material, light = item_costs.get(item.id, (0.0, 0.0))
            entry["costs"] += material + light + exp_total * share

    result: list[FinanceProduct] = []
    for product_id, entry in agg.items():
        profit = ganancia_pedido(entry["income"], entry["costs"])
        result.append(FinanceProduct(
            product_id=product_id,
            product_name=entry["name"],
            orders_count=len(entry["order_ids"]),
            income=entry["income"],
            costs=entry["costs"],
            profit=profit,
            margin=margen(profit, entry["income"]),
        ))
    result.sort(key=lambda p: p.profit, reverse=True)
    return result


@router.get("/failures", operation_id="financeFailures",
            response_model=list[FinanceFailure])
def failures(month: str = Query(...),
             org: Organization = Depends(_owner_org),
             db: Session = Depends(get_db)):
    """Costo de fallas del mes: gramos y dinero perdidos (F-08, §3.8)."""
    biz = _business(db, org)
    start, end = _month_bounds(month, biz.timezone)
    failed = _failed_tuples(db, org, biz, start, end)
    if not failed:
        return []
    return [FinanceFailure(
        month=month,
        failed_jobs_count=len(failed),
        grams_lost=sum(grams for grams, _, _ in failed),
        money_lost=costo_fallas(failed, biz.printer_kw,
                                biz.electricity_tariff_kwh),
    )]


def _expense_out(exp: Expense) -> ExpenseSchema:
    return ExpenseSchema(
        id=exp.id,
        date=exp.date,
        category=exp.category,
        amount=exp.amount,
        order_id=exp.order_id,
        order_folio=exp.order.folio if exp.order is not None else None,
        created_at=exp.created_at,
    )


@router.get("/expenses", operation_id="listExpenses",
            response_model=list[ExpenseSchema])
def list_expenses(month: str | None = Query(None),
                  org: Organization = Depends(_owner_org),
                  db: Session = Depends(get_db)):
    """Gastos del negocio (F-09); opcionalmente filtrados por mes."""
    stmt = (
        select(Expense)
        .where(Expense.organization_id == org.id)
        .options(selectinload(Expense.order))
        .order_by(Expense.date.desc(), Expense.id.desc())
    )
    if month:
        d_start, d_end = _date_bounds(month)
        stmt = stmt.where(Expense.date >= d_start, Expense.date < d_end)
    return [_expense_out(e) for e in db.scalars(stmt).all()]


def _owned_expense(db: Session, org: Organization, expense_id: int) -> Expense:
    exp = db.get(Expense, expense_id)
    if exp is None or exp.organization_id != org.id:
        raise HTTPException(404, {"code": "not_found",
                                  "message": "Gasto no encontrado."})
    return exp


@router.post("/expenses", operation_id="createExpense",
             response_model=ExpenseSchema, status_code=201)
def create_expense(body: ExpenseCreateRequest,
                   org: Organization = Depends(_owner_org),
                   db: Session = Depends(get_db)):
    """Registra un gasto (F-09); `order_id` opcional lo liga a un pedido."""
    if body.order_id is not None:
        order = db.get(Order, body.order_id)
        if order is None or order.organization_id != org.id:
            raise HTTPException(404, {"code": "not_found",
                                      "message": "Pedido no encontrado."})
    exp = Expense(organization_id=org.id, date=body.date,
                  category=body.category.value, amount=body.amount,
                  order_id=body.order_id)
    db.add(exp)
    db.flush()
    return _expense_out(exp)


@router.patch("/expenses/{expense_id}", operation_id="updateExpense",
              response_model=ExpenseSchema)
def update_expense(expense_id: int, body: ExpenseUpdateRequest,
                   org: Organization = Depends(_owner_org),
                   db: Session = Depends(get_db)):
    """Actualiza un gasto (F-09); `order_id: null` lo desliga del pedido."""
    exp = _owned_expense(db, org, expense_id)
    data = body.model_dump(exclude_unset=True)
    if "date" in data:
        exp.date = data["date"]
    if "category" in data:
        exp.category = data["category"].value
    if "amount" in data:
        exp.amount = data["amount"]
    if "order_id" in data:
        if data["order_id"] is None:
            exp.order_id = None
        else:
            order = db.get(Order, data["order_id"])
            if order is None or order.organization_id != org.id:
                raise HTTPException(404, {"code": "not_found",
                                          "message": "Pedido no encontrado."})
            exp.order_id = order.id
    db.flush()
    return _expense_out(exp)


@router.delete("/expenses/{expense_id}", operation_id="deleteExpense",
               status_code=204)
def delete_expense(expense_id: int,
                   org: Organization = Depends(_owner_org),
                   db: Session = Depends(get_db)):
    """Elimina un gasto (F-09)."""
    exp = _owned_expense(db, org, expense_id)
    db.delete(exp)
    db.flush()
    return None


@router.get("/goal", operation_id="financeGoal",
            response_model=MonthlyGoalSchema)
def get_goal(month: str = Query(...),
             org: Organization = Depends(_owner_org),
             db: Session = Depends(get_db)):
    """Meta de ganancia del mes y tarifa de luz vigentes (F-10)."""
    _check_month(month)
    biz = _business(db, org)
    return MonthlyGoalSchema(
        month=month,
        goal_amount=_goal_amount(db, org, biz, month),
        tariff_kwh=biz.electricity_tariff_kwh,
    )


@router.patch("/goal", operation_id="updateFinanceGoal",
              response_model=MonthlyGoalSchema)
def update_goal(body: MonthlyGoalUpdate,
                month: str = Query(...),
                org: Organization = Depends(_owner_org),
                db: Session = Depends(get_db)):
    """Actualiza la meta del mes y/o la tarifa de luz (F-10)."""
    _check_month(month)
    biz = _business(db, org)
    data = body.model_dump(exclude_unset=True)
    row = db.scalar(
        select(MonthlyGoal).where(MonthlyGoal.organization_id == org.id,
                                  MonthlyGoal.month == month)
    )
    if "goal_amount" in data:
        if row is None:
            row = MonthlyGoal(organization_id=org.id, month=month,
                              goal_amount=data["goal_amount"])
            db.add(row)
        else:
            row.goal_amount = data["goal_amount"]
    if "tariff_kwh" in data:
        biz.electricity_tariff_kwh = data["tariff_kwh"]
    db.flush()
    goal_amount = (_goal_amount(db, org, biz, month))
    return MonthlyGoalSchema(month=month, goal_amount=goal_amount,
                             tariff_kwh=biz.electricity_tariff_kwh)
