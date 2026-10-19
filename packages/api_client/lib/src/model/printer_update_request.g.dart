// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer_update_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PrinterUpdateRequest extends PrinterUpdateRequest {
  @override
  final String? name;
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
  @override
  final PrinterState? state;

  factory _$PrinterUpdateRequest(
          [void Function(PrinterUpdateRequestBuilder)? updates]) =>
      (PrinterUpdateRequestBuilder()..update(updates))._build();

  _$PrinterUpdateRequest._(
      {this.name,
      this.model,
      this.octoprintUrl,
      this.apiKey,
      this.bedWidth,
      this.bedDepth,
      this.cameraAvailable,
      this.cameras,
      this.state})
      : super._();
  @override
  PrinterUpdateRequest rebuild(
          void Function(PrinterUpdateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrinterUpdateRequestBuilder toBuilder() =>
      PrinterUpdateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrinterUpdateRequest &&
        name == other.name &&
        model == other.model &&
        octoprintUrl == other.octoprintUrl &&
        apiKey == other.apiKey &&
        bedWidth == other.bedWidth &&
        bedDepth == other.bedDepth &&
        cameraAvailable == other.cameraAvailable &&
        cameras == other.cameras &&
        state == other.state;
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
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrinterUpdateRequest')
          ..add('name', name)
          ..add('model', model)
          ..add('octoprintUrl', octoprintUrl)
          ..add('apiKey', apiKey)
          ..add('bedWidth', bedWidth)
          ..add('bedDepth', bedDepth)
          ..add('cameraAvailable', cameraAvailable)
          ..add('cameras', cameras)
          ..add('state', state))
        .toString();
  }
}

class PrinterUpdateRequestBuilder
    implements Builder<PrinterUpdateRequest, PrinterUpdateRequestBuilder> {
  _$PrinterUpdateRequest? _$v;

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

  PrinterState? _state;
  PrinterState? get state => _$this._state;
  set state(PrinterState? state) => _$this._state = state;

  PrinterUpdateRequestBuilder() {
    PrinterUpdateRequest._defaults(this);
  }

  PrinterUpdateRequestBuilder get _$this {
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
      _state = $v.state;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrinterUpdateRequest other) {
    _$v = other as _$PrinterUpdateRequest;
  }

  @override
  void update(void Function(PrinterUpdateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrinterUpdateRequest build() => _build();

  _$PrinterUpdateRequest _build() {
    _$PrinterUpdateRequest _$result;
    try {
      _$result = _$v ??
          _$PrinterUpdateRequest._(
            name: name,
            model: model,
            octoprintUrl: octoprintUrl,
            apiKey: apiKey,
            bedWidth: bedWidth,
            bedDepth: bedDepth,
            cameraAvailable: cameraAvailable,
            cameras: _cameras?.build(),
            state: state,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'cameras';
        _cameras?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PrinterUpdateRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
