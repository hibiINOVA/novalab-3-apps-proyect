// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_goal_update.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MonthlyGoalUpdate extends MonthlyGoalUpdate {
  @override
  final num? goalAmount;
  @override
  final num? tariffKwh;

  factory _$MonthlyGoalUpdate(
          [void Function(MonthlyGoalUpdateBuilder)? updates]) =>
      (MonthlyGoalUpdateBuilder()..update(updates))._build();

  _$MonthlyGoalUpdate._({this.goalAmount, this.tariffKwh}) : super._();
  @override
  MonthlyGoalUpdate rebuild(void Function(MonthlyGoalUpdateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MonthlyGoalUpdateBuilder toBuilder() =>
      MonthlyGoalUpdateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MonthlyGoalUpdate &&
        goalAmount == other.goalAmount &&
        tariffKwh == other.tariffKwh;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, goalAmount.hashCode);
    _$hash = $jc(_$hash, tariffKwh.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MonthlyGoalUpdate')
          ..add('goalAmount', goalAmount)
          ..add('tariffKwh', tariffKwh))
        .toString();
  }
}

class MonthlyGoalUpdateBuilder
    implements Builder<MonthlyGoalUpdate, MonthlyGoalUpdateBuilder> {
  _$MonthlyGoalUpdate? _$v;

  num? _goalAmount;
  num? get goalAmount => _$this._goalAmount;
  set goalAmount(num? goalAmount) => _$this._goalAmount = goalAmount;

  num? _tariffKwh;
  num? get tariffKwh => _$this._tariffKwh;
  set tariffKwh(num? tariffKwh) => _$this._tariffKwh = tariffKwh;

  MonthlyGoalUpdateBuilder() {
    MonthlyGoalUpdate._defaults(this);
  }

  MonthlyGoalUpdateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _goalAmount = $v.goalAmount;
      _tariffKwh = $v.tariffKwh;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MonthlyGoalUpdate other) {
    _$v = other as _$MonthlyGoalUpdate;
  }

  @override
  void update(void Function(MonthlyGoalUpdateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MonthlyGoalUpdate build() => _build();

  _$MonthlyGoalUpdate _build() {
    final _$result = _$v ??
        _$MonthlyGoalUpdate._(
          goalAmount: goalAmount,
          tariffKwh: tariffKwh,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
