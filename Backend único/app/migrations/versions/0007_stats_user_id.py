"""Estadísticas por usuario: `user_id` en `orders` y `print_jobs`.

Permite atribuir cada pedido y cada job de impresión al usuario que lo
creó / inició, para reportar métricas por operador (órdenes, ingresos,
ganancia, jobs completados/fallados).

En BDs creadas por `create_all` (dev/Pi) estas columnas ya existen por el
modelo; esta migración es para el flujo alembic de BDs frescas.

Revision ID: 0007
Revises: 0006
Create Date: 2026-11-15
"""
from alembic import op
import sqlalchemy as sa

revision = "0007"
down_revision = "0006"
branch_labels = None
depends_on = None


def upgrade() -> None:
    with op.batch_alter_table("orders") as batch_op:
        batch_op.add_column(
            sa.Column("user_id", sa.Integer, nullable=True)
        )
        batch_op.create_foreign_key(
            "fk_orders_user_id", "users", ["user_id"], ["id"]
        )
        batch_op.create_index("ix_orders_user_id", ["user_id"])

    with op.batch_alter_table("print_jobs") as batch_op:
        batch_op.add_column(
            sa.Column("user_id", sa.Integer, nullable=True)
        )
        batch_op.create_foreign_key(
            "fk_print_jobs_user_id", "users", ["user_id"], ["id"]
        )
        batch_op.create_index("ix_print_jobs_user_id", ["user_id"])


def downgrade() -> None:
    with op.batch_alter_table("print_jobs") as batch_op:
        batch_op.drop_constraint("fk_print_jobs_user_id", type_="foreignkey")
        batch_op.drop_index("ix_print_jobs_user_id")
        batch_op.drop_column("user_id")

    with op.batch_alter_table("orders") as batch_op:
        batch_op.drop_constraint("fk_orders_user_id", type_="foreignkey")
        batch_op.drop_index("ix_orders_user_id")
        batch_op.drop_column("user_id")
