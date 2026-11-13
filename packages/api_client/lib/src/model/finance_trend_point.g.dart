// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_trend_point.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FinanceTrendPoint extends FinanceTrendPoint {
  @override
  final String month;
  @override
  final num income;
  @override
  final num costs;
  @override
  final num profit;

  factory _$FinanceTrendPoint(
          [void Function(FinanceTrendPointBuilder)? updates]) =>
      (FinanceTrendPointBuilder()..update(updates))._build();

  _$FinanceTrendPoint._(
      {required this.month,
      required this.income,
      required this.costs,
      required this.profit})
      : super._();
  @override
  FinanceTrendPoint rebuild(void Function(FinanceTrendPointBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FinanceTrendPointBuilder toBuilder() =>
      FinanceTrendPointBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceTrendPoint &&
        month == other.month &&
        income == other.income &&
        costs == other.costs &&
        profit == other.profit;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, income.hashCode);
    _$hash = $jc(_$hash, costs.hashCode);
    _$hash = $jc(_$hash, profit.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinanceTrendPoint')
          ..add('month', month)
          ..add('income', income)
          ..add('costs', costs)
          ..add('profit', profit))
        .toString();
  }
}

class FinanceTrendPointBuilder
    implements Builder<FinanceTrendPoint, FinanceTrendPointBuilder> {
  _$FinanceTrendPoint? _$v;

  String? _month;
  String? get month => _$this._month;
  set month(String? month) => _$this._month = month;

  num? _income;
  num? get income => _$this._income;
  set income(num? income) => _$this._income = income;

  num? _costs;
  num? get costs => _$this._costs;
  set costs(num? costs) => _$this._costs = costs;

  num? _profit;
  num? get profit => _$this._profit;
  set profit(num? profit) => _$this._profit = profit;

  FinanceTrendPointBuilder() {
    FinanceTrendPoint._defaults(this);
  }

  FinanceTrendPointBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _month = $v.month;
      _income = $v.income;
      _costs = $v.costs;
      _profit = $v.profit;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinanceTrendPoint other) {
    _$v = other as _$FinanceTrendPoint;
  }

  @override
  void update(void Function(FinanceTrendPointBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceTrendPoint build() => _build();

  _$FinanceTrendPoint _build() {
    final _$result = _$v ??
        _$FinanceTrendPoint._(
          month: BuiltValueNullFieldError.checkNotNull(
              month, r'FinanceTrendPoint', 'month'),
          income: BuiltValueNullFieldError.checkNotNull(
              income, r'FinanceTrendPoint', 'income'),
          costs: BuiltValueNullFieldError.checkNotNull(
              costs, r'FinanceTrendPoint', 'costs'),
          profit: BuiltValueNullFieldError.checkNotNull(
              profit, r'FinanceTrendPoint', 'profit'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
