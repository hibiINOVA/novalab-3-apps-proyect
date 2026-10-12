// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderDetail extends OrderDetail {
  @override
  final String trackingToken;
  @override
  final String? notes;
  @override
  final Shipment? shipment;
  @override
  final BuiltList<StatusHistoryEntry> history;
  @override
  final BuiltList<OrderItem> items;
  @override
  final Customer? customer;
  @override
  final int id;
  @override
  final String folio;
  @override
  final String customerName;
  @override
  final OrderStatus status;
  @override
  final DueState dueState;
  @override
  final double total;
  @override
  final int itemsCount;
  @override
  final int printedCount;
  @override
  final Date? promisedDate;
  @override
  final DateTime? createdAt;

  factory _$OrderDetail([void Function(OrderDetailBuilder)? updates]) =>
      (OrderDetailBuilder()..update(updates))._build();

  _$OrderDetail._(
      {required this.trackingToken,
      this.notes,
      this.shipment,
      required this.history,
      required this.items,
      this.customer,
      required this.id,
      required this.folio,
      required this.customerName,
      required this.status,
      required this.dueState,
      required this.total,
      required this.itemsCount,
      required this.printedCount,
      this.promisedDate,
      this.createdAt})
      : super._();
  @override
  OrderDetail rebuild(void Function(OrderDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderDetailBuilder toBuilder() => OrderDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderDetail &&
        trackingToken == other.trackingToken &&
        notes == other.notes &&
        shipment == other.shipment &&
        history == other.history &&
        items == other.items &&
        customer == other.customer &&
        id == other.id &&
        folio == other.folio &&
        customerName == other.customerName &&
        status == other.status &&
        dueState == other.dueState &&
        total == other.total &&
        itemsCount == other.itemsCount &&
        printedCount == other.printedCount &&
        promisedDate == other.promisedDate &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, trackingToken.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, shipment.hashCode);
    _$hash = $jc(_$hash, history.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, customer.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, folio.hashCode);
    _$hash = $jc(_$hash, customerName.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, dueState.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, itemsCount.hashCode);
    _$hash = $jc(_$hash, printedCount.hashCode);
    _$hash = $jc(_$hash, promisedDate.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderDetail')
          ..add('trackingToken', trackingToken)
          ..add('notes', notes)
          ..add('shipment', shipment)
          ..add('history', history)
          ..add('items', items)
          ..add('customer', customer)
          ..add('id', id)
          ..add('folio', folio)
          ..add('customerName', customerName)
          ..add('status', status)
          ..add('dueState', dueState)
          ..add('total', total)
          ..add('itemsCount', itemsCount)
          ..add('printedCount', printedCount)
          ..add('promisedDate', promisedDate)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class OrderDetailBuilder
    implements Builder<OrderDetail, OrderDetailBuilder>, OrderSummaryBuilder {
  _$OrderDetail? _$v;

  String? _trackingToken;
  String? get trackingToken => _$this._trackingToken;
  set trackingToken(covariant String? trackingToken) =>
      _$this._trackingToken = trackingToken;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(covariant String? notes) => _$this._notes = notes;

  ShipmentBuilder? _shipment;
  ShipmentBuilder get shipment => _$this._shipment ??= ShipmentBuilder();
  set shipment(covariant ShipmentBuilder? shipment) =>
      _$this._shipment = shipment;

  ListBuilder<StatusHistoryEntry>? _history;
  ListBuilder<StatusHistoryEntry> get history =>
      _$this._history ??= ListBuilder<StatusHistoryEntry>();
  set history(covariant ListBuilder<StatusHistoryEntry>? history) =>
      _$this._history = history;

  ListBuilder<OrderItem>? _items;
  ListBuilder<OrderItem> get items =>
      _$this._items ??= ListBuilder<OrderItem>();
  set items(covariant ListBuilder<OrderItem>? items) => _$this._items = items;

  CustomerBuilder? _customer;
  CustomerBuilder get customer => _$this._customer ??= CustomerBuilder();
  set customer(covariant CustomerBuilder? customer) =>
      _$this._customer = customer;

  int? _id;
  int? get id => _$this._id;
  set id(covariant int? id) => _$this._id = id;

  String? _folio;
  String? get folio => _$this._folio;
  set folio(covariant String? folio) => _$this._folio = folio;

  String? _customerName;
  String? get customerName => _$this._customerName;
  set customerName(covariant String? customerName) =>
      _$this._customerName = customerName;

  OrderStatus? _status;
  OrderStatus? get status => _$this._status;
  set status(covariant OrderStatus? status) => _$this._status = status;

  DueState? _dueState;
  DueState? get dueState => _$this._dueState;
  set dueState(covariant DueState? dueState) => _$this._dueState = dueState;

  double? _total;
  double? get total => _$this._total;
  set total(covariant double? total) => _$this._total = total;

  int? _itemsCount;
  int? get itemsCount => _$this._itemsCount;
  set itemsCount(covariant int? itemsCount) => _$this._itemsCount = itemsCount;

  int? _printedCount;
  int? get printedCount => _$this._printedCount;
  set printedCount(covariant int? printedCount) =>
      _$this._printedCount = printedCount;

  Date? _promisedDate;
  Date? get promisedDate => _$this._promisedDate;
  set promisedDate(covariant Date? promisedDate) =>
      _$this._promisedDate = promisedDate;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(covariant DateTime? createdAt) => _$this._createdAt = createdAt;

  OrderDetailBuilder() {
    OrderDetail._defaults(this);
  }

  OrderDetailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _trackingToken = $v.trackingToken;
      _notes = $v.notes;
      _shipment = $v.shipment?.toBuilder();
      _history = $v.history.toBuilder();
      _items = $v.items.toBuilder();
      _customer = $v.customer?.toBuilder();
      _id = $v.id;
      _folio = $v.folio;
      _customerName = $v.customerName;
      _status = $v.status;
      _dueState = $v.dueState;
      _total = $v.total;
      _itemsCount = $v.itemsCount;
      _printedCount = $v.printedCount;
      _promisedDate = $v.promisedDate;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant OrderDetail other) {
    _$v = other as _$OrderDetail;
  }

  @override
  void update(void Function(OrderDetailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderDetail build() => _build();

  _$OrderDetail _build() {
    _$OrderDetail _$result;
    try {
      _$result = _$v ??
          _$OrderDetail._(
            trackingToken: BuiltValueNullFieldError.checkNotNull(
                trackingToken, r'OrderDetail', 'trackingToken'),
            notes: notes,
            shipment: _shipment?.build(),
            history: history.build(),
            items: items.build(),
            customer: _customer?.build(),
            id: BuiltValueNullFieldError.checkNotNull(id, r'OrderDetail', 'id'),
            folio: BuiltValueNullFieldError.checkNotNull(
                folio, r'OrderDetail', 'folio'),
            customerName: BuiltValueNullFieldError.checkNotNull(
                customerName, r'OrderDetail', 'customerName'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'OrderDetail', 'status'),
            dueState: BuiltValueNullFieldError.checkNotNull(
                dueState, r'OrderDetail', 'dueState'),
            total: BuiltValueNullFieldError.checkNotNull(
                total, r'OrderDetail', 'total'),
            itemsCount: BuiltValueNullFieldError.checkNotNull(
                itemsCount, r'OrderDetail', 'itemsCount'),
            printedCount: BuiltValueNullFieldError.checkNotNull(
                printedCount, r'OrderDetail', 'printedCount'),
            promisedDate: promisedDate,
            createdAt: createdAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'shipment';
        _shipment?.build();
        _$failedField = 'history';
        history.build();
        _$failedField = 'items';
        items.build();
        _$failedField = 'customer';
        _customer?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'OrderDetail', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
