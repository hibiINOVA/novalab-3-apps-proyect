"""Lógica de cola: construcción, reorden, sugerencia (BE-11..BE-14) y
aceptación. Toda decisión vive en el backend."""

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.events import hub
from app.models import Order, OrderItem, Printer, Product, Setting, Spool
from app.schemas import (
    Queue,
    QueueItem,
    QueueSuggestion,
    SuggestionAssignment,
)
from app.services.state_machine import due_state


def get_version(db: Session) -> int:
    row = db.get(Setting, "queue_version")
    if row is None:
        row = Setting(key="queue_version", value="1")
        db.add(row)
        db.flush()
    return int(row.value)


def bump_version(db: Session) -> int:
    row = db.get(Setting, "queue_version")
    if row is None:
        row = Setting(key="queue_version", value="1")
        db.add(row)
    row.value = str(int(row.value) + 1)
    db.flush()
    return int(row.value)


def _to_queue_item(item: OrderItem) -> QueueItem:
    product: Product = item.product
    order: Order = item.order
    return QueueItem(
        id=item.id,
        order_id=item.order_id,
        order_folio=order.folio,
        product_name=product.name,
        color=item.color or product.color,
        quantity=item.quantity,
        printed_quantity=item.printed_quantity,
        missing_quantity=max(0, item.quantity - item.printed_quantity),  # BE-12
        state=item.state,
        printer_id=item.printer_id,
        position=item.position,
        estimated_minutes=item.estimated_minutes or product.estimated_minutes,
        promised_date=order.promised_date,
    )


ACTIVE_STATES = ("pending", "queued", "printing", "failed")


def build_queue(db: Session) -> Queue:
    items = db.scalars(
        select(OrderItem).where(OrderItem.state.in_(ACTIVE_STATES))
    ).all()
    unassigned: list[QueueItem] = []
    by_printer: dict[str, list[QueueItem]] = {}
    for item in items:
        qi = _to_queue_item(item)
        if item.printer_id is None:
            unassigned.append(qi)
        else:
            by_printer.setdefault(str(item.printer_id), []).append(qi)
    unassigned.sort(key=lambda i: i.position)
    for key in by_printer:
        by_printer[key].sort(key=lambda i: i.position)
    return Queue(unassigned=unassigned, by_printer=by_printer,
                 version=get_version(db))


def check_version(db: Session, client_version: int) -> bool:
    return client_version == get_version(db)


def _next_position(db: Session, printer_id: int | None) -> int:
    """Siguiente posición libre en la impresora (o en 'sin asignar')."""
    stmt = select(OrderItem).where(OrderItem.state.in_(ACTIVE_STATES))
    if printer_id is None:
        stmt = stmt.where(OrderItem.printer_id.is_(None))
    else:
        stmt = stmt.where(OrderItem.printer_id == printer_id)
    positions = [i.position for i in db.scalars(stmt).all()]
    return max(positions, default=-1) + 1


def apply_entries(db: Session, entries: list[dict]) -> int:
    """Aplica entradas de reorder `{id, printer_id, position}` o de accept
    `{item_id, printer_id}` y devuelve la nueva versión.

    En accept (sin `position`) el item se agrega al final de su impresora.
    """
    next_pos: dict[str, int] = {}
    for entry in entries:
        item_id = entry.get("item_id", entry.get("id"))
        item = db.get(OrderItem, item_id)
        if item is None:
            continue
        printer_id = entry.get("printer_id")
        item.printer_id = printer_id
        position = entry.get("position")
        if position is None:
            # accept: append al final (como el mock, `_nextPosition`).
            key = "" if printer_id is None else str(printer_id)
            if key not in next_pos:
                next_pos[key] = _next_position(db, printer_id)
            item.position = next_pos[key]
            next_pos[key] += 1
        else:
            item.position = position
        # Asignar a impresora saca al item de 'pending' (BE-11).
        if printer_id is not None and item.state == "pending":
            item.state = "queued"
        if printer_id is None and item.state == "queued":
            item.state = "pending"
    version = bump_version(db)
    db.flush()
    return version


def suggest(db: Session) -> QueueSuggestion:
    """BE-13/BE-14: propone asignación con explicación legible.

    Criterios: urgencia (fecha prometida), compatibilidad material/color del
    spool cargado, spool con gramos suficientes, balanceo de carga.
    """
    pending = sorted(
        [i for i in db.scalars(
            select(OrderItem).where(OrderItem.state == "pending")
        ).all() if i.printer_id is None],
        key=lambda i: (i.order.promised_date or date_max(), i.position),
    )
    printers = db.scalars(
        select(Printer).where(Printer.state != "offline")
    ).all()

    # Carga actual (minutos) por impresora.
    load: dict[int, float] = {p.id: 0.0 for p in printers}
    for item in db.scalars(
        select(OrderItem).where(OrderItem.printer_id.is_not(None))
    ).all():
        if item.printer_id in load:
            minutes = item.estimated_minutes or item.product.estimated_minutes or 0
            load[item.printer_id] += minutes

    assignments: list[SuggestionAssignment] = []
    unassigned_ids: list[int] = []

    for item in pending:
        product = item.product
        item_color = item.color or product.color
        item_material = product.material
        needed_g = product.estimated_weight_g or 0.0

        best: Printer | None = None
        best_score: float = float("inf")
        reason = ""

        for printer in printers:
            spool: Spool | None = printer.loaded_spool
            same_color = spool is not None and spool.color == item_color
            same_material = spool is not None and spool.material == item_material
            has_spool = spool is not None
            enough = has_spool and (spool.grams_remaining or 0) >= needed_g

            # Criterio 3: sin gramos suficientes, descarta la impresora.
            if has_spool and not enough:
                continue

            score = load[printer.id] - (60 if same_color else 0) - (
                30 if same_material else 0
            )
            if score < best_score:
                best_score = score
                best = printer
                if same_color and same_material:
                    reason = (
                        f"ya tiene {item_material} {item_color}"
                    )
                elif same_material:
                    reason = f"ya tiene {item_material}"
                else:
                    reason = "para balancear la carga"

        if best is None:
            unassigned_ids.append(item.id)
            continue

        load[best.id] += item.estimated_minutes or product.estimated_minutes or 0
        promised = item.order.promised_date
        due_txt = (
            f" y el pedido {item.order.folio} vence el {promised}"
            if promised
            else ""
        )
        explanation = f"Va en {best.name} porque {reason}{due_txt}."

        assignments.append(
            SuggestionAssignment(
                item_id=item.id,
                printer_id=best.id,
                printer_name=best.name,
                explanation=explanation,
                order_folio=item.order.folio,
                product_name=product.name,
                estimated_minutes=item.estimated_minutes
                or product.estimated_minutes,
            )
        )

    summary = (
        "No hay items pendientes por asignar."
        if not assignments
        else f"{len(assignments)} "
        f"{'item asignado' if len(assignments) == 1 else 'items asignados'}."
    )
    return QueueSuggestion(
        version=get_version(db),
        summary=summary,
        assignments=assignments,
        unassigned_item_ids=unassigned_ids,
    )


def date_max():
    from datetime import date

    return date.max
