// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_input.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderItemInput extends OrderItemInput {
  @override
  final int productId;
  @override
  final int quantity;
  @override
  final String? color;

  factory _$OrderItemInput([void Function(OrderItemInputBuilder)? updates]) =>
      (OrderItemInputBuilder()..update(updates))._build();

  _$OrderItemInput._(
      {required this.productId, required this.quantity, this.color})
      : super._();
  @override
  OrderItemInput rebuild(void Function(OrderItemInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderItemInputBuilder toBuilder() => OrderItemInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderItemInput &&
        productId == other.productId &&
        quantity == other.quantity &&
        color == other.color;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, productId.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderItemInput')
          ..add('productId', productId)
          ..add('quantity', quantity)
          ..add('color', color))
        .toString();
  }
}

class OrderItemInputBuilder
    implements Builder<OrderItemInput, OrderItemInputBuilder> {
  _$OrderItemInput? _$v;

  int? _productId;
  int? get productId => _$this._productId;
  set productId(int? productId) => _$this._productId = productId;

  int? _quantity;
  int? get quantity => _$this._quantity;
  set quantity(int? quantity) => _$this._quantity = quantity;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  OrderItemInputBuilder() {
    OrderItemInput._defaults(this);
  }

  OrderItemInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _productId = $v.productId;
      _quantity = $v.quantity;
      _color = $v.color;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderItemInput other) {
    _$v = other as _$OrderItemInput;
  }

  @override
  void update(void Function(OrderItemInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderItemInput build() => _build();

  _$OrderItemInput _build() {
    final _$result = _$v ??
        _$OrderItemInput._(
          productId: BuiltValueNullFieldError.checkNotNull(
              productId, r'OrderItemInput', 'productId'),
          quantity: BuiltValueNullFieldError.checkNotNull(
              quantity, r'OrderItemInput', 'quantity'),
          color: color,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
