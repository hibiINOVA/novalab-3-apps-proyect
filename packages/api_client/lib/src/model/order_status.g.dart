// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderStatus _$confirmed = const OrderStatus._('confirmed');
const OrderStatus _$queued = const OrderStatus._('queued');
const OrderStatus _$printing = const OrderStatus._('printing');
const OrderStatus _$printed = const OrderStatus._('printed');
const OrderStatus _$packed = const OrderStatus._('packed');
const OrderStatus _$shipped = const OrderStatus._('shipped');
const OrderStatus _$delivered = const OrderStatus._('delivered');
const OrderStatus _$cancelled = const OrderStatus._('cancelled');

OrderStatus _$valueOf(String name) {
  switch (name) {
    case 'confirmed':
      return _$confirmed;
    case 'queued':
      return _$queued;
    case 'printing':
      return _$printing;
    case 'printed':
      return _$printed;
    case 'packed':
      return _$packed;
    case 'shipped':
      return _$shipped;
    case 'delivered':
      return _$delivered;
    case 'cancelled':
      return _$cancelled;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OrderStatus> _$values =
    BuiltSet<OrderStatus>(const <OrderStatus>[
  _$confirmed,
  _$queued,
  _$printing,
  _$printed,
  _$packed,
  _$shipped,
  _$delivered,
  _$cancelled,
]);

class _$OrderStatusMeta {
  const _$OrderStatusMeta();
  OrderStatus get confirmed => _$confirmed;
  OrderStatus get queued => _$queued;
  OrderStatus get printing => _$printing;
  OrderStatus get printed => _$printed;
  OrderStatus get packed => _$packed;
  OrderStatus get shipped => _$shipped;
  OrderStatus get delivered => _$delivered;
  OrderStatus get cancelled => _$cancelled;
  OrderStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<OrderStatus> get values => _$values;
}

abstract class _$OrderStatusMixin {
  // ignore: non_constant_identifier_names
  _$OrderStatusMeta get OrderStatus => const _$OrderStatusMeta();
}

Serializer<OrderStatus> _$orderStatusSerializer = _$OrderStatusSerializer();

class _$OrderStatusSerializer implements PrimitiveSerializer<OrderStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'confirmed': 'confirmed',
    'queued': 'queued',
    'printing': 'printing',
    'printed': 'printed',
    'packed': 'packed',
    'shipped': 'shipped',
    'delivered': 'delivered',
    'cancelled': 'cancelled',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'confirmed': 'confirmed',
    'queued': 'queued',
    'printing': 'printing',
    'printed': 'printed',
    'packed': 'packed',
    'shipped': 'shipped',
    'delivered': 'delivered',
    'cancelled': 'cancelled',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderStatus];
  @override
  final String wireName = 'OrderStatus';

  @override
  Object serialize(Serializers serializers, OrderStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
