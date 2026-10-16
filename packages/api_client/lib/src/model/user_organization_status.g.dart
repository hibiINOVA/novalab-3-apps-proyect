// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_organization_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UserOrganizationStatus extends UserOrganizationStatus {
  @override
  final MembershipStatus membershipStatus;
  @override
  final Organization? organization;
  @override
  final int? pendingRequestsCount;

  factory _$UserOrganizationStatus(
          [void Function(UserOrganizationStatusBuilder)? updates]) =>
      (UserOrganizationStatusBuilder()..update(updates))._build();

  _$UserOrganizationStatus._(
      {required this.membershipStatus,
      this.organization,
      this.pendingRequestsCount})
      : super._();
  @override
  UserOrganizationStatus rebuild(
          void Function(UserOrganizationStatusBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserOrganizationStatusBuilder toBuilder() =>
      UserOrganizationStatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserOrganizationStatus &&
        membershipStatus == other.membershipStatus &&
        organization == other.organization &&
        pendingRequestsCount == other.pendingRequestsCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, membershipStatus.hashCode);
    _$hash = $jc(_$hash, organization.hashCode);
    _$hash = $jc(_$hash, pendingRequestsCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserOrganizationStatus')
          ..add('membershipStatus', membershipStatus)
          ..add('organization', organization)
          ..add('pendingRequestsCount', pendingRequestsCount))
        .toString();
  }
}

class UserOrganizationStatusBuilder
    implements Builder<UserOrganizationStatus, UserOrganizationStatusBuilder> {
  _$UserOrganizationStatus? _$v;

  MembershipStatus? _membershipStatus;
  MembershipStatus? get membershipStatus => _$this._membershipStatus;
  set membershipStatus(MembershipStatus? membershipStatus) =>
      _$this._membershipStatus = membershipStatus;

  OrganizationBuilder? _organization;
  OrganizationBuilder get organization =>
      _$this._organization ??= OrganizationBuilder();
  set organization(OrganizationBuilder? organization) =>
      _$this._organization = organization;

  int? _pendingRequestsCount;
  int? get pendingRequestsCount => _$this._pendingRequestsCount;
  set pendingRequestsCount(int? pendingRequestsCount) =>
      _$this._pendingRequestsCount = pendingRequestsCount;

  UserOrganizationStatusBuilder() {
    UserOrganizationStatus._defaults(this);
  }

  UserOrganizationStatusBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _membershipStatus = $v.membershipStatus;
      _organization = $v.organization?.toBuilder();
      _pendingRequestsCount = $v.pendingRequestsCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserOrganizationStatus other) {
    _$v = other as _$UserOrganizationStatus;
  }

  @override
  void update(void Function(UserOrganizationStatusBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserOrganizationStatus build() => _build();

  _$UserOrganizationStatus _build() {
    _$UserOrganizationStatus _$result;
    try {
      _$result = _$v ??
          _$UserOrganizationStatus._(
            membershipStatus: BuiltValueNullFieldError.checkNotNull(
                membershipStatus,
                r'UserOrganizationStatus',
                'membershipStatus'),
            organization: _organization?.build(),
            pendingRequestsCount: pendingRequestsCount,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'organization';
        _organization?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'UserOrganizationStatus', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
