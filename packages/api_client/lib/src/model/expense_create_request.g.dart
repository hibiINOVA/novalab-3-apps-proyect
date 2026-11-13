// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExpenseCreateRequest extends ExpenseCreateRequest {
  @override
  final Date date;
  @override
  final FinanceCategory category;
  @override
  final num amount;
  @override
  final int? orderId;

  factory _$ExpenseCreateRequest(
          [void Function(ExpenseCreateRequestBuilder)? updates]) =>
      (ExpenseCreateRequestBuilder()..update(updates))._build();

  _$ExpenseCreateRequest._(
      {required this.date,
      required this.category,
      required this.amount,
      this.orderId})
      : super._();
  @override
  ExpenseCreateRequest rebuild(
          void Function(ExpenseCreateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExpenseCreateRequestBuilder toBuilder() =>
      ExpenseCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExpenseCreateRequest &&
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
    return (newBuiltValueToStringHelper(r'ExpenseCreateRequest')
          ..add('date', date)
          ..add('category', category)
          ..add('amount', amount)
          ..add('orderId', orderId))
        .toString();
  }
}

class ExpenseCreateRequestBuilder
    implements Builder<ExpenseCreateRequest, ExpenseCreateRequestBuilder> {
  _$ExpenseCreateRequest? _$v;

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

  ExpenseCreateRequestBuilder() {
    ExpenseCreateRequest._defaults(this);
  }

  ExpenseCreateRequestBuilder get _$this {
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
  void replace(ExpenseCreateRequest other) {
    _$v = other as _$ExpenseCreateRequest;
  }

  @override
  void update(void Function(ExpenseCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExpenseCreateRequest build() => _build();

  _$ExpenseCreateRequest _build() {
    final _$result = _$v ??
        _$ExpenseCreateRequest._(
          date: BuiltValueNullFieldError.checkNotNull(
              date, r'ExpenseCreateRequest', 'date'),
          category: BuiltValueNullFieldError.checkNotNull(
              category, r'ExpenseCreateRequest', 'category'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'ExpenseCreateRequest', 'amount'),
          orderId: orderId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
