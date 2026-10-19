// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Printer extends Printer {
  @override
  final int id;
  @override
  final String name;
  @override
  final PrinterState state;
  @override
  final String? model;
  @override
  final double? progress;
  @override
  final int? remainingSeconds;
  @override
  final double? nozzleTemp;
  @override
  final double? nozzleTarget;
  @override
  final double? bedTemp;
  @override
  final double? bedTarget;
  @override
  final String? currentFile;
  @override
  final bool? cameraAvailable;
  @override
  final BuiltList<String>? cameras;
  @override
  final SpoolRef? loadedSpool;
  @override
  final OrderRef? currentOrder;
  @override
  final DateTime? lastSeen;

  factory _$Printer([void Function(PrinterBuilder)? updates]) =>
      (PrinterBuilder()..update(updates))._build();

  _$Printer._(
      {required this.id,
      required this.name,
      required this.state,
      this.model,
      this.progress,
      this.remainingSeconds,
      this.nozzleTemp,
      this.nozzleTarget,
      this.bedTemp,
      this.bedTarget,
      this.currentFile,
      this.cameraAvailable,
      this.cameras,
      this.loadedSpool,
      this.currentOrder,
      this.lastSeen})
      : super._();
  @override
  Printer rebuild(void Function(PrinterBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrinterBuilder toBuilder() => PrinterBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Printer &&
        id == other.id &&
        name == other.name &&
        state == other.state &&
        model == other.model &&
        progress == other.progress &&
        remainingSeconds == other.remainingSeconds &&
        nozzleTemp == other.nozzleTemp &&
        nozzleTarget == other.nozzleTarget &&
        bedTemp == other.bedTemp &&
        bedTarget == other.bedTarget &&
        currentFile == other.currentFile &&
        cameraAvailable == other.cameraAvailable &&
        cameras == other.cameras &&
        loadedSpool == other.loadedSpool &&
        currentOrder == other.currentOrder &&
        lastSeen == other.lastSeen;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, model.hashCode);
    _$hash = $jc(_$hash, progress.hashCode);
    _$hash = $jc(_$hash, remainingSeconds.hashCode);
    _$hash = $jc(_$hash, nozzleTemp.hashCode);
    _$hash = $jc(_$hash, nozzleTarget.hashCode);
    _$hash = $jc(_$hash, bedTemp.hashCode);
    _$hash = $jc(_$hash, bedTarget.hashCode);
    _$hash = $jc(_$hash, currentFile.hashCode);
    _$hash = $jc(_$hash, cameraAvailable.hashCode);
    _$hash = $jc(_$hash, cameras.hashCode);
    _$hash = $jc(_$hash, loadedSpool.hashCode);
    _$hash = $jc(_$hash, currentOrder.hashCode);
    _$hash = $jc(_$hash, lastSeen.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Printer')
          ..add('id', id)
          ..add('name', name)
          ..add('state', state)
          ..add('model', model)
          ..add('progress', progress)
          ..add('remainingSeconds', remainingSeconds)
          ..add('nozzleTemp', nozzleTemp)
          ..add('nozzleTarget', nozzleTarget)
          ..add('bedTemp', bedTemp)
          ..add('bedTarget', bedTarget)
          ..add('currentFile', currentFile)
          ..add('cameraAvailable', cameraAvailable)
          ..add('cameras', cameras)
          ..add('loadedSpool', loadedSpool)
          ..add('currentOrder', currentOrder)
          ..add('lastSeen', lastSeen))
        .toString();
  }
}

class PrinterBuilder implements Builder<Printer, PrinterBuilder> {
  _$Printer? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  PrinterState? _state;
  PrinterState? get state => _$this._state;
  set state(PrinterState? state) => _$this._state = state;

  String? _model;
  String? get model => _$this._model;
  set model(String? model) => _$this._model = model;

  double? _progress;
  double? get progress => _$this._progress;
  set progress(double? progress) => _$this._progress = progress;

  int? _remainingSeconds;
  int? get remainingSeconds => _$this._remainingSeconds;
  set remainingSeconds(int? remainingSeconds) =>
      _$this._remainingSeconds = remainingSeconds;

  double? _nozzleTemp;
  double? get nozzleTemp => _$this._nozzleTemp;
  set nozzleTemp(double? nozzleTemp) => _$this._nozzleTemp = nozzleTemp;

  double? _nozzleTarget;
  double? get nozzleTarget => _$this._nozzleTarget;
  set nozzleTarget(double? nozzleTarget) => _$this._nozzleTarget = nozzleTarget;

  double? _bedTemp;
  double? get bedTemp => _$this._bedTemp;
  set bedTemp(double? bedTemp) => _$this._bedTemp = bedTemp;

  double? _bedTarget;
  double? get bedTarget => _$this._bedTarget;
  set bedTarget(double? bedTarget) => _$this._bedTarget = bedTarget;

  String? _currentFile;
  String? get currentFile => _$this._currentFile;
  set currentFile(String? currentFile) => _$this._currentFile = currentFile;

  bool? _cameraAvailable;
  bool? get cameraAvailable => _$this._cameraAvailable;
  set cameraAvailable(bool? cameraAvailable) =>
      _$this._cameraAvailable = cameraAvailable;

  ListBuilder<String>? _cameras;
  ListBuilder<String> get cameras => _$this._cameras ??= ListBuilder<String>();
  set cameras(ListBuilder<String>? cameras) => _$this._cameras = cameras;

  SpoolRefBuilder? _loadedSpool;
  SpoolRefBuilder get loadedSpool => _$this._loadedSpool ??= SpoolRefBuilder();
  set loadedSpool(SpoolRefBuilder? loadedSpool) =>
      _$this._loadedSpool = loadedSpool;

  OrderRefBuilder? _currentOrder;
  OrderRefBuilder get currentOrder =>
      _$this._currentOrder ??= OrderRefBuilder();
  set currentOrder(OrderRefBuilder? currentOrder) =>
      _$this._currentOrder = currentOrder;

  DateTime? _lastSeen;
  DateTime? get lastSeen => _$this._lastSeen;
  set lastSeen(DateTime? lastSeen) => _$this._lastSeen = lastSeen;

  PrinterBuilder() {
    Printer._defaults(this);
  }

  PrinterBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _state = $v.state;
      _model = $v.model;
      _progress = $v.progress;
      _remainingSeconds = $v.remainingSeconds;
      _nozzleTemp = $v.nozzleTemp;
      _nozzleTarget = $v.nozzleTarget;
      _bedTemp = $v.bedTemp;
      _bedTarget = $v.bedTarget;
      _currentFile = $v.currentFile;
      _cameraAvailable = $v.cameraAvailable;
      _cameras = $v.cameras?.toBuilder();
      _loadedSpool = $v.loadedSpool?.toBuilder();
      _currentOrder = $v.currentOrder?.toBuilder();
      _lastSeen = $v.lastSeen;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Printer other) {
    _$v = other as _$Printer;
  }

  @override
  void update(void Function(PrinterBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Printer build() => _build();

  _$Printer _build() {
    _$Printer _$result;
    try {
      _$result = _$v ??
          _$Printer._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'Printer', 'id'),
            name:
                BuiltValueNullFieldError.checkNotNull(name, r'Printer', 'name'),
            state: BuiltValueNullFieldError.checkNotNull(
                state, r'Printer', 'state'),
            model: model,
            progress: progress,
            remainingSeconds: remainingSeconds,
            nozzleTemp: nozzleTemp,
            nozzleTarget: nozzleTarget,
            bedTemp: bedTemp,
            bedTarget: bedTarget,
            currentFile: currentFile,
            cameraAvailable: cameraAvailable,
            cameras: _cameras?.build(),
            loadedSpool: _loadedSpool?.build(),
            currentOrder: _currentOrder?.build(),
            lastSeen: lastSeen,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'cameras';
        _cameras?.build();
        _$failedField = 'loadedSpool';
        _loadedSpool?.build();
        _$failedField = 'currentOrder';
        _currentOrder?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'Printer', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
