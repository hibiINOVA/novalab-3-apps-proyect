// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Organization extends Organization {
  @override
  final int id;
  @override
  final String code;
  @override
  final String name;
  @override
  final int ownerId;
  @override
  final String? description;
  @override
  final String? vision;
  @override
  final String? mission;
  @override
  final bool? hasLogo;
  @override
  final DateTime? createdAt;

  factory _$Organization([void Function(OrganizationBuilder)? updates]) =>
      (OrganizationBuilder()..update(updates))._build();

  _$Organization._(
      {required this.id,
      required this.code,
      required this.name,
      required this.ownerId,
      this.description,
      this.vision,
      this.mission,
      this.hasLogo,
      this.createdAt})
      : super._();
  @override
  Organization rebuild(void Function(OrganizationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrganizationBuilder toBuilder() => OrganizationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Organization &&
        id == other.id &&
        code == other.code &&
        name == other.name &&
        ownerId == other.ownerId &&
        description == other.description &&
        vision == other.vision &&
        mission == other.mission &&
        hasLogo == other.hasLogo &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, ownerId.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, vision.hashCode);
    _$hash = $jc(_$hash, mission.hashCode);
    _$hash = $jc(_$hash, hasLogo.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Organization')
          ..add('id', id)
          ..add('code', code)
          ..add('name', name)
          ..add('ownerId', ownerId)
          ..add('description', description)
          ..add('vision', vision)
          ..add('mission', mission)
          ..add('hasLogo', hasLogo)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class OrganizationBuilder
    implements Builder<Organization, OrganizationBuilder> {
  _$Organization? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _ownerId;
  int? get ownerId => _$this._ownerId;
  set ownerId(int? ownerId) => _$this._ownerId = ownerId;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _vision;
  String? get vision => _$this._vision;
  set vision(String? vision) => _$this._vision = vision;

  String? _mission;
  String? get mission => _$this._mission;
  set mission(String? mission) => _$this._mission = mission;

  bool? _hasLogo;
  bool? get hasLogo => _$this._hasLogo;
  set hasLogo(bool? hasLogo) => _$this._hasLogo = hasLogo;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  OrganizationBuilder() {
    Organization._defaults(this);
  }

  OrganizationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _code = $v.code;
      _name = $v.name;
      _ownerId = $v.ownerId;
      _description = $v.description;
      _vision = $v.vision;
      _mission = $v.mission;
      _hasLogo = $v.hasLogo;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Organization other) {
    _$v = other as _$Organization;
  }

  @override
  void update(void Function(OrganizationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Organization build() => _build();

  _$Organization _build() {
    final _$result = _$v ??
        _$Organization._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Organization', 'id'),
          code: BuiltValueNullFieldError.checkNotNull(
              code, r'Organization', 'code'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'Organization', 'name'),
          ownerId: BuiltValueNullFieldError.checkNotNull(
              ownerId, r'Organization', 'ownerId'),
          description: description,
          vision: vision,
          mission: mission,
          hasLogo: hasLogo,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
