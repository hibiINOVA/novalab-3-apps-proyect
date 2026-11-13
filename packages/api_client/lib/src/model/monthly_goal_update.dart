//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'monthly_goal_update.g.dart';

/// MonthlyGoalUpdate
///
/// Properties:
/// * [goalAmount]
/// * [tariffKwh]
@BuiltValue()
abstract class MonthlyGoalUpdate
    implements Built<MonthlyGoalUpdate, MonthlyGoalUpdateBuilder> {
  @BuiltValueField(wireName: r'goal_amount')
  num? get goalAmount;

  @BuiltValueField(wireName: r'tariff_kwh')
  num? get tariffKwh;

  MonthlyGoalUpdate._();

  factory MonthlyGoalUpdate([void updates(MonthlyGoalUpdateBuilder b)]) =
      _$MonthlyGoalUpdate;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MonthlyGoalUpdateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MonthlyGoalUpdate> get serializer =>
      _$MonthlyGoalUpdateSerializer();
}

class _$MonthlyGoalUpdateSerializer
    implements PrimitiveSerializer<MonthlyGoalUpdate> {
  @override
  final Iterable<Type> types = const [MonthlyGoalUpdate, _$MonthlyGoalUpdate];

  @override
  final String wireName = r'MonthlyGoalUpdate';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MonthlyGoalUpdate object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.goalAmount != null) {
      yield r'goal_amount';
      yield serializers.serialize(
        object.goalAmount,
        specifiedType: const FullType(num),
      );
    }
    if (object.tariffKwh != null) {
      yield r'tariff_kwh';
      yield serializers.serialize(
        object.tariffKwh,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MonthlyGoalUpdate object, {
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
    required MonthlyGoalUpdateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'goal_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.goalAmount = valueDes;
          break;
        case r'tariff_kwh':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.tariffKwh = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MonthlyGoalUpdate deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MonthlyGoalUpdateBuilder();
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
