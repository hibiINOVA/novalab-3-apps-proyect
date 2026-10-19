"""Campos nuevos: Printer.model, Organization description/vision/mission/
logo_path, PrintJob.current_file (contrato v2: gcode, identidad de org).

Revision ID: 0003
Revises: 0002
Create Date: 2026-10-18
"""
from alembic import op
import sqlalchemy as sa

revision = "0003"
down_revision = "0002"
branch_labels = None
depends_on = None


def upgrade() -> None:
    with op.batch_alter_table("printers") as batch:
        batch.add_column(sa.Column("model", sa.String(80), nullable=True))

    with op.batch_alter_table("organizations") as batch:
        batch.add_column(sa.Column("description", sa.Text(), nullable=True))
        batch.add_column(sa.Column("vision", sa.Text(), nullable=True))
        batch.add_column(sa.Column("mission", sa.Text(), nullable=True))
        batch.add_column(sa.Column("logo_path", sa.String(500),
                                   nullable=True))

    with op.batch_alter_table("print_jobs") as batch:
        batch.add_column(sa.Column("current_file", sa.String(255),
                                   nullable=True))


def downgrade() -> None:
    with op.batch_alter_table("print_jobs") as batch:
        batch.drop_column("current_file")

    with op.batch_alter_table("organizations") as batch:
        batch.drop_column("logo_path")
        batch.drop_column("mission")
        batch.drop_column("vision")
        batch.drop_column("description")

    with op.batch_alter_table("printers") as batch:
        batch.drop_column("model")
