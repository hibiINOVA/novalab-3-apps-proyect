//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:novalab_api/src/model/date.dart';
import 'package:novalab_api/src/model/finance_order_cost_breakdown.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_order.g.dart';

/// FinanceOrder
///
/// Properties:
/// * [id]
/// * [folio]
/// * [customerName]
/// * [status]
/// * [total]
/// * [income] - Facturado (0 si el pedido está cancelado)
/// * [costs]
/// * [profit]
/// * [margin]
/// * [createdAt]
/// * [promisedDate]
@BuiltValue()
abstract class FinanceOrder
    implements Built<FinanceOrder, FinanceOrderBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'folio')
  String get folio;

  @BuiltValueField(wireName: r'customer_name')
  String get customerName;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'total')
  num get total;

  /// Facturado (0 si el pedido está cancelado)
  @BuiltValueField(wireName: r'income')
  num get income;

  @BuiltValueField(wireName: r'costs')
  FinanceOrderCostBreakdown get costs;

  @BuiltValueField(wireName: r'profit')
  num get profit;

  @BuiltValueField(wireName: r'margin')
  num get margin;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'promised_date')
  Date? get promisedDate;

  FinanceOrder._();

  factory FinanceOrder([void updates(FinanceOrderBuilder b)]) = _$FinanceOrder;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceOrderBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceOrder> get serializer => _$FinanceOrderSerializer();
}

class _$FinanceOrderSerializer implements PrimitiveSerializer<FinanceOrder> {
  @override
  final Iterable<Type> types = const [FinanceOrder, _$FinanceOrder];

  @override
  final String wireName = r'FinanceOrder';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceOrder object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'folio';
    yield serializers.serialize(
      object.folio,
      specifiedType: const FullType(String),
    );
    yield r'customer_name';
    yield serializers.serialize(
      object.customerName,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(num),
    );
    yield r'income';
    yield serializers.serialize(
      object.income,
      specifiedType: const FullType(num),
    );
    yield r'costs';
    yield serializers.serialize(
      object.costs,
      specifiedType: const FullType(FinanceOrderCostBreakdown),
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
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.promisedDate != null) {
      yield r'promised_date';
      yield serializers.serialize(
        object.promisedDate,
        specifiedType: const FullType.nullable(Date),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FinanceOrder object, {
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
    required FinanceOrderBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'folio':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.folio = valueDes;
          break;
        case r'customer_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.customerName = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.total = valueDes;
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
            specifiedType: const FullType(FinanceOrderCostBreakdown),
          ) as FinanceOrderCostBreakdown;
          result.costs.replace(valueDes);
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
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'promised_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.promisedDate = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinanceOrder deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceOrderBuilder();
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
