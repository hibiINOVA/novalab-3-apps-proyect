//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'queue_accept_entry.g.dart';

/// QueueAcceptEntry
///
/// Properties:
/// * [itemId]
/// * [printerId]
@BuiltValue()
abstract class QueueAcceptEntry
    implements Built<QueueAcceptEntry, QueueAcceptEntryBuilder> {
  @BuiltValueField(wireName: r'item_id')
  int get itemId;

  @BuiltValueField(wireName: r'printer_id')
  int get printerId;

  QueueAcceptEntry._();

  factory QueueAcceptEntry([void updates(QueueAcceptEntryBuilder b)]) =
      _$QueueAcceptEntry;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(QueueAcceptEntryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<QueueAcceptEntry> get serializer =>
      _$QueueAcceptEntrySerializer();
}

class _$QueueAcceptEntrySerializer
    implements PrimitiveSerializer<QueueAcceptEntry> {
  @override
  final Iterable<Type> types = const [QueueAcceptEntry, _$QueueAcceptEntry];

  @override
  final String wireName = r'QueueAcceptEntry';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    QueueAcceptEntry object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'item_id';
    yield serializers.serialize(
      object.itemId,
      specifiedType: const FullType(int),
    );
    yield r'printer_id';
    yield serializers.serialize(
      object.printerId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    QueueAcceptEntry object, {
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
    required QueueAcceptEntryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'item_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.itemId = valueDes;
          break;
        case r'printer_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.printerId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  QueueAcceptEntry deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = QueueAcceptEntryBuilder();
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
