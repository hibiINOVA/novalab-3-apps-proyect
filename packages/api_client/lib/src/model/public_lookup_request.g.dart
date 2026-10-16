// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_lookup_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PublicLookupRequest extends PublicLookupRequest {
  @override
  final String folio;
  @override
  final String phoneLast4;

  factory _$PublicLookupRequest(
          [void Function(PublicLookupRequestBuilder)? updates]) =>
      (PublicLookupRequestBuilder()..update(updates))._build();

  _$PublicLookupRequest._({required this.folio, required this.phoneLast4})
      : super._();
  @override
  PublicLookupRequest rebuild(
          void Function(PublicLookupRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PublicLookupRequestBuilder toBuilder() =>
      PublicLookupRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PublicLookupRequest &&
        folio == other.folio &&
        phoneLast4 == other.phoneLast4;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, folio.hashCode);
    _$hash = $jc(_$hash, phoneLast4.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PublicLookupRequest')
          ..add('folio', folio)
          ..add('phoneLast4', phoneLast4))
        .toString();
  }
}

class PublicLookupRequestBuilder
    implements Builder<PublicLookupRequest, PublicLookupRequestBuilder> {
  _$PublicLookupRequest? _$v;

  String? _folio;
  String? get folio => _$this._folio;
  set folio(String? folio) => _$this._folio = folio;

  String? _phoneLast4;
  String? get phoneLast4 => _$this._phoneLast4;
  set phoneLast4(String? phoneLast4) => _$this._phoneLast4 = phoneLast4;

  PublicLookupRequestBuilder() {
    PublicLookupRequest._defaults(this);
  }

  PublicLookupRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _folio = $v.folio;
      _phoneLast4 = $v.phoneLast4;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PublicLookupRequest other) {
    _$v = other as _$PublicLookupRequest;
  }

  @override
  void update(void Function(PublicLookupRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PublicLookupRequest build() => _build();

  _$PublicLookupRequest _build() {
    final _$result = _$v ??
        _$PublicLookupRequest._(
          folio: BuiltValueNullFieldError.checkNotNull(
              folio, r'PublicLookupRequest', 'folio'),
          phoneLast4: BuiltValueNullFieldError.checkNotNull(
              phoneLast4, r'PublicLookupRequest', 'phoneLast4'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
