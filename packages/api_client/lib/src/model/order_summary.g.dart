// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

abstract class OrderSummaryBuilder {
  void replace(OrderSummary other);
  void update(void Function(OrderSummaryBuilder) updates);
  int? get id;
  set id(int? id);

  String? get folio;
  set folio(String? folio);

  String? get customerName;
  set customerName(String? customerName);

  OrderStatus? get status;
  set status(OrderStatus? status);

  DueState? get dueState;
  set dueState(DueState? dueState);

  double? get total;
  set total(double? total);

  int? get itemsCount;
  set itemsCount(int? itemsCount);

  int? get printedCount;
  set printedCount(int? printedCount);

  Date? get promisedDate;
  set promisedDate(Date? promisedDate);

  DateTime? get createdAt;
  set createdAt(DateTime? createdAt);
}

class _$$OrderSummary extends $OrderSummary {
  @override
  final int id;
  @override
  final String folio;
  @override
  final String customerName;
  @override
  final OrderStatus status;
  @override
  final DueState dueState;
  @override
  final double total;
  @override
  final int itemsCount;
  @override
  final int printedCount;
  @override
  final Date? promisedDate;
  @override
  final DateTime? createdAt;

  factory _$$OrderSummary([void Function($OrderSummaryBuilder)? updates]) =>
      ($OrderSummaryBuilder()..update(updates))._build();

  _$$OrderSummary._(
      {required this.id,
      required this.folio,
      required this.customerName,
      required this.status,
      required this.dueState,
      required this.total,
      required this.itemsCount,
      required this.printedCount,
      this.promisedDate,
      this.createdAt})
      : super._();
  @override
  $OrderSummary rebuild(void Function($OrderSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  $OrderSummaryBuilder toBuilder() => $OrderSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is $OrderSummary &&
        id == other.id &&
        folio == other.folio &&
        customerName == other.customerName &&
        status == other.status &&
        dueState == other.dueState &&
        total == other.total &&
        itemsCount == other.itemsCount &&
        printedCount == other.printedCount &&
        promisedDate == other.promisedDate &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, folio.hashCode);
    _$hash = $jc(_$hash, customerName.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, dueState.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, itemsCount.hashCode);
    _$hash = $jc(_$hash, printedCount.hashCode);
    _$hash = $jc(_$hash, promisedDate.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'$OrderSummary')
          ..add('id', id)
          ..add('folio', folio)
          ..add('customerName', customerName)
          ..add('status', status)
          ..add('dueState', dueState)
          ..add('total', total)
          ..add('itemsCount', itemsCount)
          ..add('printedCount', printedCount)
          ..add('promisedDate', promisedDate)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class $OrderSummaryBuilder
    implements
        Builder<$OrderSummary, $OrderSummaryBuilder>,
        OrderSummaryBuilder {
  _$$OrderSummary? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(covariant int? id) => _$this._id = id;

  String? _folio;
  String? get folio => _$this._folio;
  set folio(covariant String? folio) => _$this._folio = folio;

  String? _customerName;
  String? get customerName => _$this._customerName;
  set customerName(covariant String? customerName) =>
      _$this._customerName = customerName;

  OrderStatus? _status;
  OrderStatus? get status => _$this._status;
  set status(covariant OrderStatus? status) => _$this._status = status;

  DueState? _dueState;
  DueState? get dueState => _$this._dueState;
  set dueState(covariant DueState? dueState) => _$this._dueState = dueState;

  double? _total;
  double? get total => _$this._total;
  set total(covariant double? total) => _$this._total = total;

  int? _itemsCount;
  int? get itemsCount => _$this._itemsCount;
  set itemsCount(covariant int? itemsCount) => _$this._itemsCount = itemsCount;

  int? _printedCount;
  int? get printedCount => _$this._printedCount;
  set printedCount(covariant int? printedCount) =>
      _$this._printedCount = printedCount;

  Date? _promisedDate;
  Date? get promisedDate => _$this._promisedDate;
  set promisedDate(covariant Date? promisedDate) =>
      _$this._promisedDate = promisedDate;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(covariant DateTime? createdAt) => _$this._createdAt = createdAt;

  $OrderSummaryBuilder() {
    $OrderSummary._defaults(this);
  }

  $OrderSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _folio = $v.folio;
      _customerName = $v.customerName;
      _status = $v.status;
      _dueState = $v.dueState;
      _total = $v.total;
      _itemsCount = $v.itemsCount;
      _printedCount = $v.printedCount;
      _promisedDate = $v.promisedDate;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant $OrderSummary other) {
    _$v = other as _$$OrderSummary;
  }

  @override
  void update(void Function($OrderSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  $OrderSummary build() => _build();

  _$$OrderSummary _build() {
    final _$result = _$v ??
        _$$OrderSummary._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'$OrderSummary', 'id'),
          folio: BuiltValueNullFieldError.checkNotNull(
              folio, r'$OrderSummary', 'folio'),
          customerName: BuiltValueNullFieldError.checkNotNull(
              customerName, r'$OrderSummary', 'customerName'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'$OrderSummary', 'status'),
          dueState: BuiltValueNullFieldError.checkNotNull(
              dueState, r'$OrderSummary', 'dueState'),
          total: BuiltValueNullFieldError.checkNotNull(
              total, r'$OrderSummary', 'total'),
          itemsCount: BuiltValueNullFieldError.checkNotNull(
              itemsCount, r'$OrderSummary', 'itemsCount'),
          printedCount: BuiltValueNullFieldError.checkNotNull(
              printedCount, r'$OrderSummary', 'printedCount'),
          promisedDate: promisedDate,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
