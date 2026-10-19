// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PrinterCreateRequest extends PrinterCreateRequest {
  @override
  final String name;
  @override
  final String? model;
  @override
  final String? octoprintUrl;
  @override
  final String? apiKey;
  @override
  final double? bedWidth;
  @override
  final double? bedDepth;
  @override
  final bool? cameraAvailable;
  @override
  final BuiltList<String>? cameras;

  factory _$PrinterCreateRequest(
          [void Function(PrinterCreateRequestBuilder)? updates]) =>
      (PrinterCreateRequestBuilder()..update(updates))._build();

  _$PrinterCreateRequest._(
      {required this.name,
      this.model,
      this.octoprintUrl,
      this.apiKey,
      this.bedWidth,
      this.bedDepth,
      this.cameraAvailable,
      this.cameras})
      : super._();
  @override
  PrinterCreateRequest rebuild(
          void Function(PrinterCreateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrinterCreateRequestBuilder toBuilder() =>
      PrinterCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrinterCreateRequest &&
        name == other.name &&
        model == other.model &&
        octoprintUrl == other.octoprintUrl &&
        apiKey == other.apiKey &&
        bedWidth == other.bedWidth &&
        bedDepth == other.bedDepth &&
        cameraAvailable == other.cameraAvailable &&
        cameras == other.cameras;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, model.hashCode);
    _$hash = $jc(_$hash, octoprintUrl.hashCode);
    _$hash = $jc(_$hash, apiKey.hashCode);
    _$hash = $jc(_$hash, bedWidth.hashCode);
    _$hash = $jc(_$hash, bedDepth.hashCode);
    _$hash = $jc(_$hash, cameraAvailable.hashCode);
    _$hash = $jc(_$hash, cameras.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrinterCreateRequest')
          ..add('name', name)
          ..add('model', model)
          ..add('octoprintUrl', octoprintUrl)
          ..add('apiKey', apiKey)
          ..add('bedWidth', bedWidth)
          ..add('bedDepth', bedDepth)
          ..add('cameraAvailable', cameraAvailable)
          ..add('cameras', cameras))
        .toString();
  }
}

class PrinterCreateRequestBuilder
    implements Builder<PrinterCreateRequest, PrinterCreateRequestBuilder> {
  _$PrinterCreateRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _model;
  String? get model => _$this._model;
  set model(String? model) => _$this._model = model;

  String? _octoprintUrl;
  String? get octoprintUrl => _$this._octoprintUrl;
  set octoprintUrl(String? octoprintUrl) => _$this._octoprintUrl = octoprintUrl;

  String? _apiKey;
  String? get apiKey => _$this._apiKey;
  set apiKey(String? apiKey) => _$this._apiKey = apiKey;

  double? _bedWidth;
  double? get bedWidth => _$this._bedWidth;
  set bedWidth(double? bedWidth) => _$this._bedWidth = bedWidth;

  double? _bedDepth;
  double? get bedDepth => _$this._bedDepth;
  set bedDepth(double? bedDepth) => _$this._bedDepth = bedDepth;

  bool? _cameraAvailable;
  bool? get cameraAvailable => _$this._cameraAvailable;
  set cameraAvailable(bool? cameraAvailable) =>
      _$this._cameraAvailable = cameraAvailable;

  ListBuilder<String>? _cameras;
  ListBuilder<String> get cameras => _$this._cameras ??= ListBuilder<String>();
  set cameras(ListBuilder<String>? cameras) => _$this._cameras = cameras;

  PrinterCreateRequestBuilder() {
    PrinterCreateRequest._defaults(this);
  }

  PrinterCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _model = $v.model;
      _octoprintUrl = $v.octoprintUrl;
      _apiKey = $v.apiKey;
      _bedWidth = $v.bedWidth;
      _bedDepth = $v.bedDepth;
      _cameraAvailable = $v.cameraAvailable;
      _cameras = $v.cameras?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrinterCreateRequest other) {
    _$v = other as _$PrinterCreateRequest;
  }

  @override
  void update(void Function(PrinterCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrinterCreateRequest build() => _build();

  _$PrinterCreateRequest _build() {
    _$PrinterCreateRequest _$result;
    try {
      _$result = _$v ??
          _$PrinterCreateRequest._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, r'PrinterCreateRequest', 'name'),
            model: model,
            octoprintUrl: octoprintUrl,
            apiKey: apiKey,
            bedWidth: bedWidth,
            bedDepth: bedDepth,
            cameraAvailable: cameraAvailable,
            cameras: _cameras?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'cameras';
        _cameras?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PrinterCreateRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
