// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_create_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderCreateRequest extends OrderCreateRequest {
  @override
  final BuiltList<OrderItemInput> items;
  @override
  final int? customerId;
  @override
  final String? customerName;
  @override
  final String? customerPhone;
  @override
  final Date? promisedDate;
  @override
  final String? notes;
  @override
  final double? total;

  factory _$OrderCreateRequest(
          [void Function(OrderCreateRequestBuilder)? updates]) =>
      (OrderCreateRequestBuilder()..update(updates))._build();

  _$OrderCreateRequest._(
      {required this.items,
      this.customerId,
      this.customerName,
      this.customerPhone,
      this.promisedDate,
      this.notes,
      this.total})
      : super._();
  @override
  OrderCreateRequest rebuild(
          void Function(OrderCreateRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderCreateRequestBuilder toBuilder() =>
      OrderCreateRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderCreateRequest &&
        items == other.items &&
        customerId == other.customerId &&
        customerName == other.customerName &&
        customerPhone == other.customerPhone &&
        promisedDate == other.promisedDate &&
        notes == other.notes &&
        total == other.total;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, customerId.hashCode);
    _$hash = $jc(_$hash, customerName.hashCode);
    _$hash = $jc(_$hash, customerPhone.hashCode);
    _$hash = $jc(_$hash, promisedDate.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderCreateRequest')
          ..add('items', items)
          ..add('customerId', customerId)
          ..add('customerName', customerName)
          ..add('customerPhone', customerPhone)
          ..add('promisedDate', promisedDate)
          ..add('notes', notes)
          ..add('total', total))
        .toString();
  }
}

class OrderCreateRequestBuilder
    implements Builder<OrderCreateRequest, OrderCreateRequestBuilder> {
  _$OrderCreateRequest? _$v;

  ListBuilder<OrderItemInput>? _items;
  ListBuilder<OrderItemInput> get items =>
      _$this._items ??= ListBuilder<OrderItemInput>();
  set items(ListBuilder<OrderItemInput>? items) => _$this._items = items;

  int? _customerId;
  int? get customerId => _$this._customerId;
  set customerId(int? customerId) => _$this._customerId = customerId;

  String? _customerName;
  String? get customerName => _$this._customerName;
  set customerName(String? customerName) => _$this._customerName = customerName;

  String? _customerPhone;
  String? get customerPhone => _$this._customerPhone;
  set customerPhone(String? customerPhone) =>
      _$this._customerPhone = customerPhone;

  Date? _promisedDate;
  Date? get promisedDate => _$this._promisedDate;
  set promisedDate(Date? promisedDate) => _$this._promisedDate = promisedDate;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  double? _total;
  double? get total => _$this._total;
  set total(double? total) => _$this._total = total;

  OrderCreateRequestBuilder() {
    OrderCreateRequest._defaults(this);
  }

  OrderCreateRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items.toBuilder();
      _customerId = $v.customerId;
      _customerName = $v.customerName;
      _customerPhone = $v.customerPhone;
      _promisedDate = $v.promisedDate;
      _notes = $v.notes;
      _total = $v.total;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderCreateRequest other) {
    _$v = other as _$OrderCreateRequest;
  }

  @override
  void update(void Function(OrderCreateRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderCreateRequest build() => _build();

  _$OrderCreateRequest _build() {
    _$OrderCreateRequest _$result;
    try {
      _$result = _$v ??
          _$OrderCreateRequest._(
            items: items.build(),
            customerId: customerId,
            customerName: customerName,
            customerPhone: customerPhone,
            promisedDate: promisedDate,
            notes: notes,
            total: total,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'OrderCreateRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
