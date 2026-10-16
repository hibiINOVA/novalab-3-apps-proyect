"""Snapshot de cámaras (BE-07..BE-09). El backend solo sirve el snapshot
cacheado; jamás expone la IP de la impresora al cliente."""

import time
from pathlib import Path

from sqlalchemy.orm import Session

from app.config import settings
from app.models import Order, OrderItem, PrintJob, Printer

# 1x1 PNG (placeholder cuando no hay snapshot real).
TINY_PNG = bytes.fromhex(
    "89504e470d0a1a0a0000000d49484452000000010000000108060000001f15c489"
    "0000000d4944415478da63f8cf4000000301010018dd8db10000000049454e44ae426082"
)

# Fallback mínimo en JPEG (8x8 gris) generado en memoria por Pillow si existe.
_JPEG_CACHE: dict[str, tuple[float, bytes]] = {}


def _try_pillow_jpeg(label: str) -> bytes | None:
    try:
        from PIL import Image, ImageDraw
    except ImportError:
        return None
    img = Image.new("RGB", (320, 240), (40, 44, 52))
    draw = ImageDraw.Draw(img)
    draw.text((20, 110), f"NOVALAB {label}", fill=(0, 255, 135))
    from io import BytesIO

    buf = BytesIO()
    img.save(buf, format="JPEG", quality=70)
    return buf.getvalue()


def _fetch_from_octoprint(printer: Printer) -> bytes | None:
    """BE-07: intenta obtener el snapshot del adapter OctoPrint.

    Sin adapter configurado (v1 demo) usa el placeholder.
    """
    if not printer.octoprint_url:
        return None
    try:
        import httpx

        url = printer.octoprint_url.rstrip("/") + "/api/snapshot"
        resp = httpx.get(url, timeout=2.0)
        if resp.status_code == 200 and resp.content:
            return resp.content
    except Exception:
        pass
    return None


def get_snapshot(db: Session, printer_id: int) -> bytes | None:
    """Devuelve JPEG/PNG cacheado del snapshot o None si no hay."""
    printer = db.get(Printer, printer_id)
    if printer is None:
        return None
    cached = _JPEG_CACHE.get(str(printer_id))
    now = time.monotonic()
    if cached and now - cached[0] < settings.snapshot_interval:
        return cached[1]

    data = None
    # Snapshot en disco (seed/demo) primero.
    if printer.snapshot_url and printer.snapshot_url.startswith("/"):
        p = Path(printer.snapshot_url)
        if p.is_file():
            data = p.read_bytes()
    if data is None:
        data = _fetch_from_octoprint(printer)
    if data is None and printer.state != "offline":
        data = _try_pillow_jpeg(printer.name) or TINY_PNG
    if data is None:
        return None
    _JPEG_CACHE[str(printer_id)] = (now, data)
    return data


def get_public_snapshot(db: Session, order_id: int) -> bytes | None:
    """Snapshot público: solo si el pedido tiene un job activo (C-06)."""
    job = (
        db.query(PrintJob)
        .join(OrderItem, PrintJob.item_id == OrderItem.id)
        .filter(OrderItem.order_id == order_id, PrintJob.state == "printing")
        .first()
    )
    if job is None:
        return None
    return get_snapshot(db, job.printer_id)


def clear_cache() -> None:
    _JPEG_CACHE.clear()
