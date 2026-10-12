//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:novalab_api/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'shipment.g.dart';

/// Shipment
///
/// Properties:
/// * [carrier]
/// * [trackingNumber]
/// * [trackingUrl]
/// * [shippedAt]
/// * [deliveredAt]
@BuiltValue()
abstract class Shipment implements Built<Shipment, ShipmentBuilder> {
  @BuiltValueField(wireName: r'carrier')
  String get carrier;

  @BuiltValueField(wireName: r'tracking_number')
  String? get trackingNumber;

  @BuiltValueField(wireName: r'tracking_url')
  String? get trackingUrl;

  @BuiltValueField(wireName: r'shipped_at')
  Date? get shippedAt;

  @BuiltValueField(wireName: r'delivered_at')
  Date? get deliveredAt;

  Shipment._();

  factory Shipment([void updates(ShipmentBuilder b)]) = _$Shipment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ShipmentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Shipment> get serializer => _$ShipmentSerializer();
}

class _$ShipmentSerializer implements PrimitiveSerializer<Shipment> {
  @override
  final Iterable<Type> types = const [Shipment, _$Shipment];

  @override
  final String wireName = r'Shipment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Shipment object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'carrier';
    yield serializers.serialize(
      object.carrier,
      specifiedType: const FullType(String),
    );
    if (object.trackingNumber != null) {
      yield r'tracking_number';
      yield serializers.serialize(
        object.trackingNumber,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.trackingUrl != null) {
      yield r'tracking_url';
      yield serializers.serialize(
        object.trackingUrl,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.shippedAt != null) {
      yield r'shipped_at';
      yield serializers.serialize(
        object.shippedAt,
        specifiedType: const FullType.nullable(Date),
      );
    }
    if (object.deliveredAt != null) {
      yield r'delivered_at';
      yield serializers.serialize(
        object.deliveredAt,
        specifiedType: const FullType.nullable(Date),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Shipment object, {
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
    required ShipmentBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'carrier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.carrier = valueDes;
          break;
        case r'tracking_number':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.trackingNumber = valueDes;
          break;
        case r'tracking_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.trackingUrl = valueDes;
          break;
        case r'shipped_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.shippedAt = valueDes;
          break;
        case r'delivered_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.deliveredAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Shipment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ShipmentBuilder();
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
