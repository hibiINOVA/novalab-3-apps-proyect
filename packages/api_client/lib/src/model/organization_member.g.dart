// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_member.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrganizationMember extends OrganizationMember {
  @override
  final int id;
  @override
  final int userId;
  @override
  final String userName;
  @override
  final String userEmail;
  @override
  final Role role;
  @override
  final MembershipStatus status;
  @override
  final String? organizationCode;
  @override
  final String? organizationName;
  @override
  final DateTime? createdAt;

  factory _$OrganizationMember(
          [void Function(OrganizationMemberBuilder)? updates]) =>
      (OrganizationMemberBuilder()..update(updates))._build();

  _$OrganizationMember._(
      {required this.id,
      required this.userId,
      required this.userName,
      required this.userEmail,
      required this.role,
      required this.status,
      this.organizationCode,
      this.organizationName,
      this.createdAt})
      : super._();
  @override
  OrganizationMember rebuild(
          void Function(OrganizationMemberBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrganizationMemberBuilder toBuilder() =>
      OrganizationMemberBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrganizationMember &&
        id == other.id &&
        userId == other.userId &&
        userName == other.userName &&
        userEmail == other.userEmail &&
        role == other.role &&
        status == other.status &&
        organizationCode == other.organizationCode &&
        organizationName == other.organizationName &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, userName.hashCode);
    _$hash = $jc(_$hash, userEmail.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, organizationCode.hashCode);
    _$hash = $jc(_$hash, organizationName.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrganizationMember')
          ..add('id', id)
          ..add('userId', userId)
          ..add('userName', userName)
          ..add('userEmail', userEmail)
          ..add('role', role)
          ..add('status', status)
          ..add('organizationCode', organizationCode)
          ..add('organizationName', organizationName)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class OrganizationMemberBuilder
    implements Builder<OrganizationMember, OrganizationMemberBuilder> {
  _$OrganizationMember? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _userName;
  String? get userName => _$this._userName;
  set userName(String? userName) => _$this._userName = userName;

  String? _userEmail;
  String? get userEmail => _$this._userEmail;
  set userEmail(String? userEmail) => _$this._userEmail = userEmail;

  Role? _role;
  Role? get role => _$this._role;
  set role(Role? role) => _$this._role = role;

  MembershipStatus? _status;
  MembershipStatus? get status => _$this._status;
  set status(MembershipStatus? status) => _$this._status = status;

  String? _organizationCode;
  String? get organizationCode => _$this._organizationCode;
  set organizationCode(String? organizationCode) =>
      _$this._organizationCode = organizationCode;

  String? _organizationName;
  String? get organizationName => _$this._organizationName;
  set organizationName(String? organizationName) =>
      _$this._organizationName = organizationName;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  OrganizationMemberBuilder() {
    OrganizationMember._defaults(this);
  }

  OrganizationMemberBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _userId = $v.userId;
      _userName = $v.userName;
      _userEmail = $v.userEmail;
      _role = $v.role;
      _status = $v.status;
      _organizationCode = $v.organizationCode;
      _organizationName = $v.organizationName;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrganizationMember other) {
    _$v = other as _$OrganizationMember;
  }

  @override
  void update(void Function(OrganizationMemberBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrganizationMember build() => _build();

  _$OrganizationMember _build() {
    final _$result = _$v ??
        _$OrganizationMember._(
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'OrganizationMember', 'id'),
          userId: BuiltValueNullFieldError.checkNotNull(
              userId, r'OrganizationMember', 'userId'),
          userName: BuiltValueNullFieldError.checkNotNull(
              userName, r'OrganizationMember', 'userName'),
          userEmail: BuiltValueNullFieldError.checkNotNull(
              userEmail, r'OrganizationMember', 'userEmail'),
          role: BuiltValueNullFieldError.checkNotNull(
              role, r'OrganizationMember', 'role'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'OrganizationMember', 'status'),
          organizationCode: organizationCode,
          organizationName: organizationName,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
