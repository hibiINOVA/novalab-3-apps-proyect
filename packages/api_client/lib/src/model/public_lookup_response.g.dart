// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_lookup_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PublicLookupResponse extends PublicLookupResponse {
  @override
  final String trackingToken;

  factory _$PublicLookupResponse(
          [void Function(PublicLookupResponseBuilder)? updates]) =>
      (PublicLookupResponseBuilder()..update(updates))._build();

  _$PublicLookupResponse._({required this.trackingToken}) : super._();
  @override
  PublicLookupResponse rebuild(
          void Function(PublicLookupResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PublicLookupResponseBuilder toBuilder() =>
      PublicLookupResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PublicLookupResponse &&
        trackingToken == other.trackingToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, trackingToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PublicLookupResponse')
          ..add('trackingToken', trackingToken))
        .toString();
  }
}

class PublicLookupResponseBuilder
    implements Builder<PublicLookupResponse, PublicLookupResponseBuilder> {
  _$PublicLookupResponse? _$v;

  String? _trackingToken;
  String? get trackingToken => _$this._trackingToken;
  set trackingToken(String? trackingToken) =>
      _$this._trackingToken = trackingToken;

  PublicLookupResponseBuilder() {
    PublicLookupResponse._defaults(this);
  }

  PublicLookupResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _trackingToken = $v.trackingToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PublicLookupResponse other) {
    _$v = other as _$PublicLookupResponse;
  }

  @override
  void update(void Function(PublicLookupResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PublicLookupResponse build() => _build();

  _$PublicLookupResponse _build() {
    final _$result = _$v ??
        _$PublicLookupResponse._(
          trackingToken: BuiltValueNullFieldError.checkNotNull(
              trackingToken, r'PublicLookupResponse', 'trackingToken'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
