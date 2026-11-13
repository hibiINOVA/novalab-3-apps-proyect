// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_update_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExpenseUpdateRequest extends ExpenseUpdateRequest {
  @override
  final Date? date;
  @override
  final FinanceCategory? category;
  @override
  final num? amount;
  @override
  final int? orderId;

  factory _$ExpenseUpdateRequest(
          [void Function(ExpenseUpdateRequestBuilder)? updates]) =>
      (ExpenseUpdateRequestBuilder()..update(updates))._build();

  _$ExpenseUpdateRequest._(
      {this.date, this.category, this.amount, this.orderId})
      : super._();
  @override
  ExpenseUpdateRequest rebuild(
          void Function(ExpenseUpdateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExpenseUpdateRequestBuilder toBuilder() =>
      ExpenseUpdateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExpenseUpdateRequest &&
        date == other.date &&
        category == other.category &&
        amount == other.amount &&
        orderId == other.orderId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExpenseUpdateRequest')
          ..add('date', date)
          ..add('category', category)
          ..add('amount', amount)
          ..add('orderId', orderId))
        .toString();
  }
}

class ExpenseUpdateRequestBuilder
    implements Builder<ExpenseUpdateRequest, ExpenseUpdateRequestBuilder> {
  _$ExpenseUpdateRequest? _$v;

  Date? _date;
  Date? get date => _$this._date;
  set date(Date? date) => _$this._date = date;

  FinanceCategory? _category;
  FinanceCategory? get category => _$this._category;
  set category(FinanceCategory? category) => _$this._category = category;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  int? _orderId;
  int? get orderId => _$this._orderId;
  set orderId(int? orderId) => _$this._orderId = orderId;

  ExpenseUpdateRequestBuilder() {
    ExpenseUpdateRequest._defaults(this);
  }

  ExpenseUpdateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _date = $v.date;
      _category = $v.category;
      _amount = $v.amount;
      _orderId = $v.orderId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExpenseUpdateRequest other) {
    _$v = other as _$ExpenseUpdateRequest;
  }

  @override
  void update(void Function(ExpenseUpdateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExpenseUpdateRequest build() => _build();

  _$ExpenseUpdateRequest _build() {
    final _$result = _$v ??
        _$ExpenseUpdateRequest._(
          date: date,
          category: category,
          amount: amount,
          orderId: orderId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
