// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_ref.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderRef extends OrderRef {
  @override
  final int id;
  @override
  final String folio;
  @override
  final String customerName;
  @override
  final Date? promisedDate;

  factory _$OrderRef([void Function(OrderRefBuilder)? updates]) =>
      (OrderRefBuilder()..update(updates))._build();

  _$OrderRef._(
      {required this.id,
      required this.folio,
      required this.customerName,
      this.promisedDate})
      : super._();
  @override
  OrderRef rebuild(void Function(OrderRefBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderRefBuilder toBuilder() => OrderRefBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderRef &&
        id == other.id &&
        folio == other.folio &&
        customerName == other.customerName &&
        promisedDate == other.promisedDate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, folio.hashCode);
    _$hash = $jc(_$hash, customerName.hashCode);
    _$hash = $jc(_$hash, promisedDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderRef')
          ..add('id', id)
          ..add('folio', folio)
          ..add('customerName', customerName)
          ..add('promisedDate', promisedDate))
        .toString();
  }
}

class OrderRefBuilder implements Builder<OrderRef, OrderRefBuilder> {
  _$OrderRef? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _folio;
  String? get folio => _$this._folio;
  set folio(String? folio) => _$this._folio = folio;

  String? _customerName;
  String? get customerName => _$this._customerName;
  set customerName(String? customerName) => _$this._customerName = customerName;

  Date? _promisedDate;
  Date? get promisedDate => _$this._promisedDate;
  set promisedDate(Date? promisedDate) => _$this._promisedDate = promisedDate;

  OrderRefBuilder() {
    OrderRef._defaults(this);
  }

  OrderRefBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _folio = $v.folio;
      _customerName = $v.customerName;
      _promisedDate = $v.promisedDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderRef other) {
    _$v = other as _$OrderRef;
  }

  @override
  void update(void Function(OrderRefBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderRef build() => _build();

  _$OrderRef _build() {
    final _$result = _$v ??
        _$OrderRef._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'OrderRef', 'id'),
          folio: BuiltValueNullFieldError.checkNotNull(
              folio, r'OrderRef', 'folio'),
          customerName: BuiltValueNullFieldError.checkNotNull(
              customerName, r'OrderRef', 'customerName'),
          promisedDate: promisedDate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
