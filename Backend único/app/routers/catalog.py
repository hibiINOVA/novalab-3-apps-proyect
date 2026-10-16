"""Catálogos: clientes y productos."""

from fastapi import APIRouter, Depends
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.db import get_db
from app.deps import get_current_user
from app.models import Customer, Product
from app.schemas import Customer as CustomerSchema
from app.schemas import Product as ProductSchema

router = APIRouter(tags=["catalog"])


@router.get("/api/customers", operation_id="listCustomers",
            response_model=list[CustomerSchema])
def list_customers(db: Session = Depends(get_db),
                   _user=Depends(get_current_user)):
    return db.scalars(select(Customer).order_by(Customer.name)).all()


@router.get("/api/products", operation_id="listProducts",
            response_model=list[ProductSchema])
def list_products(db: Session = Depends(get_db),
                  _user=Depends(get_current_user)):
    return db.scalars(select(Product).order_by(Product.name)).all()
