// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrganizationCreateRequest extends OrganizationCreateRequest {
  @override
  final String name;

  factory _$OrganizationCreateRequest(
          [void Function(OrganizationCreateRequestBuilder)? updates]) =>
      (OrganizationCreateRequestBuilder()..update(updates))._build();

  _$OrganizationCreateRequest._({required this.name}) : super._();
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
    return other is OrganizationCreateRequest && name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrganizationCreateRequest')
          ..add('name', name))
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

  OrganizationCreateRequestBuilder() {
    OrganizationCreateRequest._defaults(this);
  }

  OrganizationCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
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
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
