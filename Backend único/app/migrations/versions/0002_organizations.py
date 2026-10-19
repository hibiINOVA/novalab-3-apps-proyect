"""Organizaciones: tablas organizations/organization_members y columnas
de membresía en users (contrato /api/organizations*).

Revision ID: 0002
Revises: 0001
Create Date: 2026-10-16
"""
from alembic import op
import sqlalchemy as sa

revision = "0002"
down_revision = "0001"
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.create_table(
        "organizations",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("code", sa.String(40), nullable=False, unique=True),
        sa.Column("name", sa.String(120), nullable=False, unique=True),
        sa.Column("owner_id", sa.Integer, sa.ForeignKey("users.id"),
                  nullable=False),
        sa.Column("created_at", sa.DateTime, nullable=False),
    )
    op.create_index("ix_organizations_code", "organizations", ["code"])

    op.create_table(
        "organization_members",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("user_id", sa.Integer, sa.ForeignKey("users.id"),
                  nullable=False),
        sa.Column("organization_id", sa.Integer,
                  sa.ForeignKey("organizations.id"), nullable=False),
        sa.Column("status", sa.String(20), nullable=False),
        sa.Column("created_at", sa.DateTime, nullable=False),
    )
    op.create_index("ix_organization_members_user_id",
                    "organization_members", ["user_id"])
    op.create_index("ix_organization_members_organization_id",
                    "organization_members", ["organization_id"])

    # SQLite no soporta ALTER con constraints → batch (copy-and-move).
    with op.batch_alter_table("users") as batch_op:
        batch_op.add_column(
            sa.Column("organization_id", sa.Integer, nullable=True),
        )
        batch_op.add_column(
            sa.Column("membership_status", sa.String(20), nullable=False,
                      server_default="none"),
        )
        batch_op.create_index("ix_users_organization_id", ["organization_id"])
        batch_op.create_foreign_key(
            "fk_users_organization_id", "organizations",
            ["organization_id"], ["id"],
        )


def downgrade() -> None:
    with op.batch_alter_table("users") as batch_op:
        batch_op.drop_constraint("fk_users_organization_id", type_="foreignkey")
        batch_op.drop_index("ix_users_organization_id")
        batch_op.drop_column("membership_status")
        batch_op.drop_column("organization_id")
    op.drop_table("organization_members")
    op.drop_table("organizations")
