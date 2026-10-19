// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer_connection_test_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PrinterConnectionTestRequest extends PrinterConnectionTestRequest {
  @override
  final String octoprintUrl;
  @override
  final String? apiKey;

  factory _$PrinterConnectionTestRequest(
          [void Function(PrinterConnectionTestRequestBuilder)? updates]) =>
      (PrinterConnectionTestRequestBuilder()..update(updates))._build();

  _$PrinterConnectionTestRequest._({required this.octoprintUrl, this.apiKey})
      : super._();
  @override
  PrinterConnectionTestRequest rebuild(
          void Function(PrinterConnectionTestRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrinterConnectionTestRequestBuilder toBuilder() =>
      PrinterConnectionTestRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrinterConnectionTestRequest &&
        octoprintUrl == other.octoprintUrl &&
        apiKey == other.apiKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, octoprintUrl.hashCode);
    _$hash = $jc(_$hash, apiKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrinterConnectionTestRequest')
          ..add('octoprintUrl', octoprintUrl)
          ..add('apiKey', apiKey))
        .toString();
  }
}

class PrinterConnectionTestRequestBuilder
    implements
        Builder<PrinterConnectionTestRequest,
            PrinterConnectionTestRequestBuilder> {
  _$PrinterConnectionTestRequest? _$v;

  String? _octoprintUrl;
  String? get octoprintUrl => _$this._octoprintUrl;
  set octoprintUrl(String? octoprintUrl) => _$this._octoprintUrl = octoprintUrl;

  String? _apiKey;
  String? get apiKey => _$this._apiKey;
  set apiKey(String? apiKey) => _$this._apiKey = apiKey;

  PrinterConnectionTestRequestBuilder() {
    PrinterConnectionTestRequest._defaults(this);
  }

  PrinterConnectionTestRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _octoprintUrl = $v.octoprintUrl;
      _apiKey = $v.apiKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrinterConnectionTestRequest other) {
    _$v = other as _$PrinterConnectionTestRequest;
  }

  @override
  void update(void Function(PrinterConnectionTestRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrinterConnectionTestRequest build() => _build();

  _$PrinterConnectionTestRequest _build() {
    final _$result = _$v ??
        _$PrinterConnectionTestRequest._(
          octoprintUrl: BuiltValueNullFieldError.checkNotNull(
              octoprintUrl, r'PrinterConnectionTestRequest', 'octoprintUrl'),
          apiKey: apiKey,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
