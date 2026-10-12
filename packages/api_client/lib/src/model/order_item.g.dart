// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderItem extends OrderItem {
  @override
  final int id;
  @override
  final int productId;
  @override
  final String productName;
  @override
  final int quantity;
  @override
  final int printedQuantity;
  @override
  final int missingQuantity;
  @override
  final ItemState state;
  @override
  final String? color;
  @override
  final int? printerId;
  @override
  final String? printerName;

  factory _$OrderItem([void Function(OrderItemBuilder)? updates]) =>
      (OrderItemBuilder()..update(updates))._build();

  _$OrderItem._(
      {required this.id,
      required this.productId,
      required this.productName,
      required this.quantity,
      required this.printedQuantity,
      required this.missingQuantity,
      required this.state,
      this.color,
      this.printerId,
      this.printerName})
      : super._();
  @override
  OrderItem rebuild(void Function(OrderItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderItemBuilder toBuilder() => OrderItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderItem &&
        id == other.id &&
        productId == other.productId &&
        productName == other.productName &&
        quantity == other.quantity &&
        printedQuantity == other.printedQuantity &&
        missingQuantity == other.missingQuantity &&
        state == other.state &&
        color == other.color &&
        printerId == other.printerId &&
        printerName == other.printerName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, productName.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, printedQuantity.hashCode);
    _$hash = $jc(_$hash, missingQuantity.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, printerId.hashCode);
    _$hash = $jc(_$hash, printerName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderItem')
          ..add('id', id)
          ..add('productId', productId)
          ..add('productName', productName)
          ..add('quantity', quantity)
          ..add('printedQuantity', printedQuantity)
          ..add('missingQuantity', missingQuantity)
          ..add('state', state)
          ..add('color', color)
          ..add('printerId', printerId)
          ..add('printerName', printerName))
        .toString();
  }
}

class OrderItemBuilder implements Builder<OrderItem, OrderItemBuilder> {
  _$OrderItem? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _productId;
  int? get productId => _$this._productId;
  set productId(int? productId) => _$this._productId = productId;

  String? _productName;
  String? get productName => _$this._productName;
  set productName(String? productName) => _$this._productName = productName;

  int? _quantity;
  int? get quantity => _$this._quantity;
  set quantity(int? quantity) => _$this._quantity = quantity;

  int? _printedQuantity;
  int? get printedQuantity => _$this._printedQuantity;
  set printedQuantity(int? printedQuantity) =>
      _$this._printedQuantity = printedQuantity;

  int? _missingQuantity;
  int? get missingQuantity => _$this._missingQuantity;
  set missingQuantity(int? missingQuantity) =>
      _$this._missingQuantity = missingQuantity;

  ItemState? _state;
  ItemState? get state => _$this._state;
  set state(ItemState? state) => _$this._state = state;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  int? _printerId;
  int? get printerId => _$this._printerId;
  set printerId(int? printerId) => _$this._printerId = printerId;

  String? _printerName;
  String? get printerName => _$this._printerName;
  set printerName(String? printerName) => _$this._printerName = printerName;

  OrderItemBuilder() {
    OrderItem._defaults(this);
  }

  OrderItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _productId = $v.productId;
      _productName = $v.productName;
      _quantity = $v.quantity;
      _printedQuantity = $v.printedQuantity;
      _missingQuantity = $v.missingQuantity;
      _state = $v.state;
      _color = $v.color;
      _printerId = $v.printerId;
      _printerName = $v.printerName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderItem other) {
    _$v = other as _$OrderItem;
  }

  @override
  void update(void Function(OrderItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderItem build() => _build();

  _$OrderItem _build() {
    final _$result = _$v ??
        _$OrderItem._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'OrderItem', 'id'),
          productId: BuiltValueNullFieldError.checkNotNull(
              productId, r'OrderItem', 'productId'),
          productName: BuiltValueNullFieldError.checkNotNull(
              productName, r'OrderItem', 'productName'),
          quantity: BuiltValueNullFieldError.checkNotNull(
              quantity, r'OrderItem', 'quantity'),
          printedQuantity: BuiltValueNullFieldError.checkNotNull(
              printedQuantity, r'OrderItem', 'printedQuantity'),
          missingQuantity: BuiltValueNullFieldError.checkNotNull(
              missingQuantity, r'OrderItem', 'missingQuantity'),
          state: BuiltValueNullFieldError.checkNotNull(
              state, r'OrderItem', 'state'),
          color: color,
          printerId: printerId,
          printerName: printerName,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
