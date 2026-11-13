// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Expense extends Expense {
  @override
  final int id;
  @override
  final Date date;
  @override
  final FinanceCategory category;
  @override
  final num amount;
  @override
  final DateTime createdAt;
  @override
  final int? orderId;
  @override
  final String? orderFolio;

  factory _$Expense([void Function(ExpenseBuilder)? updates]) =>
      (ExpenseBuilder()..update(updates))._build();

  _$Expense._(
      {required this.id,
      required this.date,
      required this.category,
      required this.amount,
      required this.createdAt,
      this.orderId,
      this.orderFolio})
      : super._();
  @override
  Expense rebuild(void Function(ExpenseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExpenseBuilder toBuilder() => ExpenseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Expense &&
        id == other.id &&
        date == other.date &&
        category == other.category &&
        amount == other.amount &&
        createdAt == other.createdAt &&
        orderId == other.orderId &&
        orderFolio == other.orderFolio;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, orderFolio.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Expense')
          ..add('id', id)
          ..add('date', date)
          ..add('category', category)
          ..add('amount', amount)
          ..add('createdAt', createdAt)
          ..add('orderId', orderId)
          ..add('orderFolio', orderFolio))
        .toString();
  }
}

class ExpenseBuilder implements Builder<Expense, ExpenseBuilder> {
  _$Expense? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  Date? _date;
  Date? get date => _$this._date;
  set date(Date? date) => _$this._date = date;

  FinanceCategory? _category;
  FinanceCategory? get category => _$this._category;
  set category(FinanceCategory? category) => _$this._category = category;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  int? _orderId;
  int? get orderId => _$this._orderId;
  set orderId(int? orderId) => _$this._orderId = orderId;

  String? _orderFolio;
  String? get orderFolio => _$this._orderFolio;
  set orderFolio(String? orderFolio) => _$this._orderFolio = orderFolio;

  ExpenseBuilder() {
    Expense._defaults(this);
  }

  ExpenseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _date = $v.date;
      _category = $v.category;
      _amount = $v.amount;
      _createdAt = $v.createdAt;
      _orderId = $v.orderId;
      _orderFolio = $v.orderFolio;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Expense other) {
    _$v = other as _$Expense;
  }

  @override
  void update(void Function(ExpenseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Expense build() => _build();

  _$Expense _build() {
    final _$result = _$v ??
        _$Expense._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Expense', 'id'),
          date: BuiltValueNullFieldError.checkNotNull(date, r'Expense', 'date'),
          category: BuiltValueNullFieldError.checkNotNull(
              category, r'Expense', 'category'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'Expense', 'amount'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'Expense', 'createdAt'),
          orderId: orderId,
          orderFolio: orderFolio,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
