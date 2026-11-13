//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_order_cost_breakdown.g.dart';

/// FinanceOrderCostBreakdown
///
/// Properties:
/// * [material]
/// * [light]
/// * [packaging]
/// * [shipping]
/// * [commissions]
/// * [other]
@BuiltValue()
abstract class FinanceOrderCostBreakdown
    implements
        Built<FinanceOrderCostBreakdown, FinanceOrderCostBreakdownBuilder> {
  @BuiltValueField(wireName: r'material')
  num get material;

  @BuiltValueField(wireName: r'light')
  num get light;

  @BuiltValueField(wireName: r'packaging')
  num get packaging;

  @BuiltValueField(wireName: r'shipping')
  num get shipping;

  @BuiltValueField(wireName: r'commissions')
  num get commissions;

  @BuiltValueField(wireName: r'other')
  num get other;

  FinanceOrderCostBreakdown._();

  factory FinanceOrderCostBreakdown(
          [void updates(FinanceOrderCostBreakdownBuilder b)]) =
      _$FinanceOrderCostBreakdown;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceOrderCostBreakdownBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceOrderCostBreakdown> get serializer =>
      _$FinanceOrderCostBreakdownSerializer();
}

class _$FinanceOrderCostBreakdownSerializer
    implements PrimitiveSerializer<FinanceOrderCostBreakdown> {
  @override
  final Iterable<Type> types = const [
    FinanceOrderCostBreakdown,
    _$FinanceOrderCostBreakdown
  ];

  @override
  final String wireName = r'FinanceOrderCostBreakdown';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceOrderCostBreakdown object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'material';
    yield serializers.serialize(
      object.material,
      specifiedType: const FullType(num),
    );
    yield r'light';
    yield serializers.serialize(
      object.light,
      specifiedType: const FullType(num),
    );
    yield r'packaging';
    yield serializers.serialize(
      object.packaging,
      specifiedType: const FullType(num),
    );
    yield r'shipping';
    yield serializers.serialize(
      object.shipping,
      specifiedType: const FullType(num),
    );
    yield r'commissions';
    yield serializers.serialize(
      object.commissions,
      specifiedType: const FullType(num),
    );
    yield r'other';
    yield serializers.serialize(
      object.other,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FinanceOrderCostBreakdown object, {
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
    required FinanceOrderCostBreakdownBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'material':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.material = valueDes;
          break;
        case r'light':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.light = valueDes;
          break;
        case r'packaging':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.packaging = valueDes;
          break;
        case r'shipping':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.shipping = valueDes;
          break;
        case r'commissions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.commissions = valueDes;
          break;
        case r'other':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.other = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinanceOrderCostBreakdown deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceOrderCostBreakdownBuilder();
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
