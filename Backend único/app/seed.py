"""Seed de datos demo (dueno/operador, impresoras, cola, pedidos).

Ejecuta `python -m app.seed` o llama `seed_demo()` desde el lifespan."""

from datetime import UTC, date, datetime, timedelta

from sqlalchemy import select
from sqlalchemy.orm import Session

from app.models import (
    Business,
    Customer,
    Order,
    OrderItem,
    OrderStatusHistory,
    PrintJob,
    Printer,
    Product,
    Setting,
    Spool,
    User,
)
from app.security import hash_password, new_tracking_token

DEMO_PASSWORD = "novalab"


def seed_demo(db: Session) -> None:
    if db.scalar(select(User).limit(1)) is not None:
        return  # ya sembrado

    # --- usuarios (BE-17) ---
    owner = User(name="Dueño NOVALAB", email="dueno@novalab.mx",
                 password_hash=hash_password(DEMO_PASSWORD), role="owner")
    operator = User(name="Operador NOVALAB", email="operador@novalab.mx",
                    password_hash=hash_password(DEMO_PASSWORD),
                    role="operator")
    db.add_all([owner, operator])
    db.flush()

    # --- negocio / branding ---
    business = Business(business_name="NOVALAB", currency="MXN",
                        timezone="America/Mexico_City", language="es-MX",
                        electricity_tariff_kwh=4.5, printer_kw=0.15,
                        monthly_goal=50000.0)
    db.add(business)

    # --- spools (BE-16) ---
    spool_petg_blue = Spool(material="PETG", color="Azul", grams_total=1000,
                            grams_remaining=620, cost_per_kg=420.0)
    spool_petg_black = Spool(material="PETG", color="Negro", grams_total=1000,
                             grams_remaining=810, cost_per_kg=400.0)
    spool_pla_white = Spool(material="PLA", color="Blanco", grams_total=1000,
                            grams_remaining=450, cost_per_kg=380.0)
    db.add_all([spool_petg_blue, spool_petg_black, spool_pla_white])
    db.flush()

    # --- impresoras (BE-01..BE-03) ---
    p1 = Printer(name="Prusa MK4", model="Prusa MK4",
                 octoprint_url="http://192.168.1.40",
                 snapshot_url=None, bed_width=250, bed_depth=210,
                 state="idle", camera_available=True,
                 loaded_spool_id=spool_petg_blue.id,
                 nozzle_temp=24.0, nozzle_target=0.0, bed_temp=23.0,
                 bed_target=0.0, last_seen=datetime.now(UTC))
    p2 = Printer(name="Ender 3 V3", model="Creality Ender 3 V3",
                 octoprint_url="http://192.168.1.41",
                 snapshot_url=None, bed_width=220, bed_depth=220,
                 state="idle", camera_available=True,
                 loaded_spool_id=spool_petg_black.id,
                 nozzle_temp=22.0, nozzle_target=0.0, bed_temp=22.0,
                 bed_target=0.0, last_seen=datetime.now(UTC))
    p3 = Printer(name="Bambu Lab A1", model="Bambu Lab A1",
                 octoprint_url=None,
                 snapshot_url=None, bed_width=256, bed_depth=256,
                 state="offline", camera_available=False,
                 loaded_spool_id=spool_pla_white.id, last_seen=None)
    db.add_all([p1, p2, p3])
    db.flush()

    # --- productos ---
    products = [
        Product(name="Portavasos hexagonal", material="PETG", color="Azul",
                estimated_weight_g=28, estimated_minutes=35,
                base_price=120.0, has_gcode=True),
        Product(name="Llavero personalizado", material="PLA", color="Blanco",
                estimated_weight_g=8, estimated_minutes=15,
                base_price=80.0, has_gcode=True),
        Product(name="Soporte de celular", material="PETG", color="Negro",
                estimated_weight_g=45, estimated_minutes=55,
                base_price=180.0, has_gcode=True),
        Product(name="Maceta pequeña", material="PLA", color="Blanco",
                estimated_weight_g=60, estimated_minutes=75,
                base_price=220.0, has_gcode=True),
        Product(name="Organizador de escritorio", material="PETG",
                color="Negro", estimated_weight_g=120,
                estimated_minutes=150, base_price=350.0, has_gcode=True),
    ]
    db.add_all(products)
    db.flush()

    # --- clientes ---
    customers = [
        Customer(name="Ana López", phone="55 1234 5678",
                 email="ana@example.com"),
        Customer(name="Carlos Méndez", phone="55 2345 6789",
                 email="carlos@example.com"),
        Customer(name="Sofía Ramírez", phone="55 3456 7890",
                 email="sofia@example.com"),
        Customer(name="Luis Torres", phone="55 4567 8901"),
        Customer(name="Mariana Cruz", phone="55 5678 9012",
                 email="mariana@example.com"),
    ]
    db.add_all(customers)
    db.flush()

    # --- pedidos demo (folio NL-1001..NL-1005) ---
    today = date.today()
    orders_spec = [
        # (cliente, producto_idx, qty, printed, state, printer, dias_promesa)
        (0, 0, 3, 2, "queued", p1.id, 2),
        (1, 1, 2, 0, "pending", None, 5),
        (2, 2, 1, 0, "pending", None, 1),
        (3, 4, 1, 0, "pending", None, 10),
        (4, 3, 2, 1, "failed", p2.id, -1),  # overdue
    ]
    for idx, (c_idx, prod_idx, qty, printed, state, printer_id,
              due_days) in enumerate(orders_spec, start=1001):
        order = Order(
            folio=f"NL-{idx}",
            customer_id=customers[c_idx].id,
            promised_date=today + timedelta(days=due_days),
            total=products[prod_idx].base_price * qty,
            tracking_token=new_tracking_token(),
            status="confirmed",
            created_at=datetime.now(UTC) - timedelta(days=idx % 3),
        )
        db.add(order)
        db.flush()
        item = OrderItem(
            order_id=order.id,
            product_id=products[prod_idx].id,
            quantity=qty,
            printed_quantity=printed,
            state=state,
            printer_id=printer_id,
            position=0,
            estimated_minutes=products[prod_idx].estimated_minutes,
        )
        db.add(item)
        db.flush()
        db.add(OrderStatusHistory(order_id=order.id, status="confirmed",
                                       occurred_at=order.created_at))
        # Job de impresión para items en cola/imprimiendo/fallidos.
        if state in ("queued", "printing", "failed"):
            job = PrintJob(
                item_id=item.id,
                printer_id=printer_id,
                state="printing" if state == "printing" else (
                    "failed" if state == "failed" else "queued"
                ),
                started_at=datetime.now(UTC) if state != "queued" else None,
                grams_real=products[prod_idx].estimated_weight_g,
                minutes_real=products[prod_idx].estimated_minutes,
                failure_reason="Filamento atascado" if state == "failed"
                else None,
            )
            db.add(job)

    # --- estado interno: versión de cola ---
    db.add(Setting(key="queue_version", value="1"))
    db.commit()
    print("Seed demo: usuarios, 3 impresoras, 5 productos, 5 pedidos.")
