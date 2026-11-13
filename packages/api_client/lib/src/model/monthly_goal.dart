//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'monthly_goal.g.dart';

/// MonthlyGoal
///
/// Properties:
/// * [month]
/// * [goalAmount]
/// * [tariffKwh]
@BuiltValue()
abstract class MonthlyGoal implements Built<MonthlyGoal, MonthlyGoalBuilder> {
  @BuiltValueField(wireName: r'month')
  String get month;

  @BuiltValueField(wireName: r'goal_amount')
  num get goalAmount;

  @BuiltValueField(wireName: r'tariff_kwh')
  num get tariffKwh;

  MonthlyGoal._();

  factory MonthlyGoal([void updates(MonthlyGoalBuilder b)]) = _$MonthlyGoal;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MonthlyGoalBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MonthlyGoal> get serializer => _$MonthlyGoalSerializer();
}

class _$MonthlyGoalSerializer implements PrimitiveSerializer<MonthlyGoal> {
  @override
  final Iterable<Type> types = const [MonthlyGoal, _$MonthlyGoal];

  @override
  final String wireName = r'MonthlyGoal';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MonthlyGoal object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'month';
    yield serializers.serialize(
      object.month,
      specifiedType: const FullType(String),
    );
    yield r'goal_amount';
    yield serializers.serialize(
      object.goalAmount,
      specifiedType: const FullType(num),
    );
    yield r'tariff_kwh';
    yield serializers.serialize(
      object.tariffKwh,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MonthlyGoal object, {
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
    required MonthlyGoalBuilder result,
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
  MonthlyGoal deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MonthlyGoalBuilder();
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
