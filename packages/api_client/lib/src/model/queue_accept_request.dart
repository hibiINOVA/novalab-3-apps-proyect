//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:novalab_api/src/model/queue_accept_entry.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'queue_accept_request.g.dart';

/// QueueAcceptRequest
///
/// Properties:
/// * [version]
/// * [assignments]
@BuiltValue()
abstract class QueueAcceptRequest
    implements Built<QueueAcceptRequest, QueueAcceptRequestBuilder> {
  @BuiltValueField(wireName: r'version')
  int get version;

  @BuiltValueField(wireName: r'assignments')
  BuiltList<QueueAcceptEntry> get assignments;

  QueueAcceptRequest._();

  factory QueueAcceptRequest([void updates(QueueAcceptRequestBuilder b)]) =
      _$QueueAcceptRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(QueueAcceptRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<QueueAcceptRequest> get serializer =>
      _$QueueAcceptRequestSerializer();
}

class _$QueueAcceptRequestSerializer
    implements PrimitiveSerializer<QueueAcceptRequest> {
  @override
  final Iterable<Type> types = const [QueueAcceptRequest, _$QueueAcceptRequest];

  @override
  final String wireName = r'QueueAcceptRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    QueueAcceptRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'version';
    yield serializers.serialize(
      object.version,
      specifiedType: const FullType(int),
    );
    yield r'assignments';
    yield serializers.serialize(
      object.assignments,
      specifiedType: const FullType(BuiltList, [FullType(QueueAcceptEntry)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    QueueAcceptRequest object, {
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
    required QueueAcceptRequestBuilder result,
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
        case r'assignments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(QueueAcceptEntry)]),
          ) as BuiltList<QueueAcceptEntry>;
          result.assignments.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  QueueAcceptRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = QueueAcceptRequestBuilder();
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
