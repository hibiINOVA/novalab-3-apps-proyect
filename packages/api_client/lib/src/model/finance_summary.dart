//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_summary.g.dart';

/// FinanceSummary
///
/// Properties:
/// * [month] - YYYY-MM
/// * [ordersCount]
/// * [income]
/// * [costs] - Costos de pedidos del mes + gastos sin pedido + costo de fallas
/// * [profit]
/// * [margin]
/// * [previousMonthProfit]
/// * [variationPct]
/// * [goal]
/// * [goalReached] - Ganancia del mes alcanzada contra la meta
/// * [goalMissing]
@BuiltValue()
abstract class FinanceSummary
    implements Built<FinanceSummary, FinanceSummaryBuilder> {
  /// YYYY-MM
  @BuiltValueField(wireName: r'month')
  String get month;

  @BuiltValueField(wireName: r'orders_count')
  int get ordersCount;

  @BuiltValueField(wireName: r'income')
  num get income;

  /// Costos de pedidos del mes + gastos sin pedido + costo de fallas
  @BuiltValueField(wireName: r'costs')
  num get costs;

  @BuiltValueField(wireName: r'profit')
  num get profit;

  @BuiltValueField(wireName: r'margin')
  num get margin;

  @BuiltValueField(wireName: r'previous_month_profit')
  num get previousMonthProfit;

  @BuiltValueField(wireName: r'variation_pct')
  num get variationPct;

  @BuiltValueField(wireName: r'goal')
  num get goal;

  /// Ganancia del mes alcanzada contra la meta
  @BuiltValueField(wireName: r'goal_reached')
  num get goalReached;

  @BuiltValueField(wireName: r'goal_missing')
  num get goalMissing;

  FinanceSummary._();

  factory FinanceSummary([void updates(FinanceSummaryBuilder b)]) =
      _$FinanceSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceSummary> get serializer =>
      _$FinanceSummarySerializer();
}

class _$FinanceSummarySerializer
    implements PrimitiveSerializer<FinanceSummary> {
  @override
  final Iterable<Type> types = const [FinanceSummary, _$FinanceSummary];

  @override
  final String wireName = r'FinanceSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'month';
    yield serializers.serialize(
      object.month,
      specifiedType: const FullType(String),
    );
    yield r'orders_count';
    yield serializers.serialize(
      object.ordersCount,
      specifiedType: const FullType(int),
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
    yield r'margin';
    yield serializers.serialize(
      object.margin,
      specifiedType: const FullType(num),
    );
    yield r'previous_month_profit';
    yield serializers.serialize(
      object.previousMonthProfit,
      specifiedType: const FullType(num),
    );
    yield r'variation_pct';
    yield serializers.serialize(
      object.variationPct,
      specifiedType: const FullType(num),
    );
    yield r'goal';
    yield serializers.serialize(
      object.goal,
      specifiedType: const FullType(num),
    );
    yield r'goal_reached';
    yield serializers.serialize(
      object.goalReached,
      specifiedType: const FullType(num),
    );
    yield r'goal_missing';
    yield serializers.serialize(
      object.goalMissing,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FinanceSummary object, {
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
    required FinanceSummaryBuilder result,
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
        case r'orders_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.ordersCount = valueDes;
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
        case r'margin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.margin = valueDes;
          break;
        case r'previous_month_profit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.previousMonthProfit = valueDes;
          break;
        case r'variation_pct':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.variationPct = valueDes;
          break;
        case r'goal':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.goal = valueDes;
          break;
        case r'goal_reached':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.goalReached = valueDes;
          break;
        case r'goal_missing':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.goalMissing = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinanceSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceSummaryBuilder();
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
