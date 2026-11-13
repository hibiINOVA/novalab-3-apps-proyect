//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_trend_point.g.dart';

/// FinanceTrendPoint
///
/// Properties:
/// * [month]
/// * [income]
/// * [costs]
/// * [profit]
@BuiltValue()
abstract class FinanceTrendPoint
    implements Built<FinanceTrendPoint, FinanceTrendPointBuilder> {
  @BuiltValueField(wireName: r'month')
  String get month;

  @BuiltValueField(wireName: r'income')
  num get income;

  @BuiltValueField(wireName: r'costs')
  num get costs;

  @BuiltValueField(wireName: r'profit')
  num get profit;

  FinanceTrendPoint._();

  factory FinanceTrendPoint([void updates(FinanceTrendPointBuilder b)]) =
      _$FinanceTrendPoint;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceTrendPointBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceTrendPoint> get serializer =>
      _$FinanceTrendPointSerializer();
}

class _$FinanceTrendPointSerializer
    implements PrimitiveSerializer<FinanceTrendPoint> {
  @override
  final Iterable<Type> types = const [FinanceTrendPoint, _$FinanceTrendPoint];

  @override
  final String wireName = r'FinanceTrendPoint';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceTrendPoint object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'month';
    yield serializers.serialize(
      object.month,
      specifiedType: const FullType(String),
    );
    yield r'income';
    yield serializers.serialize(
      object.income,
      specifiedType: const FullType(num),
    );
    yield r'costs';
    yield serializers.serialize(
      object.costs,
      specifiedType: const FullType(num),
    );
    yield r'profit';
    yield serializers.serialize(
      object.profit,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FinanceTrendPoint object, {
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
    required FinanceTrendPointBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'month':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.month = valueDes;
          break;
        case r'income':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.income = valueDes;
          break;
        case r'costs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.costs = valueDes;
          break;
        case r'profit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.profit = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinanceTrendPoint deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceTrendPointBuilder();
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
