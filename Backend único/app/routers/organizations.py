"""Organizaciones: crear, editar, estado actual, unirse, miembros, logo y
aprobar/rechazar solicitudes. `operation_id` idénticos al contrato."""

import random

from fastapi import APIRouter, Depends, File, HTTPException, UploadFile
from fastapi.responses import FileResponse
from sqlalchemy import func, select
from sqlalchemy.orm import Session

from app.db import get_db
from app.deps import get_current_user, require_owner
from app.models import (
    Organization,
    OrganizationMember,
    User,
)
from app.schemas import (
    JoinOrganizationRequest,
    MembershipStatus,
    Organization as OrganizationSchema,
    OrganizationCreateRequest,
    OrganizationMember as OrganizationMemberSchema,
    OrganizationUpdateRequest,
    UserOrganizationStatus,
)
from app.storage import (
    LOGO_EXTENSIONS,
    LOGO_MEDIA_TYPES,
    MAX_LOGO_BYTES,
    delete_file,
    read_upload,
    save_file,
    storage_dir,
)

router = APIRouter(prefix="/api/organizations", tags=["organizations"])


def _org_status(
    db: Session, user: User, status: MembershipStatus
) -> UserOrganizationStatus:
    pending = 0
    if user.organization_id is not None:
        pending = db.scalar(
            select(func.count(OrganizationMember.id)).where(
                OrganizationMember.organization_id == user.organization_id,
                OrganizationMember.status == MembershipStatus.pending.value,
            )
        ) or 0
    return UserOrganizationStatus(
        organization=user.organization,
        membership_status=status,
        pending_requests_count=pending,
    )


def _member_schema(member: OrganizationMember) -> OrganizationMemberSchema:
    return OrganizationMemberSchema(
        id=member.id,
        user_id=member.user_id,
        user_name=member.user.name,
        user_email=member.user.email,
        role=member.user.role,
        status=member.status,
        organization_code=member.organization.code,
        organization_name=member.organization.name,
        created_at=member.created_at,
    )


@router.post(
    "",
    operation_id="createOrganization",
    response_model=OrganizationSchema,
    status_code=201,
)
def create_organization(
    body: OrganizationCreateRequest,
    user: User = Depends(require_owner),
    db: Session = Depends(get_db),
):
    name = body.name.strip()
    if user.organization_id is not None and user.membership_status in (
        MembershipStatus.active.value,
        MembershipStatus.pending.value,
    ):
        raise HTTPException(
            status_code=400,
            detail={"code": "already_in_organization",
                    "message": "Ya perteneces a una organización."},
        )
    exists = db.scalar(
        select(Organization).where(func.lower(Organization.name) == name.lower())
    )
    if exists is not None:
        raise HTTPException(
            status_code=400,
            detail={"code": "name_taken",
                    "message": "Ese nombre de organización ya está en uso."},
        )
    def _clean(value: str | None) -> str | None:
        return value.strip() or None if value else None

    org = Organization(name=name, owner_id=user.id,
                       code=_generate_code(db, name),
                       description=_clean(body.description),
                       vision=_clean(body.vision),
                       mission=_clean(body.mission))
    db.add(org)
    db.flush()  # asigna org.id
    db.add(
        OrganizationMember(
            user_id=user.id,
            organization_id=org.id,
            status=MembershipStatus.active.value,
        )
    )
    user.organization_id = org.id
    user.membership_status = MembershipStatus.active.value
    db.commit()
    db.refresh(org)
    return org


def _generate_code(db: Session, name: str) -> str:
    clean = "".join(name.split()).upper()
    prefix = clean[:4].ljust(4, "X")
    while True:
        suffix = random.randint(1000, 9999)
        code = f"ORG-{prefix}-{suffix}"
        taken = db.scalar(
            select(Organization).where(Organization.code == code)
        )
        if taken is None:
            return code


def _require_org(user: User) -> Organization:
    if user.organization_id is None or user.organization is None:
        raise HTTPException(
            status_code=404,
            detail={"code": "not_found",
                    "message": "No perteneces a ninguna organización."},
        )
    return user.organization


@router.patch(
    "",
    operation_id="updateOrganization",
    response_model=OrganizationSchema,
)
def update_organization(
    body: OrganizationUpdateRequest,
    user: User = Depends(require_owner),
    db: Session = Depends(get_db),
):
    org = _require_org(user)
    data = body.model_dump(exclude_unset=True)
    if "name" in data and data["name"] is not None:
        new_name = data["name"].strip()
        taken = db.scalar(
            select(Organization).where(
                func.lower(Organization.name) == new_name.lower(),
                Organization.id != org.id,
            )
        )
        if taken is not None:
            raise HTTPException(
                status_code=400,
                detail={"code": "name_taken",
                        "message": "Ese nombre de organización ya está en uso."},
            )
        org.name = new_name
    for field in ("description", "vision", "mission"):
        if field in data:
            value = data[field]
            setattr(org, field, value.strip() or None if value else None)
    db.commit()
    db.refresh(org)
    return org


@router.get(
    "/members",
    operation_id="listOrganizationMembers",
    response_model=list[OrganizationMemberSchema],
)
def list_organization_members(
    user: User = Depends(require_owner),
    db: Session = Depends(get_db),
):
    if user.organization_id is None:
        return []
    rows = db.scalars(
        select(OrganizationMember).where(
            OrganizationMember.organization_id == user.organization_id,
            OrganizationMember.status == MembershipStatus.active.value,
        ).order_by(OrganizationMember.id)
    ).all()
    return [_member_schema(m) for m in rows]


@router.post(
    "/logo",
    operation_id="uploadOrganizationLogo",
    response_model=OrganizationSchema,
)
async def upload_organization_logo(
    file: UploadFile = File(...),
    user: User = Depends(require_owner),
    db: Session = Depends(get_db),
):
    org = _require_org(user)
    filename, data = await read_upload(file, MAX_LOGO_BYTES,
                                       LOGO_EXTENSIONS, "logo")
    ext = filename[filename.rfind("."):]
    delete_file(org.logo_path)
    rel = f"logos/{org.id}/logo{ext}"
    save_file(f"logos/{org.id}", f"logo{ext}", data)
    org.logo_path = rel
    db.commit()
    db.refresh(org)
    return org


@router.get("/logo", operation_id="downloadOrganizationLogo")
def download_organization_logo(
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    org = _require_org(user)
    if not org.logo_path:
        raise HTTPException(
            status_code=404,
            detail={"code": "not_found",
                    "message": "La organización no tiene logo."},
        )
    path = storage_dir() / org.logo_path
    if not path.is_file():
        raise HTTPException(
            status_code=404,
            detail={"code": "not_found", "message": "Logo no encontrado."},
        )
    media = LOGO_MEDIA_TYPES.get(path.suffix.lower(), "image/png")
    return FileResponse(path, media_type=media)


@router.delete(
    "/logo",
    operation_id="deleteOrganizationLogo",
    response_model=OrganizationSchema,
)
def delete_organization_logo(
    user: User = Depends(require_owner),
    db: Session = Depends(get_db),
):
    org = _require_org(user)
    delete_file(org.logo_path)
    org.logo_path = None
    db.commit()
    db.refresh(org)
    return org


@router.get(
    "/current",
    operation_id="getCurrentOrganization",
    response_model=UserOrganizationStatus,
)
def get_current_organization(
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    status = (
        MembershipStatus(user.membership_status)
        if user.membership_status in MembershipStatus._value2member_map_
        else MembershipStatus.none
    )
    return _org_status(db, user, status)


@router.post(
    "/join",
    operation_id="joinOrganization",
    response_model=UserOrganizationStatus,
)
def join_organization(
    body: JoinOrganizationRequest,
    user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    code = body.organization_code.strip().upper()
    org = db.scalar(
        select(Organization).where(func.upper(Organization.code) == code)
    )
    if org is None:
        raise HTTPException(
            status_code=404,
            detail={"code": "not_found",
                    "message": "Organización no encontrada con ese ID."},
        )
    member = db.scalar(
        select(OrganizationMember).where(
            OrganizationMember.user_id == user.id,
            OrganizationMember.organization_id == org.id,
        )
    )
    if member is None:
        member = OrganizationMember(
            user_id=user.id,
            organization_id=org.id,
            status=MembershipStatus.pending.value,
        )
        db.add(member)
    else:
        member.status = MembershipStatus.pending.value
    user.organization_id = org.id
    user.membership_status = MembershipStatus.pending.value
    db.commit()
    return _org_status(db, user, MembershipStatus.pending)


@router.get(
    "/requests",
    operation_id="listOrganizationRequests",
    response_model=list[OrganizationMemberSchema],
)
def list_organization_requests(
    user: User = Depends(require_owner),
    db: Session = Depends(get_db),
):
    if user.organization_id is None:
        return []
    rows = db.scalars(
        select(OrganizationMember).where(
            OrganizationMember.organization_id == user.organization_id,
            OrganizationMember.status == MembershipStatus.pending.value,
        )
    ).all()
    return [_member_schema(m) for m in rows]


def _approve_or_reject(
    db: Session, user: User, request_id: int, new_status: MembershipStatus
) -> OrganizationMember:
    member = db.get(OrganizationMember, request_id)
    if (
        member is None
        or member.organization_id != user.organization_id
        or member.status != MembershipStatus.pending.value
    ):
        raise HTTPException(
            status_code=404,
            detail={"code": "not_found", "message": "Solicitud no encontrada."},
        )
    member.status = new_status.value
    member_user = db.get(User, member.user_id)
    if member_user is not None:
        member_user.membership_status = new_status.value
    db.commit()
    db.refresh(member)
    return member


@router.post(
    "/requests/{requestId}/approve",
    operation_id="approveOrganizationRequest",
    response_model=OrganizationMemberSchema,
)
def approve_organization_request(
    requestId: int,
    user: User = Depends(require_owner),
    db: Session = Depends(get_db),
):
    return _member_schema(_approve_or_reject(db, user, requestId,
                                             MembershipStatus.active))


@router.post(
    "/requests/{requestId}/reject",
    operation_id="rejectOrganizationRequest",
    response_model=OrganizationMemberSchema,
)
def reject_organization_request(
    requestId: int,
    user: User = Depends(require_owner),
    db: Session = Depends(get_db),
):
    return _member_schema(_approve_or_reject(db, user, requestId,
                                             MembershipStatus.rejected))
