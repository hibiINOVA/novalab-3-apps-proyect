//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'status_history_entry.g.dart';

/// StatusHistoryEntry
///
/// Properties:
/// * [status]
/// * [occurredAt]
/// * [previousStatus]
/// * [userName]
@BuiltValue()
abstract class StatusHistoryEntry
    implements Built<StatusHistoryEntry, StatusHistoryEntryBuilder> {
  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'occurred_at')
  DateTime get occurredAt;

  @BuiltValueField(wireName: r'previous_status')
  String? get previousStatus;

  @BuiltValueField(wireName: r'user_name')
  String? get userName;

  StatusHistoryEntry._();

  factory StatusHistoryEntry([void updates(StatusHistoryEntryBuilder b)]) =
      _$StatusHistoryEntry;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StatusHistoryEntryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StatusHistoryEntry> get serializer =>
      _$StatusHistoryEntrySerializer();
}

class _$StatusHistoryEntrySerializer
    implements PrimitiveSerializer<StatusHistoryEntry> {
  @override
  final Iterable<Type> types = const [StatusHistoryEntry, _$StatusHistoryEntry];

  @override
  final String wireName = r'StatusHistoryEntry';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StatusHistoryEntry object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'occurred_at';
    yield serializers.serialize(
      object.occurredAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.previousStatus != null) {
      yield r'previous_status';
      yield serializers.serialize(
        object.previousStatus,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.userName != null) {
      yield r'user_name';
      yield serializers.serialize(
        object.userName,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    StatusHistoryEntry object, {
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
    required StatusHistoryEntryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'occurred_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.occurredAt = valueDes;
          break;
        case r'previous_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.previousStatus = valueDes;
          break;
        case r'user_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.userName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StatusHistoryEntry deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StatusHistoryEntryBuilder();
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
