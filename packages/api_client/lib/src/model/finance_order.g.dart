// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_order.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FinanceOrder extends FinanceOrder {
  @override
  final int id;
  @override
  final String folio;
  @override
  final String customerName;
  @override
  final String status;
  @override
  final num total;
  @override
  final num income;
  @override
  final FinanceOrderCostBreakdown costs;
  @override
  final num profit;
  @override
  final num margin;
  @override
  final DateTime createdAt;
  @override
  final Date? promisedDate;

  factory _$FinanceOrder([void Function(FinanceOrderBuilder)? updates]) =>
      (FinanceOrderBuilder()..update(updates))._build();

  _$FinanceOrder._(
      {required this.id,
      required this.folio,
      required this.customerName,
      required this.status,
      required this.total,
      required this.income,
      required this.costs,
      required this.profit,
      required this.margin,
      required this.createdAt,
      this.promisedDate})
      : super._();
  @override
  FinanceOrder rebuild(void Function(FinanceOrderBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FinanceOrderBuilder toBuilder() => FinanceOrderBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceOrder &&
        id == other.id &&
        folio == other.folio &&
        customerName == other.customerName &&
        status == other.status &&
        total == other.total &&
        income == other.income &&
        costs == other.costs &&
        profit == other.profit &&
        margin == other.margin &&
        createdAt == other.createdAt &&
        promisedDate == other.promisedDate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, folio.hashCode);
    _$hash = $jc(_$hash, customerName.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, income.hashCode);
    _$hash = $jc(_$hash, costs.hashCode);
    _$hash = $jc(_$hash, profit.hashCode);
    _$hash = $jc(_$hash, margin.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, promisedDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinanceOrder')
          ..add('id', id)
          ..add('folio', folio)
          ..add('customerName', customerName)
          ..add('status', status)
          ..add('total', total)
          ..add('income', income)
          ..add('costs', costs)
          ..add('profit', profit)
          ..add('margin', margin)
          ..add('createdAt', createdAt)
          ..add('promisedDate', promisedDate))
        .toString();
  }
}

class FinanceOrderBuilder
    implements Builder<FinanceOrder, FinanceOrderBuilder> {
  _$FinanceOrder? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _folio;
  String? get folio => _$this._folio;
  set folio(String? folio) => _$this._folio = folio;

  String? _customerName;
  String? get customerName => _$this._customerName;
  set customerName(String? customerName) => _$this._customerName = customerName;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  num? _total;
  num? get total => _$this._total;
  set total(num? total) => _$this._total = total;

  num? _income;
  num? get income => _$this._income;
  set income(num? income) => _$this._income = income;

  FinanceOrderCostBreakdownBuilder? _costs;
  FinanceOrderCostBreakdownBuilder get costs =>
      _$this._costs ??= FinanceOrderCostBreakdownBuilder();
  set costs(FinanceOrderCostBreakdownBuilder? costs) => _$this._costs = costs;

  num? _profit;
  num? get profit => _$this._profit;
  set profit(num? profit) => _$this._profit = profit;

  num? _margin;
  num? get margin => _$this._margin;
  set margin(num? margin) => _$this._margin = margin;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  Date? _promisedDate;
  Date? get promisedDate => _$this._promisedDate;
  set promisedDate(Date? promisedDate) => _$this._promisedDate = promisedDate;

  FinanceOrderBuilder() {
    FinanceOrder._defaults(this);
  }

  FinanceOrderBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _folio = $v.folio;
      _customerName = $v.customerName;
      _status = $v.status;
      _total = $v.total;
      _income = $v.income;
      _costs = $v.costs.toBuilder();
      _profit = $v.profit;
      _margin = $v.margin;
      _createdAt = $v.createdAt;
      _promisedDate = $v.promisedDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinanceOrder other) {
    _$v = other as _$FinanceOrder;
  }

  @override
  void update(void Function(FinanceOrderBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceOrder build() => _build();

  _$FinanceOrder _build() {
    _$FinanceOrder _$result;
    try {
      _$result = _$v ??
          _$FinanceOrder._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'FinanceOrder', 'id'),
            folio: BuiltValueNullFieldError.checkNotNull(
                folio, r'FinanceOrder', 'folio'),
            customerName: BuiltValueNullFieldError.checkNotNull(
                customerName, r'FinanceOrder', 'customerName'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'FinanceOrder', 'status'),
            total: BuiltValueNullFieldError.checkNotNull(
                total, r'FinanceOrder', 'total'),
            income: BuiltValueNullFieldError.checkNotNull(
                income, r'FinanceOrder', 'income'),
            costs: costs.build(),
            profit: BuiltValueNullFieldError.checkNotNull(
                profit, r'FinanceOrder', 'profit'),
            margin: BuiltValueNullFieldError.checkNotNull(
                margin, r'FinanceOrder', 'margin'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'FinanceOrder', 'createdAt'),
            promisedDate: promisedDate,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'costs';
        costs.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FinanceOrder', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
