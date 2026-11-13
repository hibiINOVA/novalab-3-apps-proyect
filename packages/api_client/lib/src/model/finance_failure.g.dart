// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_failure.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FinanceFailure extends FinanceFailure {
  @override
  final String month;
  @override
  final int failedJobsCount;
  @override
  final num gramsLost;
  @override
  final num moneyLost;

  factory _$FinanceFailure([void Function(FinanceFailureBuilder)? updates]) =>
      (FinanceFailureBuilder()..update(updates))._build();

  _$FinanceFailure._(
      {required this.month,
      required this.failedJobsCount,
      required this.gramsLost,
      required this.moneyLost})
      : super._();
  @override
  FinanceFailure rebuild(void Function(FinanceFailureBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FinanceFailureBuilder toBuilder() => FinanceFailureBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceFailure &&
        month == other.month &&
        failedJobsCount == other.failedJobsCount &&
        gramsLost == other.gramsLost &&
        moneyLost == other.moneyLost;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, failedJobsCount.hashCode);
    _$hash = $jc(_$hash, gramsLost.hashCode);
    _$hash = $jc(_$hash, moneyLost.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinanceFailure')
          ..add('month', month)
          ..add('failedJobsCount', failedJobsCount)
          ..add('gramsLost', gramsLost)
          ..add('moneyLost', moneyLost))
        .toString();
  }
}

class FinanceFailureBuilder
    implements Builder<FinanceFailure, FinanceFailureBuilder> {
  _$FinanceFailure? _$v;

  String? _month;
  String? get month => _$this._month;
  set month(String? month) => _$this._month = month;

  int? _failedJobsCount;
  int? get failedJobsCount => _$this._failedJobsCount;
  set failedJobsCount(int? failedJobsCount) =>
      _$this._failedJobsCount = failedJobsCount;

  num? _gramsLost;
  num? get gramsLost => _$this._gramsLost;
  set gramsLost(num? gramsLost) => _$this._gramsLost = gramsLost;

  num? _moneyLost;
  num? get moneyLost => _$this._moneyLost;
  set moneyLost(num? moneyLost) => _$this._moneyLost = moneyLost;

  FinanceFailureBuilder() {
    FinanceFailure._defaults(this);
  }

  FinanceFailureBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _month = $v.month;
      _failedJobsCount = $v.failedJobsCount;
      _gramsLost = $v.gramsLost;
      _moneyLost = $v.moneyLost;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinanceFailure other) {
    _$v = other as _$FinanceFailure;
  }

  @override
  void update(void Function(FinanceFailureBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceFailure build() => _build();

  _$FinanceFailure _build() {
    final _$result = _$v ??
        _$FinanceFailure._(
          month: BuiltValueNullFieldError.checkNotNull(
              month, r'FinanceFailure', 'month'),
          failedJobsCount: BuiltValueNullFieldError.checkNotNull(
              failedJobsCount, r'FinanceFailure', 'failedJobsCount'),
          gramsLost: BuiltValueNullFieldError.checkNotNull(
              gramsLost, r'FinanceFailure', 'gramsLost'),
          moneyLost: BuiltValueNullFieldError.checkNotNull(
              moneyLost, r'FinanceFailure', 'moneyLost'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
