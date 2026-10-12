//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:novalab_api/src/model/order_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_status_update_request.g.dart';

/// OrderStatusUpdateRequest
///
/// Properties:
/// * [status]
@BuiltValue()
abstract class OrderStatusUpdateRequest
    implements
        Built<OrderStatusUpdateRequest, OrderStatusUpdateRequestBuilder> {
  @BuiltValueField(wireName: r'status')
  OrderStatus get status;
  // enum statusEnum {  confirmed,  queued,  printing,  printed,  packed,  shipped,  delivered,  cancelled,  };

  OrderStatusUpdateRequest._();

  factory OrderStatusUpdateRequest(
          [void updates(OrderStatusUpdateRequestBuilder b)]) =
      _$OrderStatusUpdateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderStatusUpdateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderStatusUpdateRequest> get serializer =>
      _$OrderStatusUpdateRequestSerializer();
}

class _$OrderStatusUpdateRequestSerializer
    implements PrimitiveSerializer<OrderStatusUpdateRequest> {
  @override
  final Iterable<Type> types = const [
    OrderStatusUpdateRequest,
    _$OrderStatusUpdateRequest
  ];

  @override
  final String wireName = r'OrderStatusUpdateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderStatusUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(OrderStatus),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderStatusUpdateRequest object, {
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
    required OrderStatusUpdateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  OrderStatusUpdateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderStatusUpdateRequestBuilder();
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
