"""Finanzas: tablas `expenses` (gastos, F-09) y `goals` (meta por mes, F-10).

Ambas son multi-tenant (`organization_id`) y `goals` es única por
(organization_id, month). En BDs creadas por `create_all` (dev/Pi) estas
tablas ya existen; esta migración es para el flujo alembic de BDs frescas.

Revision ID: 0006
Revises: 0005
Create Date: 2026-11-13
"""
from alembic import op
import sqlalchemy as sa

revision = "0006"
down_revision = "0005"
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.create_table(
        "expenses",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("organization_id", sa.Integer,
                  sa.ForeignKey("organizations.id"), nullable=False),
        sa.Column("date", sa.Date, nullable=False),
        sa.Column("category", sa.String(30), nullable=False),
        sa.Column("amount", sa.Float, nullable=False),
        sa.Column("order_id", sa.Integer, sa.ForeignKey("orders.id"),
                  nullable=True),
        sa.Column("created_at", sa.DateTime, nullable=False),
    )
    op.create_index("ix_expenses_organization_id", "expenses",
                    ["organization_id"])
    op.create_index("ix_expenses_date", "expenses", ["date"])
    op.create_index("ix_expenses_order_id", "expenses", ["order_id"])

    op.create_table(
        "goals",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("organization_id", sa.Integer,
                  sa.ForeignKey("organizations.id"), nullable=False),
        sa.Column("month", sa.String(7), nullable=False),
        sa.Column("goal_amount", sa.Float, nullable=False),
        sa.Column("created_at", sa.DateTime, nullable=False),
        sa.UniqueConstraint("organization_id", "month",
                            name="uq_goals_org_month"),
    )
    op.create_index("ix_goals_organization_id", "goals",
                    ["organization_id"])


def downgrade() -> None:
    op.drop_index("ix_goals_organization_id", table_name="goals")
    op.drop_table("goals")
    op.drop_index("ix_expenses_order_id", table_name="expenses")
    op.drop_index("ix_expenses_date", table_name="expenses")
    op.drop_index("ix_expenses_organization_id", table_name="expenses")
    op.drop_table("expenses")
