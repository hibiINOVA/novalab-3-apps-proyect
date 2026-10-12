// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print_job_start_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PrintJobStartRequest extends PrintJobStartRequest {
  @override
  final int itemId;
  @override
  final int printerId;

  factory _$PrintJobStartRequest(
          [void Function(PrintJobStartRequestBuilder)? updates]) =>
      (PrintJobStartRequestBuilder()..update(updates))._build();

  _$PrintJobStartRequest._({required this.itemId, required this.printerId})
      : super._();
  @override
  PrintJobStartRequest rebuild(
          void Function(PrintJobStartRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrintJobStartRequestBuilder toBuilder() =>
      PrintJobStartRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrintJobStartRequest &&
        itemId == other.itemId &&
        printerId == other.printerId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, itemId.hashCode);
    _$hash = $jc(_$hash, printerId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrintJobStartRequest')
          ..add('itemId', itemId)
          ..add('printerId', printerId))
        .toString();
  }
}

class PrintJobStartRequestBuilder
    implements Builder<PrintJobStartRequest, PrintJobStartRequestBuilder> {
  _$PrintJobStartRequest? _$v;

  int? _itemId;
  int? get itemId => _$this._itemId;
  set itemId(int? itemId) => _$this._itemId = itemId;

  int? _printerId;
  int? get printerId => _$this._printerId;
  set printerId(int? printerId) => _$this._printerId = printerId;

  PrintJobStartRequestBuilder() {
    PrintJobStartRequest._defaults(this);
  }

  PrintJobStartRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _itemId = $v.itemId;
      _printerId = $v.printerId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrintJobStartRequest other) {
    _$v = other as _$PrintJobStartRequest;
  }

  @override
  void update(void Function(PrintJobStartRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrintJobStartRequest build() => _build();

  _$PrintJobStartRequest _build() {
    final _$result = _$v ??
        _$PrintJobStartRequest._(
          itemId: BuiltValueNullFieldError.checkNotNull(
              itemId, r'PrintJobStartRequest', 'itemId'),
          printerId: BuiltValueNullFieldError.checkNotNull(
              printerId, r'PrintJobStartRequest', 'printerId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
