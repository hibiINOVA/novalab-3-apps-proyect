//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:novalab_api/src/model/date.dart';
import 'package:novalab_api/src/model/queue_item_state.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'queue_item.g.dart';

/// QueueItem
///
/// Properties:
/// * [id]
/// * [orderId]
/// * [orderFolio]
/// * [productName]
/// * [quantity]
/// * [printedQuantity]
/// * [state]
/// * [color]
/// * [missingQuantity]
/// * [printerId] - null = sin asignar
/// * [position] - Orden dentro de la columna
/// * [estimatedMinutes]
/// * [promisedDate]
@BuiltValue()
abstract class QueueItem implements Built<QueueItem, QueueItemBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'order_id')
  int get orderId;

  @BuiltValueField(wireName: r'order_folio')
  String get orderFolio;

  @BuiltValueField(wireName: r'product_name')
  String get productName;

  @BuiltValueField(wireName: r'quantity')
  int get quantity;

  @BuiltValueField(wireName: r'printed_quantity')
  int get printedQuantity;

  @BuiltValueField(wireName: r'state')
  QueueItemState get state;
  // enum stateEnum {  pending,  queued,  printing,  printed,  failed,  };

  @BuiltValueField(wireName: r'color')
  String? get color;

  @BuiltValueField(wireName: r'missing_quantity')
  int? get missingQuantity;

  /// null = sin asignar
  @BuiltValueField(wireName: r'printer_id')
  int? get printerId;

  /// Orden dentro de la columna
  @BuiltValueField(wireName: r'position')
  int? get position;

  @BuiltValueField(wireName: r'estimated_minutes')
  int? get estimatedMinutes;

  @BuiltValueField(wireName: r'promised_date')
  Date? get promisedDate;

  QueueItem._();

  factory QueueItem([void updates(QueueItemBuilder b)]) = _$QueueItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(QueueItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<QueueItem> get serializer => _$QueueItemSerializer();
}

class _$QueueItemSerializer implements PrimitiveSerializer<QueueItem> {
  @override
  final Iterable<Type> types = const [QueueItem, _$QueueItem];

  @override
  final String wireName = r'QueueItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    QueueItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'order_id';
    yield serializers.serialize(
      object.orderId,
      specifiedType: const FullType(int),
    );
    yield r'order_folio';
    yield serializers.serialize(
      object.orderFolio,
      specifiedType: const FullType(String),
    );
    yield r'product_name';
    yield serializers.serialize(
      object.productName,
      specifiedType: const FullType(String),
    );
    yield r'quantity';
    yield serializers.serialize(
      object.quantity,
      specifiedType: const FullType(int),
    );
    yield r'printed_quantity';
    yield serializers.serialize(
      object.printedQuantity,
      specifiedType: const FullType(int),
    );
    yield r'state';
    yield serializers.serialize(
      object.state,
      specifiedType: const FullType(QueueItemState),
    );
    if (object.color != null) {
      yield r'color';
      yield serializers.serialize(
        object.color,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.missingQuantity != null) {
      yield r'missing_quantity';
      yield serializers.serialize(
        object.missingQuantity,
        specifiedType: const FullType(int),
      );
    }
    if (object.printerId != null) {
      yield r'printer_id';
      yield serializers.serialize(
        object.printerId,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.position != null) {
      yield r'position';
      yield serializers.serialize(
        object.position,
        specifiedType: const FullType(int),
      );
    }
    if (object.estimatedMinutes != null) {
      yield r'estimated_minutes';
      yield serializers.serialize(
        object.estimatedMinutes,
        specifiedType: const FullType.nullable(int),
      );
    }
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
    QueueItem object, {
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
    required QueueItemBuilder result,
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
        case r'order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.orderId = valueDes;
          break;
        case r'order_folio':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderFolio = valueDes;
          break;
        case r'product_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productName = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.quantity = valueDes;
          break;
        case r'printed_quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.printedQuantity = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(QueueItemState),
          ) as QueueItemState;
          result.state = valueDes;
          break;
        case r'color':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.color = valueDes;
          break;
        case r'missing_quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.missingQuantity = valueDes;
          break;
        case r'printer_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.printerId = valueDes;
          break;
        case r'position':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.position = valueDes;
          break;
        case r'estimated_minutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.estimatedMinutes = valueDes;
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
  QueueItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = QueueItemBuilder();
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
