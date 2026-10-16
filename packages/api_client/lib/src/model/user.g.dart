// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$User extends User {
  @override
  final int id;
  @override
  final String name;
  @override
  final String email;
  @override
  final Role role;
  @override
  final int? organizationId;
  @override
  final String? organizationCode;
  @override
  final MembershipStatus? membershipStatus;

  factory _$User([void Function(UserBuilder)? updates]) =>
      (UserBuilder()..update(updates))._build();

  _$User._(
      {required this.id,
      required this.name,
      required this.email,
      required this.role,
      this.organizationId,
      this.organizationCode,
      this.membershipStatus})
      : super._();
  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        id == other.id &&
        name == other.name &&
        email == other.email &&
        role == other.role &&
        organizationId == other.organizationId &&
        organizationCode == other.organizationCode &&
        membershipStatus == other.membershipStatus;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, organizationId.hashCode);
    _$hash = $jc(_$hash, organizationCode.hashCode);
    _$hash = $jc(_$hash, membershipStatus.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'User')
          ..add('id', id)
          ..add('name', name)
          ..add('email', email)
          ..add('role', role)
          ..add('organizationId', organizationId)
          ..add('organizationCode', organizationCode)
          ..add('membershipStatus', membershipStatus))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  Role? _role;
  Role? get role => _$this._role;
  set role(Role? role) => _$this._role = role;

  int? _organizationId;
  int? get organizationId => _$this._organizationId;
  set organizationId(int? organizationId) =>
      _$this._organizationId = organizationId;

  String? _organizationCode;
  String? get organizationCode => _$this._organizationCode;
  set organizationCode(String? organizationCode) =>
      _$this._organizationCode = organizationCode;

  MembershipStatus? _membershipStatus;
  MembershipStatus? get membershipStatus => _$this._membershipStatus;
  set membershipStatus(MembershipStatus? membershipStatus) =>
      _$this._membershipStatus = membershipStatus;

  UserBuilder() {
    User._defaults(this);
  }

  UserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _email = $v.email;
      _role = $v.role;
      _organizationId = $v.organizationId;
      _organizationCode = $v.organizationCode;
      _membershipStatus = $v.membershipStatus;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  User build() => _build();

  _$User _build() {
    final _$result = _$v ??
        _$User._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'User', 'id'),
          name: BuiltValueNullFieldError.checkNotNull(name, r'User', 'name'),
          email: BuiltValueNullFieldError.checkNotNull(email, r'User', 'email'),
          role: BuiltValueNullFieldError.checkNotNull(role, r'User', 'role'),
          organizationId: organizationId,
          organizationCode: organizationCode,
          membershipStatus: membershipStatus,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
