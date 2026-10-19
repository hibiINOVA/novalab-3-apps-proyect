"""Multi-cámara (camera_urls JSON) + cifrado de API keys en reposo (BE-20).

Revision ID: 0004
Revises: 0003
Create Date: 2026-10-19
"""
import json

import sqlalchemy as sa
from alembic import op

revision = "0004"
down_revision = "0003"
branch_labels = None
depends_on = None


def upgrade() -> None:
    with op.batch_alter_table("printers") as batch:
        batch.add_column(sa.Column("camera_urls", sa.Text(), nullable=True))

    # BE-20: cifra API keys que quedaron en plaintext (seed/demo).
    from app.security import encrypt_secret

    conn = op.get_bind()
    rows = conn.execute(
        sa.text("SELECT id, api_key_encrypted FROM printers "
                "WHERE api_key_encrypted IS NOT NULL")
    ).fetchall()
    for printer_id, stored in rows:
        if stored and not stored.startswith("fernet:"):
            conn.execute(
                sa.text(
                    "UPDATE printers SET api_key_encrypted = :val "
                    "WHERE id = :pid"
                ),
                {"val": encrypt_secret(stored), "pid": printer_id},
            )

    # Migra snapshot_url singular → camera_urls (JSON array) si existía.
    rows = conn.execute(
        sa.text("SELECT id, snapshot_url FROM printers "
                "WHERE snapshot_url IS NOT NULL")
    ).fetchall()
    for printer_id, snap in rows:
        conn.execute(
            sa.text("UPDATE printers SET camera_urls = :val WHERE id = :pid"),
            {"val": json.dumps([snap]), "pid": printer_id},
        )


def downgrade() -> None:
    with op.batch_alter_table("printers") as batch:
        batch.drop_column("camera_urls")
