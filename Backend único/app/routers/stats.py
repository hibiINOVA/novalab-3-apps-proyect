"""Estadísticas por usuario (multi-tenant, org activa).

BE-17: solo `owner`. Cada métrica se atribuye al usuario que creó la
orden / inició el job (`user_id` en `orders` y `print_jobs`).

Los cálculos de costo (material, luz, ganancia, margen) reutilizan las
mismas fórmulas §3.8 que el router de finanzas.
"""

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select
from sqlalchemy.orm import Session, selectinload

from app.db import get_db
from app.deps import require_owner
from app.models import (
    Business,
    Expense,
    Organization,
    OrganizationMember,
    Order,
    OrderItem,
    PrintJob,
    Printer,
    Spool,
    User,
)
from app.schemas import UserStats, UserStatsResponse
from app.services.finance import (
    costo_fallas,
    costo_luz,
    costo_material,
    ganancia_pedido,
    margen,
)
from app.services.state_machine import derive_status

router = APIRouter(prefix="/api/stats", tags=["stats"])

_EXPENSE_FIELD = {
    "luz": "light",
    "empaque": "packaging",
    "envio": "shipping",
    "comisiones": "commissions",
    "mantenimiento": "other",
    "otro": "other",
}


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


def _business(db: Session, org: Organization) -> Business:
    biz = db.scalar(
        select(Business).where(Business.organization_id == org.id)
    )
    if biz is None:
        biz = Business(organization_id=org.id)
        db.add(biz)
        db.flush()
    return biz


def _spool_costs(db: Session, org: Organization) -> dict[int, float]:
    """printer_id → costo por kg del spool cargado (BE-16)."""
    from sqlalchemy import select as _select
    rows = db.execute(
        _select(Printer.id, Spool.cost_per_kg)
        .join(Spool, Printer.loaded_spool_id == Spool.id)
        .where(Printer.organization_id == org.id)
    ).all()
    return {printer_id: cost for printer_id, cost in rows}


@router.get(
    "/users", operation_id="listUserStats",
    response_model=UserStatsResponse,
)
def list_user_stats(
    org: Organization = Depends(_owner_org),
    db: Session = Depends(get_db),
):
    """Métricas por usuario: órdenes, ingresos, costos, ganancia, jobs."""
    biz = _business(db, org)

    # Miembros activos de la organización.
    members = db.scalars(
        select(OrganizationMember)
        .where(
            OrganizationMember.organization_id == org.id,
            OrganizationMember.status == "active",
        )
        .order_by(OrganizationMember.id)
    ).all()

    # Todas las órdenes y jobs de la org.
    orders = db.scalars(
        select(Order)
        .where(Order.organization_id == org.id)
        .options(selectinload(Order.customer))
        .order_by(Order.created_at.desc())
    ).all()

    jobs = db.scalars(
        select(PrintJob)
        .where(PrintJob.organization_id == org.id)
        .options(selectinload(PrintJob.item).selectinload(OrderItem.product),
                 selectinload(PrintJob.printer))
    ).all()

    # Índice de items por orden.
    order_ids = [o.id for o in orders]
    items_map: dict[int, list[OrderItem]] = {}
    if order_ids:
        items = db.scalars(
            select(OrderItem)
            .where(
                OrderItem.organization_id == org.id,
                OrderItem.order_id.in_(order_ids),
            )
            .options(selectinload(OrderItem.product))
            .order_by(OrderItem.id)
        ).all()
        for item in items:
            items_map.setdefault(item.order_id, []).append(item)

    # Costo (material, luz) por item a partir de jobs impresos.
    spool_cost = _spool_costs(db, org)
    item_costs: dict[int, tuple[float, float]] = {}
    for job in jobs:
        if job.state != "printed" or job.item is None:
            continue
        item = job.item
        grams = job.grams_real
        if grams is None:
            grams = item.product.estimated_weight_g or 0.0
        minutes = job.minutes_real
        if minutes is None:
            minutes = (
                item.estimated_minutes
                or item.product.estimated_minutes
                or 0
            )
        cpg = spool_cost.get(job.printer_id, 0.0)
        acc = item_costs.setdefault(item.id, [0.0, 0.0])
        acc[0] += costo_material(float(grams), cpg)
        acc[1] += costo_luz(
            float(minutes) / 60.0, biz.printer_kw,
            biz.electricity_tariff_kwh,
        )
    item_costs = {k: (v[0], v[1]) for k, v in item_costs.items()}

    # Gastos ligados a órdenes.
    exp_map: dict[int, list[Expense]] = {}
    if order_ids:
        exps = db.scalars(
            select(Expense).where(
                Expense.organization_id == org.id,
                Expense.order_id.in_(order_ids),
            )
        ).all()
        for exp in exps:
            exp_map.setdefault(exp.order_id, []).append(exp)

    # Inicializar stats por usuario.
    user_stats: dict[int, dict] = {}
    for m in members:
        user_stats[m.user_id] = {
            "user_id": m.user_id,
            "user_name": m.user_name,
            "user_email": m.user_email,
            "role": m.role,
            "orders_count": 0,
            "income": 0.0,
            "costs": 0.0,
            "jobs_started": 0,
            "jobs_completed": 0,
            "jobs_failed": 0,
            "minutes_printed": 0,
            "grams_printed": 0.0,
        }

    # Agregar órdenes por usuario.
    for order in orders:
        uid = order.user_id
        if uid is None or uid not in user_stats:
            continue
        items = items_map.get(order.id, [])
        status = derive_status(order, items)

        material = sum(item_costs.get(i.id, (0.0, 0.0))[0] for i in items)
        light = sum(item_costs.get(i.id, (0.0, 0.0))[1] for i in items)

        packaging = shipping = commissions = other = 0.0
        for exp in exp_map.get(order.id, []):
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

        costs_total = (
            material + light + packaging + shipping + commissions + other
        )
        income = 0.0 if status == "cancelled" else order.total

        us = user_stats[uid]
        us["orders_count"] += 1
        us["income"] += income
        us["costs"] += costs_total

    # Agregar jobs por usuario.
    for job in jobs:
        uid = job.user_id
        if uid is None or uid not in user_stats:
            continue
        us = user_stats[uid]
        us["jobs_started"] += 1
        if job.state == "printed":
            us["jobs_completed"] += 1
            if job.minutes_real:
                us["minutes_printed"] += job.minutes_real
            if job.grams_real:
                us["grams_printed"] += job.grams_real
        elif job.state == "failed":
            us["jobs_failed"] += 1

    # Construir respuesta.
    result: list[UserStats] = []
    for us in user_stats.values():
        profit = us["income"] - us["costs"]
        result.append(
            UserStats(
                user_id=us["user_id"],
                user_name=us["user_name"],
                user_email=us["user_email"],
                role=us["role"],
                orders_count=us["orders_count"],
                income=us["income"],
                costs=us["costs"],
                profit=profit,
                margin=margen(profit, us["income"]),
                jobs_started=us["jobs_started"],
                jobs_completed=us["jobs_completed"],
                jobs_failed=us["jobs_failed"],
                minutes_printed=us["minutes_printed"],
                grams_printed=us["grams_printed"],
            )
        )
    result.sort(key=lambda u: u.profit, reverse=True)
    return UserStatsResponse(users=result)
