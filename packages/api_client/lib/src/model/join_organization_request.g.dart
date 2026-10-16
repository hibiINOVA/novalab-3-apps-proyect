// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_organization_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$JoinOrganizationRequest extends JoinOrganizationRequest {
  @override
  final String organizationCode;

  factory _$JoinOrganizationRequest(
          [void Function(JoinOrganizationRequestBuilder)? updates]) =>
      (JoinOrganizationRequestBuilder()..update(updates))._build();

  _$JoinOrganizationRequest._({required this.organizationCode}) : super._();
  @override
  JoinOrganizationRequest rebuild(
          void Function(JoinOrganizationRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  JoinOrganizationRequestBuilder toBuilder() =>
      JoinOrganizationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is JoinOrganizationRequest &&
        organizationCode == other.organizationCode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, organizationCode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'JoinOrganizationRequest')
          ..add('organizationCode', organizationCode))
        .toString();
  }
}

class JoinOrganizationRequestBuilder
    implements
        Builder<JoinOrganizationRequest, JoinOrganizationRequestBuilder> {
  _$JoinOrganizationRequest? _$v;

  String? _organizationCode;
  String? get organizationCode => _$this._organizationCode;
  set organizationCode(String? organizationCode) =>
      _$this._organizationCode = organizationCode;

  JoinOrganizationRequestBuilder() {
    JoinOrganizationRequest._defaults(this);
  }

  JoinOrganizationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _organizationCode = $v.organizationCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(JoinOrganizationRequest other) {
    _$v = other as _$JoinOrganizationRequest;
  }

  @override
  void update(void Function(JoinOrganizationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  JoinOrganizationRequest build() => _build();

  _$JoinOrganizationRequest _build() {
    final _$result = _$v ??
        _$JoinOrganizationRequest._(
          organizationCode: BuiltValueNullFieldError.checkNotNull(
              organizationCode, r'JoinOrganizationRequest', 'organizationCode'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
