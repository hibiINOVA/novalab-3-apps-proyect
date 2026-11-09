"""Multi-tenant: organization_id en todas las tablas operativas.

- Agrega `organization_id` (FK + índice) a: business, spools, printers,
  customers, products, orders, order_items, status_history, print_jobs.
- Backfill: si no hay organizaciones, crea `ORG-NOVA-101/NOVALAB` con el
  primer usuario owner (o el primero que haya); asigna todas las filas
  existentes a esa org y enlaza a los usuarios como `active`.
- `orders.folio`: quita el unique global y crea `uq_orders_org_folio
  (organization_id, folio)` (reconstrucción de tabla — SQLite no permite
  dropear el unique implícito por nombre).
- Re-key de settings: `queue_version` → `queue_version:{org_id}`.

Revision ID: 0005
Revises: 0004
Create Date: 2026-10-19
"""

from datetime import UTC, datetime

import sqlalchemy as sa
from alembic import op

revision = "0005"
down_revision = "0004"
branch_labels = None
depends_on = None

# Tablas operativas que reciben organization_id (además de orders, que se
# reconstruye aparte por el unique de folio).
_ORG_TABLES = (
    "business",
    "spools",
    "printers",
    "customers",
    "products",
    "order_items",
    "status_history",
    "print_jobs",
)


def _ensure_org(conn) -> int | None:
    """Org de backfill: la existente más antigua o una nueva demo."""
    org_id = conn.execute(
        sa.text("SELECT id FROM organizations ORDER BY id LIMIT 1")
    ).scalar()
    if org_id is not None:
        return org_id
    owner_id = conn.execute(
        sa.text("SELECT id FROM users WHERE role = 'owner' "
                "ORDER BY id LIMIT 1")
    ).scalar()
    if owner_id is None:
        owner_id = conn.execute(
            sa.text("SELECT id FROM users ORDER BY id LIMIT 1")
        ).scalar()
    if owner_id is None:
        return None  # BD vacía: el seed creará org y datos con org_id.
    now = datetime.now(UTC).isoformat()
    conn.execute(
        sa.text(
            "INSERT INTO organizations (code, name, owner_id, created_at) "
            "VALUES ('ORG-NOVA-101', 'NOVALAB', :oid, :now)"
        ),
        {"oid": owner_id, "now": now},
    )
    org_id = conn.execute(
        sa.text("SELECT id FROM organizations ORDER BY id LIMIT 1")
    ).scalar()
    conn.execute(
        sa.text(
            "UPDATE users SET organization_id = :org, "
            "membership_status = 'active' WHERE id = :oid"
        ),
        {"org": org_id, "oid": owner_id},
    )
    conn.execute(
        sa.text(
            "INSERT INTO organization_members "
            "(user_id, organization_id, status, created_at) "
            "VALUES (:oid, :org, 'active', :now)"
        ),
        {"oid": owner_id, "org": org_id, "now": now},
    )
    return org_id


def upgrade() -> None:
    conn = op.get_bind()
    org_id = _ensure_org(conn)

    # --- orders: reconstruir sin unique(folio) global, con org_id ---
    conn.execute(
        sa.text(
            """
            CREATE TABLE orders_new (
                id INTEGER NOT NULL PRIMARY KEY,
                folio VARCHAR(40) NOT NULL,
                organization_id INTEGER,
                customer_id INTEGER,
                status VARCHAR(30) NOT NULL,
                manual_status VARCHAR(30),
                promised_date DATE,
                total FLOAT NOT NULL,
                notes TEXT,
                tracking_token VARCHAR(64) NOT NULL,
                created_at DATETIME NOT NULL,
                carrier VARCHAR(80),
                tracking_number VARCHAR(80),
                tracking_url VARCHAR(500),
                shipped_at DATE,
                delivered_at DATE,
                CONSTRAINT uq_orders_org_folio
                    UNIQUE (organization_id, folio),
                FOREIGN KEY(customer_id) REFERENCES customers (id),
                FOREIGN KEY(organization_id) REFERENCES organizations (id)
            )
            """
        )
    )
    conn.execute(
        sa.text(
            """
            INSERT INTO orders_new (
                id, folio, organization_id, customer_id, status,
                manual_status, promised_date, total, notes, tracking_token,
                created_at, carrier, tracking_number, tracking_url,
                shipped_at, delivered_at
            )
            SELECT
                id, folio, :org, customer_id, status,
                manual_status, promised_date, total, notes, tracking_token,
                created_at, carrier, tracking_number, tracking_url,
                shipped_at, delivered_at
            FROM orders
            """
        ),
        {"org": org_id},
    )
    conn.execute(sa.text("DROP TABLE orders"))
    conn.execute(sa.text("ALTER TABLE orders_new RENAME TO orders"))
    conn.execute(
        sa.text("CREATE INDEX ix_orders_folio ON orders (folio)")
    )
    conn.execute(
        sa.text("CREATE INDEX ix_orders_organization_id "
                "ON orders (organization_id)")
    )
    conn.execute(
        sa.text("CREATE INDEX ix_orders_tracking_token "
                "ON orders (tracking_token)")
    )

    # --- resto de tablas operativas ---
    for table in _ORG_TABLES:
        with op.batch_alter_table(table) as batch:
            batch.add_column(
                sa.Column("organization_id", sa.Integer(), nullable=True)
            )
            batch.create_index(
                f"ix_{table}_organization_id", ["organization_id"]
            )
            batch.create_foreign_key(
                f"fk_{table}_organization_id", "organizations",
                ["organization_id"], ["id"],
            )
        if org_id is not None:
            conn.execute(
                sa.text(
                    f"UPDATE {table} SET organization_id = :org "
                    "WHERE organization_id IS NULL"
                ),
                {"org": org_id},
            )

    # business: unicidad 1:1 con la org.
    with op.batch_alter_table("business") as batch:
        batch.create_index(
            "uq_business_organization_id", ["organization_id"], unique=True
        )

    # --- settings: versión de cola por org ---
    if org_id is not None:
        conn.execute(
            sa.text(
                "UPDATE settings SET key = :new WHERE key = 'queue_version'"
            ),
            {"new": f"queue_version:{org_id}"},
        )


def downgrade() -> None:
    conn = op.get_bind()

    # Volver a unique global en folio (puede fallar si dos orgs repiten folio).
    conn.execute(
        sa.text(
            """
            CREATE TABLE orders_old (
                id INTEGER NOT NULL PRIMARY KEY,
                folio VARCHAR(40) NOT NULL UNIQUE,
                customer_id INTEGER,
                status VARCHAR(30) NOT NULL,
                manual_status VARCHAR(30),
                promised_date DATE,
                total FLOAT NOT NULL,
                notes TEXT,
                tracking_token VARCHAR(64) NOT NULL UNIQUE,
                created_at DATETIME NOT NULL,
                carrier VARCHAR(80),
                tracking_number VARCHAR(80),
                tracking_url VARCHAR(500),
                shipped_at DATE,
                delivered_at DATE,
                FOREIGN KEY(customer_id) REFERENCES customers (id)
            )
            """
        )
    )
    conn.execute(
        sa.text(
            """
            INSERT INTO orders_old (
                id, folio, customer_id, status, manual_status,
                promised_date, total, notes, tracking_token, created_at,
                carrier, tracking_number, tracking_url, shipped_at,
                delivered_at
            )
            SELECT
                id, folio, customer_id, status, manual_status,
                promised_date, total, notes, tracking_token, created_at,
                carrier, tracking_number, tracking_url, shipped_at,
                delivered_at
            FROM orders
            """
        )
    )
    conn.execute(sa.text("DROP TABLE orders"))
    conn.execute(sa.text("ALTER TABLE orders_old RENAME TO orders"))
    conn.execute(sa.text("CREATE INDEX ix_orders_folio ON orders (folio)"))
    conn.execute(
        sa.text("CREATE INDEX ix_orders_tracking_token "
                "ON orders (tracking_token)")
    )

    with op.batch_alter_table("business") as batch:
        batch.drop_index("uq_business_organization_id")
    for table in reversed(_ORG_TABLES):
        with op.batch_alter_table(table) as batch:
            batch.drop_constraint(
                f"fk_{table}_organization_id", type_="foreignkey"
            )
            batch.drop_index(f"ix_{table}_organization_id")
            batch.drop_column("organization_id")

    conn.execute(
        sa.text(
            "UPDATE settings SET key = 'queue_version' "
            "WHERE key LIKE 'queue_version:%'"
        )
    )
