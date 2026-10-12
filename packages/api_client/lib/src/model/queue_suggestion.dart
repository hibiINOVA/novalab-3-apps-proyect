//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:novalab_api/src/model/suggestion_assignment.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'queue_suggestion.g.dart';

/// QueueSuggestion
///
/// Properties:
/// * [version]
/// * [assignments]
/// * [summary]
/// * [unassignedItemIds]
@BuiltValue()
abstract class QueueSuggestion
    implements Built<QueueSuggestion, QueueSuggestionBuilder> {
  @BuiltValueField(wireName: r'version')
  int get version;

  @BuiltValueField(wireName: r'assignments')
  BuiltList<SuggestionAssignment> get assignments;

  @BuiltValueField(wireName: r'summary')
  String? get summary;

  @BuiltValueField(wireName: r'unassigned_item_ids')
  BuiltList<int>? get unassignedItemIds;

  QueueSuggestion._();

  factory QueueSuggestion([void updates(QueueSuggestionBuilder b)]) =
      _$QueueSuggestion;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(QueueSuggestionBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<QueueSuggestion> get serializer =>
      _$QueueSuggestionSerializer();
}

class _$QueueSuggestionSerializer
    implements PrimitiveSerializer<QueueSuggestion> {
  @override
  final Iterable<Type> types = const [QueueSuggestion, _$QueueSuggestion];

  @override
  final String wireName = r'QueueSuggestion';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    QueueSuggestion object, {
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
      specifiedType:
          const FullType(BuiltList, [FullType(SuggestionAssignment)]),
    );
    if (object.summary != null) {
      yield r'summary';
      yield serializers.serialize(
        object.summary,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.unassignedItemIds != null) {
      yield r'unassigned_item_ids';
      yield serializers.serialize(
        object.unassignedItemIds,
        specifiedType: const FullType(BuiltList, [FullType(int)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    QueueSuggestion object, {
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
    required QueueSuggestionBuilder result,
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
                const FullType(BuiltList, [FullType(SuggestionAssignment)]),
          ) as BuiltList<SuggestionAssignment>;
          result.assignments.replace(valueDes);
          break;
        case r'summary':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.summary = valueDes;
          break;
        case r'unassigned_item_ids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(int)]),
          ) as BuiltList<int>;
          result.unassignedItemIds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  QueueSuggestion deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = QueueSuggestionBuilder();
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
