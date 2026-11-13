// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_goal.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MonthlyGoal extends MonthlyGoal {
  @override
  final String month;
  @override
  final num goalAmount;
  @override
  final num tariffKwh;

  factory _$MonthlyGoal([void Function(MonthlyGoalBuilder)? updates]) =>
      (MonthlyGoalBuilder()..update(updates))._build();

  _$MonthlyGoal._(
      {required this.month, required this.goalAmount, required this.tariffKwh})
      : super._();
  @override
  MonthlyGoal rebuild(void Function(MonthlyGoalBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MonthlyGoalBuilder toBuilder() => MonthlyGoalBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MonthlyGoal &&
        month == other.month &&
        goalAmount == other.goalAmount &&
        tariffKwh == other.tariffKwh;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, goalAmount.hashCode);
    _$hash = $jc(_$hash, tariffKwh.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MonthlyGoal')
          ..add('month', month)
          ..add('goalAmount', goalAmount)
          ..add('tariffKwh', tariffKwh))
        .toString();
  }
}

class MonthlyGoalBuilder implements Builder<MonthlyGoal, MonthlyGoalBuilder> {
  _$MonthlyGoal? _$v;

  String? _month;
  String? get month => _$this._month;
  set month(String? month) => _$this._month = month;

  num? _goalAmount;
  num? get goalAmount => _$this._goalAmount;
  set goalAmount(num? goalAmount) => _$this._goalAmount = goalAmount;

  num? _tariffKwh;
  num? get tariffKwh => _$this._tariffKwh;
  set tariffKwh(num? tariffKwh) => _$this._tariffKwh = tariffKwh;

  MonthlyGoalBuilder() {
    MonthlyGoal._defaults(this);
  }

  MonthlyGoalBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _month = $v.month;
      _goalAmount = $v.goalAmount;
      _tariffKwh = $v.tariffKwh;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MonthlyGoal other) {
    _$v = other as _$MonthlyGoal;
  }

  @override
  void update(void Function(MonthlyGoalBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MonthlyGoal build() => _build();

  _$MonthlyGoal _build() {
    final _$result = _$v ??
        _$MonthlyGoal._(
          month: BuiltValueNullFieldError.checkNotNull(
              month, r'MonthlyGoal', 'month'),
          goalAmount: BuiltValueNullFieldError.checkNotNull(
              goalAmount, r'MonthlyGoal', 'goalAmount'),
          tariffKwh: BuiltValueNullFieldError.checkNotNull(
              tariffKwh, r'MonthlyGoal', 'tariffKwh'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
