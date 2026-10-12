// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$QueueItem extends QueueItem {
  @override
  final int id;
  @override
  final int orderId;
  @override
  final String orderFolio;
  @override
  final String productName;
  @override
  final int quantity;
  @override
  final int printedQuantity;
  @override
  final QueueItemState state;
  @override
  final String? color;
  @override
  final int? missingQuantity;
  @override
  final int? printerId;
  @override
  final int? position;
  @override
  final int? estimatedMinutes;
  @override
  final Date? promisedDate;

  factory _$QueueItem([void Function(QueueItemBuilder)? updates]) =>
      (QueueItemBuilder()..update(updates))._build();

  _$QueueItem._(
      {required this.id,
      required this.orderId,
      required this.orderFolio,
      required this.productName,
      required this.quantity,
      required this.printedQuantity,
      required this.state,
      this.color,
      this.missingQuantity,
      this.printerId,
      this.position,
      this.estimatedMinutes,
      this.promisedDate})
      : super._();
  @override
  QueueItem rebuild(void Function(QueueItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  QueueItemBuilder toBuilder() => QueueItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QueueItem &&
        id == other.id &&
        orderId == other.orderId &&
        orderFolio == other.orderFolio &&
        productName == other.productName &&
        quantity == other.quantity &&
        printedQuantity == other.printedQuantity &&
        state == other.state &&
        color == other.color &&
        missingQuantity == other.missingQuantity &&
        printerId == other.printerId &&
        position == other.position &&
        estimatedMinutes == other.estimatedMinutes &&
        promisedDate == other.promisedDate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, orderFolio.hashCode);
    _$hash = $jc(_$hash, productName.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, printedQuantity.hashCode);
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, color.hashCode);
    _$hash = $jc(_$hash, missingQuantity.hashCode);
    _$hash = $jc(_$hash, printerId.hashCode);
    _$hash = $jc(_$hash, position.hashCode);
    _$hash = $jc(_$hash, estimatedMinutes.hashCode);
    _$hash = $jc(_$hash, promisedDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'QueueItem')
          ..add('id', id)
          ..add('orderId', orderId)
          ..add('orderFolio', orderFolio)
          ..add('productName', productName)
          ..add('quantity', quantity)
          ..add('printedQuantity', printedQuantity)
          ..add('state', state)
          ..add('color', color)
          ..add('missingQuantity', missingQuantity)
          ..add('printerId', printerId)
          ..add('position', position)
          ..add('estimatedMinutes', estimatedMinutes)
          ..add('promisedDate', promisedDate))
        .toString();
  }
}

class QueueItemBuilder implements Builder<QueueItem, QueueItemBuilder> {
  _$QueueItem? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _orderId;
  int? get orderId => _$this._orderId;
  set orderId(int? orderId) => _$this._orderId = orderId;

  String? _orderFolio;
  String? get orderFolio => _$this._orderFolio;
  set orderFolio(String? orderFolio) => _$this._orderFolio = orderFolio;

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

  QueueItemState? _state;
  QueueItemState? get state => _$this._state;
  set state(QueueItemState? state) => _$this._state = state;

  String? _color;
  String? get color => _$this._color;
  set color(String? color) => _$this._color = color;

  int? _missingQuantity;
  int? get missingQuantity => _$this._missingQuantity;
  set missingQuantity(int? missingQuantity) =>
      _$this._missingQuantity = missingQuantity;

  int? _printerId;
  int? get printerId => _$this._printerId;
  set printerId(int? printerId) => _$this._printerId = printerId;

  int? _position;
  int? get position => _$this._position;
  set position(int? position) => _$this._position = position;

  int? _estimatedMinutes;
  int? get estimatedMinutes => _$this._estimatedMinutes;
  set estimatedMinutes(int? estimatedMinutes) =>
      _$this._estimatedMinutes = estimatedMinutes;

  Date? _promisedDate;
  Date? get promisedDate => _$this._promisedDate;
  set promisedDate(Date? promisedDate) => _$this._promisedDate = promisedDate;

  QueueItemBuilder() {
    QueueItem._defaults(this);
  }

  QueueItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _orderId = $v.orderId;
      _orderFolio = $v.orderFolio;
      _productName = $v.productName;
      _quantity = $v.quantity;
      _printedQuantity = $v.printedQuantity;
      _state = $v.state;
      _color = $v.color;
      _missingQuantity = $v.missingQuantity;
      _printerId = $v.printerId;
      _position = $v.position;
      _estimatedMinutes = $v.estimatedMinutes;
      _promisedDate = $v.promisedDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(QueueItem other) {
    _$v = other as _$QueueItem;
  }

  @override
  void update(void Function(QueueItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  QueueItem build() => _build();

  _$QueueItem _build() {
    final _$result = _$v ??
        _$QueueItem._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'QueueItem', 'id'),
          orderId: BuiltValueNullFieldError.checkNotNull(
              orderId, r'QueueItem', 'orderId'),
          orderFolio: BuiltValueNullFieldError.checkNotNull(
              orderFolio, r'QueueItem', 'orderFolio'),
          productName: BuiltValueNullFieldError.checkNotNull(
              productName, r'QueueItem', 'productName'),
          quantity: BuiltValueNullFieldError.checkNotNull(
              quantity, r'QueueItem', 'quantity'),
          printedQuantity: BuiltValueNullFieldError.checkNotNull(
              printedQuantity, r'QueueItem', 'printedQuantity'),
          state: BuiltValueNullFieldError.checkNotNull(
              state, r'QueueItem', 'state'),
          color: color,
          missingQuantity: missingQuantity,
          printerId: printerId,
          position: position,
          estimatedMinutes: estimatedMinutes,
          promisedDate: promisedDate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
