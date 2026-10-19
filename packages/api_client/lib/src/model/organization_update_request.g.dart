// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_update_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrganizationUpdateRequest extends OrganizationUpdateRequest {
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? vision;
  @override
  final String? mission;

  factory _$OrganizationUpdateRequest(
          [void Function(OrganizationUpdateRequestBuilder)? updates]) =>
      (OrganizationUpdateRequestBuilder()..update(updates))._build();

  _$OrganizationUpdateRequest._(
      {this.name, this.description, this.vision, this.mission})
      : super._();
  @override
  OrganizationUpdateRequest rebuild(
          void Function(OrganizationUpdateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrganizationUpdateRequestBuilder toBuilder() =>
      OrganizationUpdateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrganizationUpdateRequest &&
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
    return (newBuiltValueToStringHelper(r'OrganizationUpdateRequest')
          ..add('name', name)
          ..add('description', description)
          ..add('vision', vision)
          ..add('mission', mission))
        .toString();
  }
}

class OrganizationUpdateRequestBuilder
    implements
        Builder<OrganizationUpdateRequest, OrganizationUpdateRequestBuilder> {
  _$OrganizationUpdateRequest? _$v;

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

  OrganizationUpdateRequestBuilder() {
    OrganizationUpdateRequest._defaults(this);
  }

  OrganizationUpdateRequestBuilder get _$this {
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
  void replace(OrganizationUpdateRequest other) {
    _$v = other as _$OrganizationUpdateRequest;
  }

  @override
  void update(void Function(OrganizationUpdateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrganizationUpdateRequest build() => _build();

  _$OrganizationUpdateRequest _build() {
    final _$result = _$v ??
        _$OrganizationUpdateRequest._(
          name: name,
          description: description,
          vision: vision,
          mission: mission,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
