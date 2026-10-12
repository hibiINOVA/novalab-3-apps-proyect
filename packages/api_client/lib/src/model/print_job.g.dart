// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print_job.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PrintJob extends PrintJob {
  @override
  final int id;
  @override
  final int itemId;
  @override
  final int printerId;
  @override
  final ItemState state;
  @override
  final String? printerName;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? finishedAt;
  @override
  final double? gramsReal;
  @override
  final int? minutesReal;
  @override
  final String? failureReason;

  factory _$PrintJob([void Function(PrintJobBuilder)? updates]) =>
      (PrintJobBuilder()..update(updates))._build();

  _$PrintJob._(
      {required this.id,
      required this.itemId,
      required this.printerId,
      required this.state,
      this.printerName,
      this.startedAt,
      this.finishedAt,
      this.gramsReal,
      this.minutesReal,
      this.failureReason})
      : super._();
  @override
  PrintJob rebuild(void Function(PrintJobBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrintJobBuilder toBuilder() => PrintJobBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrintJob &&
        id == other.id &&
        itemId == other.itemId &&
        printerId == other.printerId &&
        state == other.state &&
        printerName == other.printerName &&
        startedAt == other.startedAt &&
        finishedAt == other.finishedAt &&
        gramsReal == other.gramsReal &&
        minutesReal == other.minutesReal &&
        failureReason == other.failureReason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, itemId.hashCode);
    _$hash = $jc(_$hash, printerId.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, printerName.hashCode);
    _$hash = $jc(_$hash, startedAt.hashCode);
    _$hash = $jc(_$hash, finishedAt.hashCode);
    _$hash = $jc(_$hash, gramsReal.hashCode);
    _$hash = $jc(_$hash, minutesReal.hashCode);
    _$hash = $jc(_$hash, failureReason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrintJob')
          ..add('id', id)
          ..add('itemId', itemId)
          ..add('printerId', printerId)
          ..add('state', state)
          ..add('printerName', printerName)
          ..add('startedAt', startedAt)
          ..add('finishedAt', finishedAt)
          ..add('gramsReal', gramsReal)
          ..add('minutesReal', minutesReal)
          ..add('failureReason', failureReason))
        .toString();
  }
}

class PrintJobBuilder implements Builder<PrintJob, PrintJobBuilder> {
  _$PrintJob? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _itemId;
  int? get itemId => _$this._itemId;
  set itemId(int? itemId) => _$this._itemId = itemId;

  int? _printerId;
  int? get printerId => _$this._printerId;
  set printerId(int? printerId) => _$this._printerId = printerId;

  ItemState? _state;
  ItemState? get state => _$this._state;
  set state(ItemState? state) => _$this._state = state;

  String? _printerName;
  String? get printerName => _$this._printerName;
  set printerName(String? printerName) => _$this._printerName = printerName;

  DateTime? _startedAt;
  DateTime? get startedAt => _$this._startedAt;
  set startedAt(DateTime? startedAt) => _$this._startedAt = startedAt;

  DateTime? _finishedAt;
  DateTime? get finishedAt => _$this._finishedAt;
  set finishedAt(DateTime? finishedAt) => _$this._finishedAt = finishedAt;

  double? _gramsReal;
  double? get gramsReal => _$this._gramsReal;
  set gramsReal(double? gramsReal) => _$this._gramsReal = gramsReal;

  int? _minutesReal;
  int? get minutesReal => _$this._minutesReal;
  set minutesReal(int? minutesReal) => _$this._minutesReal = minutesReal;

  String? _failureReason;
  String? get failureReason => _$this._failureReason;
  set failureReason(String? failureReason) =>
      _$this._failureReason = failureReason;

  PrintJobBuilder() {
    PrintJob._defaults(this);
  }

  PrintJobBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _itemId = $v.itemId;
      _printerId = $v.printerId;
      _state = $v.state;
      _printerName = $v.printerName;
      _startedAt = $v.startedAt;
      _finishedAt = $v.finishedAt;
      _gramsReal = $v.gramsReal;
      _minutesReal = $v.minutesReal;
      _failureReason = $v.failureReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrintJob other) {
    _$v = other as _$PrintJob;
  }

  @override
  void update(void Function(PrintJobBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrintJob build() => _build();

  _$PrintJob _build() {
    final _$result = _$v ??
        _$PrintJob._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'PrintJob', 'id'),
          itemId: BuiltValueNullFieldError.checkNotNull(
              itemId, r'PrintJob', 'itemId'),
          printerId: BuiltValueNullFieldError.checkNotNull(
              printerId, r'PrintJob', 'printerId'),
          state: BuiltValueNullFieldError.checkNotNull(
              state, r'PrintJob', 'state'),
          printerName: printerName,
          startedAt: startedAt,
          finishedAt: finishedAt,
          gramsReal: gramsReal,
          minutesReal: minutesReal,
          failureReason: failureReason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
