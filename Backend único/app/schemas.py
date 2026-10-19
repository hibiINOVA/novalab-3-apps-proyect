"""Esquemas Pydantic. Nombres de clase idénticos a `components/schemas` del
contrato (`packages/api-contract/openapi.yaml`) para que el OpenAPI generado
por FastAPI coincida y el cliente Dart no cambie."""

from datetime import date, datetime
from enum import Enum
from typing import Any

from pydantic import BaseModel, ConfigDict, Field


# --- enums -----------------------------------------------------------------
class Role(str, Enum):
    owner = "owner"
    operator = "operator"


class MembershipStatus(str, Enum):
    none = "none"
    pending = "pending"
    active = "active"
    rejected = "rejected"


class PrinterState(str, Enum):
    idle = "idle"
    printing = "printing"
    paused = "paused"
    offline = "offline"
    error = "error"


class QueueItemState(str, Enum):
    pending = "pending"
    queued = "queued"
    printing = "printing"
    printed = "printed"
    failed = "failed"


ItemState = QueueItemState  # mismo enum, dos nombres en el contrato


class OrderStatus(str, Enum):
    confirmed = "confirmed"
    queued = "queued"
    printing = "printing"
    printed = "printed"
    packed = "packed"
    shipped = "shipped"
    delivered = "delivered"
    cancelled = "cancelled"


class DueState(str, Enum):
    none = "none"
    ok = "ok"
    due_soon = "due_soon"
    overdue = "overdue"


# --- auth ------------------------------------------------------------------
class User(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    name: str
    email: str
    role: Role
    organization_id: int | None = None
    organization_code: str | None = None
    membership_status: MembershipStatus = MembershipStatus.none


class LoginRequest(BaseModel):
    email: str
    password: str


class RefreshRequest(BaseModel):
    refresh_token: str


class RegisterRequest(BaseModel):
    name: str = Field(min_length=1, max_length=120)
    email: str = Field(pattern=r"^[^@\s]+@[^@\s]+\.[^@\s]+$", max_length=255)
    password: str = Field(min_length=8, max_length=128)
    role: Role


class LoginResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    user: User


# --- organizations ---------------------------------------------------------
class Organization(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    code: str
    name: str
    description: str | None = None
    vision: str | None = None
    mission: str | None = None
    has_logo: bool = False
    owner_id: int
    created_at: datetime | None = None


class OrganizationCreateRequest(BaseModel):
    name: str = Field(min_length=2, max_length=120)
    description: str | None = Field(default=None, max_length=2000)
    vision: str | None = Field(default=None, max_length=2000)
    mission: str | None = Field(default=None, max_length=2000)


class OrganizationUpdateRequest(BaseModel):
    name: str | None = Field(default=None, min_length=2, max_length=120)
    description: str | None = Field(default=None, max_length=2000)
    vision: str | None = Field(default=None, max_length=2000)
    mission: str | None = Field(default=None, max_length=2000)


class JoinOrganizationRequest(BaseModel):
    organization_code: str = Field(min_length=1, max_length=40)


class OrganizationMember(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    user_id: int
    user_name: str
    user_email: str
    role: Role
    status: MembershipStatus
    organization_code: str | None = None
    organization_name: str | None = None
    created_at: datetime | None = None


class UserOrganizationStatus(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    organization: Organization | None = None
    membership_status: MembershipStatus = MembershipStatus.none
    pending_requests_count: int = 0


# --- error / branding ------------------------------------------------------
class Error(BaseModel):
    code: str
    message: str


class Branding(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    business_name: str
    logo_url: str | None = None
    primary_color: str
    accent_color: str
    background_color: str
    currency: str
    timezone: str
    language: str


# --- printers --------------------------------------------------------------
class SpoolRef(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    material: str
    color: str
    grams_remaining: float | None = None


class OrderRef(BaseModel):
    id: int
    folio: str
    customer_name: str
    promised_date: date | None = None


class Printer(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    name: str
    model: str | None = None
    state: PrinterState
    progress: float | None = Field(default=None, ge=0, le=100)
    remaining_seconds: int | None = None
    nozzle_temp: float | None = None
    nozzle_target: float | None = None
    bed_temp: float | None = None
    bed_target: float | None = None
    current_file: str | None = None
    camera_available: bool = False
    cameras: list[str] = []  # URLs de snapshot (solo admin; BE-08/BE-21)
    loaded_spool: SpoolRef | None = None
    current_order: OrderRef | None = None
    last_seen: datetime | None = None


# --- cola ------------------------------------------------------------------
class QueueItem(BaseModel):
    id: int
    order_id: int
    order_folio: str
    product_name: str
    color: str | None = None
    quantity: int
    printed_quantity: int
    missing_quantity: int = 0
    state: QueueItemState
    printer_id: int | None = None
    position: int
    estimated_minutes: int | None = None
    promised_date: date | None = None


class Queue(BaseModel):
    unassigned: list[QueueItem]
    by_printer: dict[str, list[QueueItem]]
    version: int


class QueueReorderEntry(BaseModel):
    id: int
    printer_id: int | None = None
    position: int


class QueueReorderRequest(BaseModel):
    version: int
    items: list[QueueReorderEntry]


class SuggestionAssignment(BaseModel):
    item_id: int
    printer_id: int
    printer_name: str
    explanation: str
    order_folio: str | None = None
    product_name: str | None = None
    estimated_minutes: int | None = None


class QueueSuggestion(BaseModel):
    version: int
    summary: str | None = None
    assignments: list[SuggestionAssignment]
    unassigned_item_ids: list[int]


class QueueAcceptEntry(BaseModel):
    item_id: int
    printer_id: int


class QueueAcceptRequest(BaseModel):
    version: int
    assignments: list[QueueAcceptEntry]


# --- print jobs ------------------------------------------------------------
class PrintJob(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    item_id: int
    printer_id: int
    printer_name: str | None = None
    state: QueueItemState
    started_at: datetime | None = None
    finished_at: datetime | None = None
    grams_real: float | None = None
    minutes_real: int | None = None
    failure_reason: str | None = None
    current_file: str | None = None


class PrintJobStartRequest(BaseModel):
    item_id: int
    printer_id: int


class PrintJobFailRequest(BaseModel):
    reason: str


class PrinterCreateRequest(BaseModel):
    name: str = Field(min_length=1, max_length=120)
    model: str | None = Field(default=None, max_length=80)
    octoprint_url: str | None = None
    api_key: str | None = None
    bed_width: float | None = None
    bed_depth: float | None = None
    camera_available: bool = False
    cameras: list[str] | None = None  # URLs de snapshot (BE-07)


class PrinterUpdateRequest(BaseModel):
    name: str | None = Field(default=None, min_length=1, max_length=120)
    model: str | None = Field(default=None, max_length=80)
    octoprint_url: str | None = None
    api_key: str | None = None
    bed_width: float | None = None
    bed_depth: float | None = None
    camera_available: bool | None = None
    cameras: list[str] | None = None
    state: PrinterState | None = None


class PrinterConnectionTestRequest(BaseModel):
    """BE-01: prueba antes del alta (URL + key en el body)."""

    octoprint_url: str = Field(min_length=1, max_length=300)
    api_key: str | None = None


class PrinterConnectionTest(BaseModel):
    ok: bool
    message: str
    version: str | None = None


# --- clientes / productos --------------------------------------------------
class CustomerCreateRequest(BaseModel):
    name: str = Field(min_length=1, max_length=160)
    phone: str | None = None
    email: str | None = None
    notes: str | None = None


class Customer(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    name: str
    phone: str | None = None
    email: str | None = None
    notes: str | None = None


class Product(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    name: str
    material: str | None = None
    color: str | None = None
    estimated_weight_g: float | None = None
    estimated_minutes: int | None = None
    extra_cost: float | None = None
    has_gcode: bool = False
    base_price: float


# --- pedidos ---------------------------------------------------------------
class OrderSummary(BaseModel):
    id: int
    folio: str
    customer_name: str
    status: OrderStatus
    promised_date: date | None = None
    due_state: DueState
    total: float
    items_count: int
    printed_count: int
    created_at: datetime


class OrderItem(BaseModel):
    id: int
    product_id: int
    product_name: str
    color: str | None = None
    quantity: int
    printed_quantity: int
    missing_quantity: int
    state: QueueItemState
    printer_id: int | None = None
    printer_name: str | None = None


class StatusHistoryEntry(BaseModel):
    status: str
    previous_status: str | None = None
    user_name: str | None = None
    occurred_at: datetime


class Shipment(BaseModel):
    carrier: str
    tracking_number: str | None = None
    tracking_url: str | None = None
    shipped_at: date | None = None
    delivered_at: date | None = None


class OrderDetail(OrderSummary):
    tracking_token: str
    notes: str | None = None
    customer: Customer | None = None
    items: list[OrderItem]
    history: list[StatusHistoryEntry]
    shipment: Shipment | None = None


class OrderItemInput(BaseModel):
    product_id: int
    color: str | None = None
    quantity: int = Field(ge=1)


class OrderCreateRequest(BaseModel):
    customer_id: int | None = None
    customer_name: str | None = None
    customer_phone: str | None = None
    promised_date: date | None = None
    notes: str | None = None
    total: float | None = None
    items: list[OrderItemInput] = Field(min_length=1)


class OrderStatusUpdateRequest(BaseModel):
    status: OrderStatus


# --- lookup público --------------------------------------------------------
class PublicLookupRequest(BaseModel):
    folio: str
    phone_last4: str = Field(pattern=r"^[0-9]{4}$", min_length=4, max_length=4)


class PublicLookupResponse(BaseModel):
    tracking_token: str


# --- tiempo real -----------------------------------------------------------
class StatusEvent(BaseModel):
    type: str
    entity: str
    entity_id: int | None = None
    payload: dict[str, Any] | None = None
    occurred_at: datetime
