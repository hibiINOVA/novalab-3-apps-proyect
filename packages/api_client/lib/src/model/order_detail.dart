//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:novalab_api/src/model/order_status.dart';
import 'package:novalab_api/src/model/date.dart';
import 'package:novalab_api/src/model/order_item.dart';
import 'package:novalab_api/src/model/order_summary.dart';
import 'package:built_collection/built_collection.dart';
import 'package:novalab_api/src/model/due_state.dart';
import 'package:novalab_api/src/model/customer.dart';
import 'package:novalab_api/src/model/status_history_entry.dart';
import 'package:novalab_api/src/model/shipment.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_detail.g.dart';

/// OrderDetail
///
/// Properties:
/// * [id]
/// * [folio]
/// * [customerName]
/// * [status]
/// * [dueState]
/// * [total]
/// * [itemsCount]
/// * [printedCount]
/// * [trackingToken]
/// * [items]
/// * [history]
/// * [promisedDate]
/// * [createdAt]
/// * [notes]
/// * [customer]
/// * [shipment]
@BuiltValue()
abstract class OrderDetail
    implements OrderSummary, Built<OrderDetail, OrderDetailBuilder> {
  @BuiltValueField(wireName: r'tracking_token')
  String get trackingToken;

  @BuiltValueField(wireName: r'notes')
  String? get notes;

  @BuiltValueField(wireName: r'shipment')
  Shipment? get shipment;

  @BuiltValueField(wireName: r'history')
  BuiltList<StatusHistoryEntry> get history;

  @BuiltValueField(wireName: r'items')
  BuiltList<OrderItem> get items;

  @BuiltValueField(wireName: r'customer')
  Customer? get customer;

  OrderDetail._();

  factory OrderDetail([void updates(OrderDetailBuilder b)]) = _$OrderDetail;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderDetailBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderDetail> get serializer => _$OrderDetailSerializer();
}

class _$OrderDetailSerializer implements PrimitiveSerializer<OrderDetail> {
  @override
  final Iterable<Type> types = const [OrderDetail, _$OrderDetail];

  @override
  final String wireName = r'OrderDetail';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'tracking_token';
    yield serializers.serialize(
      object.trackingToken,
      specifiedType: const FullType(String),
    );
    if (object.notes != null) {
      yield r'notes';
      yield serializers.serialize(
        object.notes,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.shipment != null) {
      yield r'shipment';
      yield serializers.serialize(
        object.shipment,
        specifiedType: const FullType.nullable(Shipment),
      );
    }
    yield r'history';
    yield serializers.serialize(
      object.history,
      specifiedType: const FullType(BuiltList, [FullType(StatusHistoryEntry)]),
    );
    yield r'customer_name';
    yield serializers.serialize(
      object.customerName,
      specifiedType: const FullType(String),
    );
    yield r'items_count';
    yield serializers.serialize(
      object.itemsCount,
      specifiedType: const FullType(int),
    );
    if (object.createdAt != null) {
      yield r'created_at';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    yield r'due_state';
    yield serializers.serialize(
      object.dueState,
      specifiedType: const FullType(DueState),
    );
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(double),
    );
    yield r'folio';
    yield serializers.serialize(
      object.folio,
      specifiedType: const FullType(String),
    );
    if (object.promisedDate != null) {
      yield r'promised_date';
      yield serializers.serialize(
        object.promisedDate,
        specifiedType: const FullType.nullable(Date),
      );
    }
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(OrderItem)]),
    );
    yield r'printed_count';
    yield serializers.serialize(
      object.printedCount,
      specifiedType: const FullType(int),
    );
    if (object.customer != null) {
      yield r'customer';
      yield serializers.serialize(
        object.customer,
        specifiedType: const FullType.nullable(Customer),
      );
    }
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(OrderStatus),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderDetail object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderDetailBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'tracking_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.trackingToken = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.notes = valueDes;
          break;
        case r'shipment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Shipment),
          ) as Shipment?;
          if (valueDes == null) continue;
          result.shipment.replace(valueDes);
          break;
        case r'history':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(StatusHistoryEntry)]),
          ) as BuiltList<StatusHistoryEntry>;
          result.history.replace(valueDes);
          break;
        case r'customer_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.customerName = valueDes;
          break;
        case r'items_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.itemsCount = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'due_state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DueState),
          ) as DueState;
          result.dueState = valueDes;
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.total = valueDes;
          break;
        case r'folio':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.folio = valueDes;
          break;
        case r'promised_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.promisedDate = valueDes;
          break;
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(OrderItem)]),
          ) as BuiltList<OrderItem>;
          result.items.replace(valueDes);
          break;
        case r'printed_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.printedCount = valueDes;
          break;
        case r'customer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Customer),
          ) as Customer?;
          if (valueDes == null) continue;
          result.customer.replace(valueDes);
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderStatus),
          ) as OrderStatus;
          result.status = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OrderDetail deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderDetailBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
