"""Catálogos: clientes y productos (multi-tenant: por organización)."""

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.db import get_db
from app.deps import get_current_org
from app.models import Customer, Organization, Product
from app.schemas import Customer as CustomerSchema, CustomerCreateRequest
from app.schemas import Product as ProductSchema, ProductCreateRequest

router = APIRouter(tags=["catalog"])


@router.get("/api/customers", operation_id="listCustomers",
            response_model=list[CustomerSchema])
def list_customers(db: Session = Depends(get_db),
                   org: Organization = Depends(get_current_org)):
    return db.scalars(
        select(Customer)
        .where(Customer.organization_id == org.id)
        .order_by(Customer.name)
    ).all()


@router.post("/api/customers", operation_id="createCustomer",
             response_model=CustomerSchema, status_code=201)
def create_customer(body: CustomerCreateRequest,
                    db: Session = Depends(get_db),
                    org: Organization = Depends(get_current_org)):
    customer = Customer(
        organization_id=org.id,
        name=body.name,
        phone=body.phone,
        email=body.email,
        notes=body.notes,
    )
    db.add(customer)
    db.flush()
    return customer


@router.get("/api/customers/{customer_id}", operation_id="getCustomer",
            response_model=CustomerSchema)
def get_customer(customer_id: int, db: Session = Depends(get_db),
                 org: Organization = Depends(get_current_org)):
    customer = db.get(Customer, customer_id)
    if customer is None or customer.organization_id != org.id:
        raise HTTPException(404, {"code": "not_found",
                                  "message": "Cliente no encontrado."})
    return customer


@router.get("/api/products", operation_id="listProducts",
            response_model=list[ProductSchema])
def list_products(db: Session = Depends(get_db),
                  org: Organization = Depends(get_current_org)):
    return db.scalars(
        select(Product)
        .where(Product.organization_id == org.id)
        .order_by(Product.name)
    ).all()


@router.post("/api/products", operation_id="createProduct",
             response_model=ProductSchema, status_code=201)
def create_product(body: ProductCreateRequest,
                   db: Session = Depends(get_db),
                   org: Organization = Depends(get_current_org)):
    product = Product(organization_id=org.id, **body.model_dump())
    db.add(product)
    db.flush()
    return product
