"""Máquina de estados de pedidos (§3.4) y estado de vencimiento.

Toda transición vive aquí: los frontends solo presentan (invariante).
"""

from datetime import date

from app.config import settings
from app.models import Order, OrderItem

# Estados que solo cambian por acción manual del operador (P-07/P-08).
MANUAL_STATUSES = {"packed", "shipped", "delivered", "cancelled"}

# Orden canónico de la línea de tiempo del cliente (C-02).
STATUS_ORDER = [
    "confirmed",
    "queued",
    "printing",
    "printed",
    "packed",
    "shipped",
    "delivered",
]


def derive_status(order: Order, items: list[OrderItem]) -> str:
    """Estado actual del pedido a partir de su `manual_status` y sus items.

    Reglas (espejo del comportamiento esperado por P-07):
    - manual (packed/shipped/delivered/cancelled) manda sobre lo derivado.
    - sin items → confirmed.
    - todos impresos → printed.
    - alguno imprimiendo → printing.
    - alguno en cola → queued.
    - si no → confirmed.
    """
    if order.manual_status in MANUAL_STATUSES:
        return order.manual_status
    if not items:
        return "confirmed"
    if all(i.state == "printed" for i in items):
        return "printed"
    if any(i.state == "printing" for i in items):
        return "printing"
    if any(i.state in ("queued", "printing") for i in items):
        return "queued"
    return "confirmed"


def due_state(promised: date | None, today: date | None = None) -> str:
    """Deriva `due_state` (P-07): none | ok | due_soon | overdue."""
    if promised is None:
        return "none"
    today = today or date.today()
    diff = (promised - today).days
    if diff < 0:
        return "overdue"
    if diff <= settings.due_soon_days:
        return "due_soon"
    return "ok"


def can_transition(current: str, new: str) -> bool:
    """Valida transiciones manuales del pedido (§3.4).

    Permitido: cualquier estado manual desde cualquiera no terminal, y
    cancelled desde cualquiera. No se permite retroceder de terminal.
    """
    if new == current:
        return False
    if new == "cancelled":
        return current != "delivered"
    if current in ("cancelled", "delivered"):
        return False
    if new in MANUAL_STATUSES:
        return True
    # Transiciones derivadas no se piden manualmente.
    return False
