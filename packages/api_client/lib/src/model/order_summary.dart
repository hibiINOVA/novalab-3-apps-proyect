//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:novalab_api/src/model/order_status.dart';
import 'package:novalab_api/src/model/date.dart';
import 'package:novalab_api/src/model/due_state.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_summary.g.dart';

/// OrderSummary
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
/// * [promisedDate]
/// * [createdAt]
@BuiltValue(instantiable: false)
abstract class OrderSummary {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'folio')
  String get folio;

  @BuiltValueField(wireName: r'customer_name')
  String get customerName;

  @BuiltValueField(wireName: r'status')
  OrderStatus get status;
  // enum statusEnum {  confirmed,  queued,  printing,  printed,  packed,  shipped,  delivered,  cancelled,  };

  @BuiltValueField(wireName: r'due_state')
  DueState get dueState;
  // enum dueStateEnum {  none,  ok,  due_soon,  overdue,  };

  @BuiltValueField(wireName: r'total')
  double get total;

  @BuiltValueField(wireName: r'items_count')
  int get itemsCount;

  @BuiltValueField(wireName: r'printed_count')
  int get printedCount;

  @BuiltValueField(wireName: r'promised_date')
  Date? get promisedDate;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderSummary> get serializer => _$OrderSummarySerializer();
}

class _$OrderSummarySerializer implements PrimitiveSerializer<OrderSummary> {
  @override
  final Iterable<Type> types = const [OrderSummary];

  @override
  final String wireName = r'OrderSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderSummary object, {
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
      specifiedType: const FullType(OrderStatus),
    );
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
    yield r'items_count';
    yield serializers.serialize(
      object.itemsCount,
      specifiedType: const FullType(int),
    );
    yield r'printed_count';
    yield serializers.serialize(
      object.printedCount,
      specifiedType: const FullType(int),
    );
    if (object.promisedDate != null) {
      yield r'promised_date';
      yield serializers.serialize(
        object.promisedDate,
        specifiedType: const FullType.nullable(Date),
      );
    }
    if (object.createdAt != null) {
      yield r'created_at';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  @override
  OrderSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized,
        specifiedType: FullType($OrderSummary)) as $OrderSummary;
  }
}

/// a concrete implementation of [OrderSummary], since [OrderSummary] is not instantiable
@BuiltValue(instantiable: true)
abstract class $OrderSummary
    implements OrderSummary, Built<$OrderSummary, $OrderSummaryBuilder> {
  $OrderSummary._();

  factory $OrderSummary([void Function($OrderSummaryBuilder)? updates]) =
      _$$OrderSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($OrderSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$OrderSummary> get serializer =>
      _$$OrderSummarySerializer();
}

class _$$OrderSummarySerializer implements PrimitiveSerializer<$OrderSummary> {
  @override
  final Iterable<Type> types = const [$OrderSummary, _$$OrderSummary];

  @override
  final String wireName = r'$OrderSummary';

  @override
  Object serialize(
    Serializers serializers,
    $OrderSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object,
        specifiedType: FullType(OrderSummary))!;
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderSummaryBuilder result,
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
            specifiedType: const FullType(OrderStatus),
          ) as OrderStatus;
          result.status = valueDes;
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
        case r'items_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.itemsCount = valueDes;
          break;
        case r'printed_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.printedCount = valueDes;
          break;
        case r'promised_date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.promisedDate = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  $OrderSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $OrderSummaryBuilder();
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
