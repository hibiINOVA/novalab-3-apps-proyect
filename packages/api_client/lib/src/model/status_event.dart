//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'status_event.g.dart';

/// StatusEvent
///
/// Properties:
/// * [type] - Tipo de evento, p. ej. printer.state, queue.updated, order.updated
/// * [entity]
/// * [entityId]
/// * [occurredAt]
/// * [payload]
@BuiltValue()
abstract class StatusEvent implements Built<StatusEvent, StatusEventBuilder> {
  /// Tipo de evento, p. ej. printer.state, queue.updated, order.updated
  @BuiltValueField(wireName: r'type')
  String get type;

  @BuiltValueField(wireName: r'entity')
  String get entity;

  @BuiltValueField(wireName: r'entity_id')
  int? get entityId;

  @BuiltValueField(wireName: r'occurred_at')
  DateTime get occurredAt;

  @BuiltValueField(wireName: r'payload')
  BuiltMap<String, JsonObject?>? get payload;

  StatusEvent._();

  factory StatusEvent([void updates(StatusEventBuilder b)]) = _$StatusEvent;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StatusEventBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StatusEvent> get serializer => _$StatusEventSerializer();
}

class _$StatusEventSerializer implements PrimitiveSerializer<StatusEvent> {
  @override
  final Iterable<Type> types = const [StatusEvent, _$StatusEvent];

  @override
  final String wireName = r'StatusEvent';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StatusEvent object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(String),
    );
    yield r'entity';
    yield serializers.serialize(
      object.entity,
      specifiedType: const FullType(String),
    );
    yield r'entity_id';
    yield object.entityId == null
        ? null
        : serializers.serialize(
            object.entityId,
            specifiedType: const FullType.nullable(int),
          );
    yield r'occurred_at';
    yield serializers.serialize(
      object.occurredAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.payload != null) {
      yield r'payload';
      yield serializers.serialize(
        object.payload,
        specifiedType: const FullType(
            BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    StatusEvent object, {
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
    required StatusEventBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'entity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.entity = valueDes;
          break;
        case r'entity_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.entityId = valueDes;
          break;
        case r'occurred_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.occurredAt = valueDes;
          break;
        case r'payload':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(
                BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
          ) as BuiltMap<String, JsonObject?>;
          result.payload.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StatusEvent deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StatusEventBuilder();
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
