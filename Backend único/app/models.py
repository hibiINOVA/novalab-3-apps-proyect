"""Modelos SQLAlchemy. Mapean 1:1 a los `components/schemas` del contrato.

Single-tenant: no existe `org_id` (un negocio por instalación, doc §2).
"""

from datetime import UTC, date, datetime

from sqlalchemy import (
    Boolean,
    Date,
    DateTime,
    Float,
    ForeignKey,
    Integer,
    String,
    Text,
)
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.db import Base


def utcnow() -> datetime:
    return datetime.now(UTC)


class User(Base):
    __tablename__ = "users"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    name: Mapped[str] = mapped_column(String(120))
    email: Mapped[str] = mapped_column(String(255), unique=True, index=True)
    password_hash: Mapped[str] = mapped_column(String(255))
    role: Mapped[str] = mapped_column(String(20))  # owner | operator (BE-17)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)


class Business(Base):
    """Configuración única del negocio (branding, tarifas, meta)."""

    __tablename__ = "business"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    business_name: Mapped[str] = mapped_column(String(120), default="NOVALAB")
    logo_url: Mapped[str | None] = mapped_column(String(500), nullable=True)
    primary_color: Mapped[str] = mapped_column(String(9), default="#0B132B")
    accent_color: Mapped[str] = mapped_column(String(9), default="#00FF87")
    background_color: Mapped[str] = mapped_column(String(9), default="#FFFFFF")
    currency: Mapped[str] = mapped_column(String(3), default="MXN")
    timezone: Mapped[str] = mapped_column(String(64), default="America/Mexico_City")
    language: Mapped[str] = mapped_column(String(16), default="es-MX")
    estafeta_tracking_url: Mapped[str] = mapped_column(
        String(300), default="https://www.estafeta.com/tracking"
    )
    # §3.8: tarifa de luz configurable; kW de la impresora por tarifa.
    electricity_tariff_kwh: Mapped[float] = mapped_column(Float, default=4.5)
    printer_kw: Mapped[float] = mapped_column(Float, default=0.15)
    monthly_goal: Mapped[float] = mapped_column(Float, default=0.0)


class Spool(Base):
    """BE-16: costo por kg editable por spool (rPET propio, etc.)."""

    __tablename__ = "spools"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    material: Mapped[str] = mapped_column(String(60))
    color: Mapped[str] = mapped_column(String(60))
    grams_total: Mapped[float] = mapped_column(Float, default=1000.0)
    grams_remaining: Mapped[float] = mapped_column(Float, default=1000.0)
    cost_per_kg: Mapped[float] = mapped_column(Float, default=0.0)


class Printer(Base):
    """BE-01..BE-03. `api_key_encrypted`: BE-20 (cifrada en reposo)."""

    __tablename__ = "printers"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    name: Mapped[str] = mapped_column(String(120))
    octoprint_url: Mapped[str | None] = mapped_column(String(300), nullable=True)
    api_key_encrypted: Mapped[str | None] = mapped_column(Text, nullable=True)
    snapshot_url: Mapped[str | None] = mapped_column(String(500), nullable=True)
    bed_width: Mapped[float | None] = mapped_column(Float, nullable=True)
    bed_depth: Mapped[float | None] = mapped_column(Float, nullable=True)
    state: Mapped[str] = mapped_column(String(20), default="idle")
    progress: Mapped[float | None] = mapped_column(Float, nullable=True)
    remaining_seconds: Mapped[int | None] = mapped_column(Integer, nullable=True)
    nozzle_temp: Mapped[float | None] = mapped_column(Float, nullable=True)
    nozzle_target: Mapped[float | None] = mapped_column(Float, nullable=True)
    bed_temp: Mapped[float | None] = mapped_column(Float, nullable=True)
    bed_target: Mapped[float | None] = mapped_column(Float, nullable=True)
    current_file: Mapped[str | None] = mapped_column(String(255), nullable=True)
    camera_available: Mapped[bool] = mapped_column(Boolean, default=False)
    loaded_spool_id: Mapped[int | None] = mapped_column(
        ForeignKey("spools.id"), nullable=True
    )
    last_seen: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)

    loaded_spool: Mapped[Spool | None] = relationship(
        "Spool", foreign_keys=[loaded_spool_id]
    )


class Customer(Base):
    __tablename__ = "customers"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    name: Mapped[str] = mapped_column(String(160))
    phone: Mapped[str | None] = mapped_column(String(40), nullable=True)
    email: Mapped[str | None] = mapped_column(String(255), nullable=True)
    notes: Mapped[str | None] = mapped_column(Text, nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)


class Product(Base):
    __tablename__ = "products"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    name: Mapped[str] = mapped_column(String(160))
    material: Mapped[str | None] = mapped_column(String(60), nullable=True)
    color: Mapped[str | None] = mapped_column(String(60), nullable=True)
    estimated_weight_g: Mapped[float | None] = mapped_column(Float, nullable=True)
    estimated_minutes: Mapped[int | None] = mapped_column(Integer, nullable=True)
    extra_cost: Mapped[float | None] = mapped_column(Float, nullable=True)
    has_gcode: Mapped[bool] = mapped_column(Boolean, default=False)
    base_price: Mapped[float] = mapped_column(Float, default=0.0)


class Order(Base):
    """Pedido. `manual_status` solo para estados manuales (packed/shipped/
    delivered/cancelled); el resto se deriva de los items."""

    __tablename__ = "orders"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    folio: Mapped[str] = mapped_column(String(40), unique=True, index=True)
    customer_id: Mapped[int | None] = mapped_column(
        ForeignKey("customers.id"), nullable=True
    )
    status: Mapped[str] = mapped_column(String(30), default="confirmed")
    manual_status: Mapped[str | None] = mapped_column(String(30), nullable=True)
    promised_date: Mapped[date | None] = mapped_column(Date, nullable=True)
    total: Mapped[float] = mapped_column(Float, default=0.0)
    notes: Mapped[str | None] = mapped_column(Text, nullable=True)
    tracking_token: Mapped[str] = mapped_column(
        String(64), unique=True, index=True
    )
    created_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)

    # Shipment (§C-05)
    carrier: Mapped[str | None] = mapped_column(String(80), nullable=True)
    tracking_number: Mapped[str | None] = mapped_column(String(80), nullable=True)
    tracking_url: Mapped[str | None] = mapped_column(String(500), nullable=True)
    shipped_at: Mapped[date | None] = mapped_column(Date, nullable=True)
    delivered_at: Mapped[date | None] = mapped_column(Date, nullable=True)

    customer: Mapped[Customer | None] = relationship("Customer")


class OrderItem(Base):
    """Item de pedido / unidad de cola. BE-12: faltante = cantidad − impresa."""

    __tablename__ = "order_items"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    order_id: Mapped[int] = mapped_column(ForeignKey("orders.id"), index=True)
    product_id: Mapped[int] = mapped_column(ForeignKey("products.id"))
    color: Mapped[str | None] = mapped_column(String(60), nullable=True)
    quantity: Mapped[int] = mapped_column(Integer, default=1)
    printed_quantity: Mapped[int] = mapped_column(Integer, default=0)
    state: Mapped[str] = mapped_column(String(20), default="pending")
    printer_id: Mapped[int | None] = mapped_column(
        ForeignKey("printers.id"), nullable=True
    )
    position: Mapped[int] = mapped_column(Integer, default=0)
    estimated_minutes: Mapped[int | None] = mapped_column(Integer, nullable=True)

    order: Mapped[Order] = relationship("Order")
    product: Mapped[Product] = relationship("Product")
    printer: Mapped[Printer | None] = relationship("Printer")


class OrderStatusHistory(Base):
    """Historial de cambios de estado de un pedido (C-02 / P-07)."""

    __tablename__ = "status_history"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    order_id: Mapped[int] = mapped_column(ForeignKey("orders.id"), index=True)
    status: Mapped[str] = mapped_column(String(30))
    previous_status: Mapped[str | None] = mapped_column(String(30), nullable=True)
    user_name: Mapped[str | None] = mapped_column(String(120), nullable=True)
    occurred_at: Mapped[datetime] = mapped_column(DateTime, default=utcnow)


class PrintJob(Base):
    """BE-04/BE-05: job con inicio explícito, tiempo real y gramos."""

    __tablename__ = "print_jobs"

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    item_id: Mapped[int] = mapped_column(ForeignKey("order_items.id"), index=True)
    printer_id: Mapped[int] = mapped_column(ForeignKey("printers.id"))
    state: Mapped[str] = mapped_column(String(20), default="queued")
    started_at: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    finished_at: Mapped[datetime | None] = mapped_column(DateTime, nullable=True)
    grams_real: Mapped[float | None] = mapped_column(Float, nullable=True)
    minutes_real: Mapped[int | None] = mapped_column(Integer, nullable=True)
    failure_reason: Mapped[str | None] = mapped_column(Text, nullable=True)

    item: Mapped[OrderItem] = relationship("OrderItem")
    printer: Mapped[Printer] = relationship("Printer")


class Setting(Base):
    """Estado interno (versión de cola para concurrencia optimista)."""

    __tablename__ = "settings"

    key: Mapped[str] = mapped_column(String(60), primary_key=True)
    value: Mapped[str] = mapped_column(String(200))
