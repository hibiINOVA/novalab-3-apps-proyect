// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrganizationCreateRequest extends OrganizationCreateRequest {
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? vision;
  @override
  final String? mission;

  factory _$OrganizationCreateRequest(
          [void Function(OrganizationCreateRequestBuilder)? updates]) =>
      (OrganizationCreateRequestBuilder()..update(updates))._build();

  _$OrganizationCreateRequest._(
      {required this.name, this.description, this.vision, this.mission})
      : super._();
  @override
  OrganizationCreateRequest rebuild(
          void Function(OrganizationCreateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrganizationCreateRequestBuilder toBuilder() =>
      OrganizationCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrganizationCreateRequest &&
        name == other.name &&
        description == other.description &&
        vision == other.vision &&
        mission == other.mission;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, vision.hashCode);
    _$hash = $jc(_$hash, mission.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrganizationCreateRequest')
          ..add('name', name)
          ..add('description', description)
          ..add('vision', vision)
          ..add('mission', mission))
        .toString();
  }
}

class OrganizationCreateRequestBuilder
    implements
        Builder<OrganizationCreateRequest, OrganizationCreateRequestBuilder> {
  _$OrganizationCreateRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _vision;
  String? get vision => _$this._vision;
  set vision(String? vision) => _$this._vision = vision;

  String? _mission;
  String? get mission => _$this._mission;
  set mission(String? mission) => _$this._mission = mission;

  OrganizationCreateRequestBuilder() {
    OrganizationCreateRequest._defaults(this);
  }

  OrganizationCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _description = $v.description;
      _vision = $v.vision;
      _mission = $v.mission;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrganizationCreateRequest other) {
    _$v = other as _$OrganizationCreateRequest;
  }

  @override
  void update(void Function(OrganizationCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrganizationCreateRequest build() => _build();

  _$OrganizationCreateRequest _build() {
    final _$result = _$v ??
        _$OrganizationCreateRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'OrganizationCreateRequest', 'name'),
          description: description,
          vision: vision,
          mission: mission,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
