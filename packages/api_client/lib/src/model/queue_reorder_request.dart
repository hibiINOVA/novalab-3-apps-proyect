//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:novalab_api/src/model/queue_reorder_entry.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'queue_reorder_request.g.dart';

/// QueueReorderRequest
///
/// Properties:
/// * [version]
/// * [items]
@BuiltValue()
abstract class QueueReorderRequest
    implements Built<QueueReorderRequest, QueueReorderRequestBuilder> {
  @BuiltValueField(wireName: r'version')
  int get version;

  @BuiltValueField(wireName: r'items')
  BuiltList<QueueReorderEntry> get items;

  QueueReorderRequest._();

  factory QueueReorderRequest([void updates(QueueReorderRequestBuilder b)]) =
      _$QueueReorderRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(QueueReorderRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<QueueReorderRequest> get serializer =>
      _$QueueReorderRequestSerializer();
}

class _$QueueReorderRequestSerializer
    implements PrimitiveSerializer<QueueReorderRequest> {
  @override
  final Iterable<Type> types = const [
    QueueReorderRequest,
    _$QueueReorderRequest
  ];

  @override
  final String wireName = r'QueueReorderRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    QueueReorderRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'version';
    yield serializers.serialize(
      object.version,
      specifiedType: const FullType(int),
    );
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(QueueReorderEntry)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    QueueReorderRequest object, {
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
    required QueueReorderRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.version = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(QueueReorderEntry)]),
          ) as BuiltList<QueueReorderEntry>;
          result.items.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  QueueReorderRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = QueueReorderRequestBuilder();
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
