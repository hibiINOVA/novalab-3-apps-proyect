//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:novalab_api/src/model/queue_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'queue.g.dart';

/// Queue
///
/// Properties:
/// * [unassigned]
/// * [byPrinter] - Mapa printer_id (string) -> items asignados
/// * [version] - Versión para control de concurrencia optimista
@BuiltValue()
abstract class Queue implements Built<Queue, QueueBuilder> {
  @BuiltValueField(wireName: r'unassigned')
  BuiltList<QueueItem> get unassigned;

  /// Mapa printer_id (string) -> items asignados
  @BuiltValueField(wireName: r'by_printer')
  BuiltMap<String, BuiltList<QueueItem>> get byPrinter;

  /// Versión para control de concurrencia optimista
  @BuiltValueField(wireName: r'version')
  int get version;

  Queue._();

  factory Queue([void updates(QueueBuilder b)]) = _$Queue;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(QueueBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Queue> get serializer => _$QueueSerializer();
}

class _$QueueSerializer implements PrimitiveSerializer<Queue> {
  @override
  final Iterable<Type> types = const [Queue, _$Queue];

  @override
  final String wireName = r'Queue';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Queue object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'unassigned';
    yield serializers.serialize(
      object.unassigned,
      specifiedType: const FullType(BuiltList, [FullType(QueueItem)]),
    );
    yield r'by_printer';
    yield serializers.serialize(
      object.byPrinter,
      specifiedType: const FullType(BuiltMap, [
        FullType(String),
        FullType(BuiltList, [FullType(QueueItem)])
      ]),
    );
    yield r'version';
    yield serializers.serialize(
      object.version,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Queue object, {
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
    required QueueBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'unassigned':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(QueueItem)]),
          ) as BuiltList<QueueItem>;
          result.unassigned.replace(valueDes);
          break;
        case r'by_printer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap, [
              FullType(String),
              FullType(BuiltList, [FullType(QueueItem)])
            ]),
          ) as BuiltMap<String, BuiltList<QueueItem>>;
          result.byPrinter.replace(valueDes);
          break;
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.version = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Queue deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = QueueBuilder();
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
