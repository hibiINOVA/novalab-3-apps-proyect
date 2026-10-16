"""Esquema inicial: todas las tablas del backend.

Revision ID: 0001
Revises:
Create Date: 2026-10-14
"""
from alembic import op
import sqlalchemy as sa

revision = "0001"
down_revision = None
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.create_table(
        "users",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("name", sa.String(120), nullable=False),
        sa.Column("email", sa.String(255), nullable=False, unique=True),
        sa.Column("password_hash", sa.String(255), nullable=False),
        sa.Column("role", sa.String(20), nullable=False),
        sa.Column("created_at", sa.DateTime, nullable=False),
    )
    op.create_index("ix_users_email", "users", ["email"])

    op.create_table(
        "business",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("business_name", sa.String(120), nullable=False),
        sa.Column("logo_url", sa.String(500)),
        sa.Column("primary_color", sa.String(9), nullable=False),
        sa.Column("accent_color", sa.String(9), nullable=False),
        sa.Column("background_color", sa.String(9), nullable=False),
        sa.Column("currency", sa.String(3), nullable=False),
        sa.Column("timezone", sa.String(64), nullable=False),
        sa.Column("language", sa.String(16), nullable=False),
        sa.Column("estafeta_tracking_url", sa.String(300), nullable=False),
        sa.Column("electricity_tariff_kwh", sa.Float, nullable=False),
        sa.Column("printer_kw", sa.Float, nullable=False),
        sa.Column("monthly_goal", sa.Float, nullable=False),
    )

    op.create_table(
        "spools",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("material", sa.String(60), nullable=False),
        sa.Column("color", sa.String(60), nullable=False),
        sa.Column("grams_total", sa.Float, nullable=False),
        sa.Column("grams_remaining", sa.Float, nullable=False),
        sa.Column("cost_per_kg", sa.Float, nullable=False),
    )

    op.create_table(
        "printers",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("name", sa.String(120), nullable=False),
        sa.Column("octoprint_url", sa.String(300)),
        sa.Column("api_key_encrypted", sa.Text),
        sa.Column("snapshot_url", sa.String(500)),
        sa.Column("bed_width", sa.Float),
        sa.Column("bed_depth", sa.Float),
        sa.Column("state", sa.String(20), nullable=False),
        sa.Column("progress", sa.Float),
        sa.Column("remaining_seconds", sa.Integer),
        sa.Column("nozzle_temp", sa.Float),
        sa.Column("nozzle_target", sa.Float),
        sa.Column("bed_temp", sa.Float),
        sa.Column("bed_target", sa.Float),
        sa.Column("current_file", sa.String(255)),
        sa.Column("camera_available", sa.Boolean, nullable=False),
        sa.Column("loaded_spool_id", sa.Integer, sa.ForeignKey("spools.id")),
        sa.Column("last_seen", sa.DateTime),
        sa.Column("created_at", sa.DateTime, nullable=False),
    )

    op.create_table(
        "customers",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("name", sa.String(160), nullable=False),
        sa.Column("phone", sa.String(40)),
        sa.Column("email", sa.String(255)),
        sa.Column("notes", sa.Text),
        sa.Column("created_at", sa.DateTime, nullable=False),
    )

    op.create_table(
        "products",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("name", sa.String(160), nullable=False),
        sa.Column("material", sa.String(60)),
        sa.Column("color", sa.String(60)),
        sa.Column("estimated_weight_g", sa.Float),
        sa.Column("estimated_minutes", sa.Integer),
        sa.Column("extra_cost", sa.Float),
        sa.Column("has_gcode", sa.Boolean, nullable=False),
        sa.Column("base_price", sa.Float, nullable=False),
    )

    op.create_table(
        "orders",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("folio", sa.String(40), nullable=False, unique=True),
        sa.Column("customer_id", sa.Integer, sa.ForeignKey("customers.id")),
        sa.Column("status", sa.String(30), nullable=False),
        sa.Column("manual_status", sa.String(30)),
        sa.Column("promised_date", sa.Date),
        sa.Column("total", sa.Float, nullable=False),
        sa.Column("notes", sa.Text),
        sa.Column("tracking_token", sa.String(64), nullable=False,
                  unique=True),
        sa.Column("created_at", sa.DateTime, nullable=False),
        sa.Column("carrier", sa.String(80)),
        sa.Column("tracking_number", sa.String(80)),
        sa.Column("tracking_url", sa.String(500)),
        sa.Column("shipped_at", sa.Date),
        sa.Column("delivered_at", sa.Date),
    )
    op.create_index("ix_orders_folio", "orders", ["folio"])
    op.create_index("ix_orders_tracking_token", "orders", ["tracking_token"])

    op.create_table(
        "order_items",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("order_id", sa.Integer, sa.ForeignKey("orders.id"),
                  nullable=False),
        sa.Column("product_id", sa.Integer, sa.ForeignKey("products.id"),
                  nullable=False),
        sa.Column("color", sa.String(60)),
        sa.Column("quantity", sa.Integer, nullable=False),
        sa.Column("printed_quantity", sa.Integer, nullable=False),
        sa.Column("state", sa.String(20), nullable=False),
        sa.Column("printer_id", sa.Integer, sa.ForeignKey("printers.id")),
        sa.Column("position", sa.Integer, nullable=False),
        sa.Column("estimated_minutes", sa.Integer),
    )
    op.create_index("ix_order_items_order_id", "order_items", ["order_id"])

    op.create_table(
        "status_history",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("order_id", sa.Integer, sa.ForeignKey("orders.id"),
                  nullable=False),
        sa.Column("status", sa.String(30), nullable=False),
        sa.Column("previous_status", sa.String(30)),
        sa.Column("user_name", sa.String(120)),
        sa.Column("occurred_at", sa.DateTime, nullable=False),
    )
    op.create_index("ix_status_history_order_id", "status_history",
                    ["order_id"])

    op.create_table(
        "print_jobs",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("item_id", sa.Integer, sa.ForeignKey("order_items.id"),
                  nullable=False),
        sa.Column("printer_id", sa.Integer, sa.ForeignKey("printers.id"),
                  nullable=False),
        sa.Column("state", sa.String(20), nullable=False),
        sa.Column("started_at", sa.DateTime),
        sa.Column("finished_at", sa.DateTime),
        sa.Column("grams_real", sa.Float),
        sa.Column("minutes_real", sa.Integer),
        sa.Column("failure_reason", sa.Text),
    )
    op.create_index("ix_print_jobs_item_id", "print_jobs", ["item_id"])

    op.create_table(
        "settings",
        sa.Column("key", sa.String(60), primary_key=True),
        sa.Column("value", sa.String(200), nullable=False),
    )


def downgrade() -> None:
    op.drop_table("settings")
    op.drop_table("print_jobs")
    op.drop_table("status_history")
    op.drop_table("order_items")
    op.drop_table("orders")
    op.drop_table("products")
    op.drop_table("customers")
    op.drop_table("printers")
    op.drop_table("spools")
    op.drop_table("business")
    op.drop_table("users")
