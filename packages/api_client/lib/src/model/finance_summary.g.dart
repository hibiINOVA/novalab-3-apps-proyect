// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FinanceSummary extends FinanceSummary {
  @override
  final String month;
  @override
  final int ordersCount;
  @override
  final num income;
  @override
  final num costs;
  @override
  final num profit;
  @override
  final num margin;
  @override
  final num previousMonthProfit;
  @override
  final num variationPct;
  @override
  final num goal;
  @override
  final num goalReached;
  @override
  final num goalMissing;

  factory _$FinanceSummary([void Function(FinanceSummaryBuilder)? updates]) =>
      (FinanceSummaryBuilder()..update(updates))._build();

  _$FinanceSummary._(
      {required this.month,
      required this.ordersCount,
      required this.income,
      required this.costs,
      required this.profit,
      required this.margin,
      required this.previousMonthProfit,
      required this.variationPct,
      required this.goal,
      required this.goalReached,
      required this.goalMissing})
      : super._();
  @override
  FinanceSummary rebuild(void Function(FinanceSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FinanceSummaryBuilder toBuilder() => FinanceSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceSummary &&
        month == other.month &&
        ordersCount == other.ordersCount &&
        income == other.income &&
        costs == other.costs &&
        profit == other.profit &&
        margin == other.margin &&
        previousMonthProfit == other.previousMonthProfit &&
        variationPct == other.variationPct &&
        goal == other.goal &&
        goalReached == other.goalReached &&
        goalMissing == other.goalMissing;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, ordersCount.hashCode);
    _$hash = $jc(_$hash, income.hashCode);
    _$hash = $jc(_$hash, costs.hashCode);
    _$hash = $jc(_$hash, profit.hashCode);
    _$hash = $jc(_$hash, margin.hashCode);
    _$hash = $jc(_$hash, previousMonthProfit.hashCode);
    _$hash = $jc(_$hash, variationPct.hashCode);
    _$hash = $jc(_$hash, goal.hashCode);
    _$hash = $jc(_$hash, goalReached.hashCode);
    _$hash = $jc(_$hash, goalMissing.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinanceSummary')
          ..add('month', month)
          ..add('ordersCount', ordersCount)
          ..add('income', income)
          ..add('costs', costs)
          ..add('profit', profit)
          ..add('margin', margin)
          ..add('previousMonthProfit', previousMonthProfit)
          ..add('variationPct', variationPct)
          ..add('goal', goal)
          ..add('goalReached', goalReached)
          ..add('goalMissing', goalMissing))
        .toString();
  }
}

class FinanceSummaryBuilder
    implements Builder<FinanceSummary, FinanceSummaryBuilder> {
  _$FinanceSummary? _$v;

  String? _month;
  String? get month => _$this._month;
  set month(String? month) => _$this._month = month;

  int? _ordersCount;
  int? get ordersCount => _$this._ordersCount;
  set ordersCount(int? ordersCount) => _$this._ordersCount = ordersCount;

  num? _income;
  num? get income => _$this._income;
  set income(num? income) => _$this._income = income;

  num? _costs;
  num? get costs => _$this._costs;
  set costs(num? costs) => _$this._costs = costs;

  num? _profit;
  num? get profit => _$this._profit;
  set profit(num? profit) => _$this._profit = profit;

  num? _margin;
  num? get margin => _$this._margin;
  set margin(num? margin) => _$this._margin = margin;

  num? _previousMonthProfit;
  num? get previousMonthProfit => _$this._previousMonthProfit;
  set previousMonthProfit(num? previousMonthProfit) =>
      _$this._previousMonthProfit = previousMonthProfit;

  num? _variationPct;
  num? get variationPct => _$this._variationPct;
  set variationPct(num? variationPct) => _$this._variationPct = variationPct;

  num? _goal;
  num? get goal => _$this._goal;
  set goal(num? goal) => _$this._goal = goal;

  num? _goalReached;
  num? get goalReached => _$this._goalReached;
  set goalReached(num? goalReached) => _$this._goalReached = goalReached;

  num? _goalMissing;
  num? get goalMissing => _$this._goalMissing;
  set goalMissing(num? goalMissing) => _$this._goalMissing = goalMissing;

  FinanceSummaryBuilder() {
    FinanceSummary._defaults(this);
  }

  FinanceSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _month = $v.month;
      _ordersCount = $v.ordersCount;
      _income = $v.income;
      _costs = $v.costs;
      _profit = $v.profit;
      _margin = $v.margin;
      _previousMonthProfit = $v.previousMonthProfit;
      _variationPct = $v.variationPct;
      _goal = $v.goal;
      _goalReached = $v.goalReached;
      _goalMissing = $v.goalMissing;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinanceSummary other) {
    _$v = other as _$FinanceSummary;
  }

  @override
  void update(void Function(FinanceSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceSummary build() => _build();

  _$FinanceSummary _build() {
    final _$result = _$v ??
        _$FinanceSummary._(
          month: BuiltValueNullFieldError.checkNotNull(
              month, r'FinanceSummary', 'month'),
          ordersCount: BuiltValueNullFieldError.checkNotNull(
              ordersCount, r'FinanceSummary', 'ordersCount'),
          income: BuiltValueNullFieldError.checkNotNull(
              income, r'FinanceSummary', 'income'),
          costs: BuiltValueNullFieldError.checkNotNull(
              costs, r'FinanceSummary', 'costs'),
          profit: BuiltValueNullFieldError.checkNotNull(
              profit, r'FinanceSummary', 'profit'),
          margin: BuiltValueNullFieldError.checkNotNull(
              margin, r'FinanceSummary', 'margin'),
          previousMonthProfit: BuiltValueNullFieldError.checkNotNull(
              previousMonthProfit, r'FinanceSummary', 'previousMonthProfit'),
          variationPct: BuiltValueNullFieldError.checkNotNull(
              variationPct, r'FinanceSummary', 'variationPct'),
          goal: BuiltValueNullFieldError.checkNotNull(
              goal, r'FinanceSummary', 'goal'),
          goalReached: BuiltValueNullFieldError.checkNotNull(
              goalReached, r'FinanceSummary', 'goalReached'),
          goalMissing: BuiltValueNullFieldError.checkNotNull(
              goalMissing, r'FinanceSummary', 'goalMissing'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
