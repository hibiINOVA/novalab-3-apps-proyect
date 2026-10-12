//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'suggestion_assignment.g.dart';

/// SuggestionAssignment
///
/// Properties:
/// * [itemId]
/// * [printerId]
/// * [printerName]
/// * [explanation]
/// * [orderFolio]
/// * [productName]
/// * [estimatedMinutes]
@BuiltValue()
abstract class SuggestionAssignment
    implements Built<SuggestionAssignment, SuggestionAssignmentBuilder> {
  @BuiltValueField(wireName: r'item_id')
  int get itemId;

  @BuiltValueField(wireName: r'printer_id')
  int get printerId;

  @BuiltValueField(wireName: r'printer_name')
  String get printerName;

  @BuiltValueField(wireName: r'explanation')
  String get explanation;

  @BuiltValueField(wireName: r'order_folio')
  String? get orderFolio;

  @BuiltValueField(wireName: r'product_name')
  String? get productName;

  @BuiltValueField(wireName: r'estimated_minutes')
  int? get estimatedMinutes;

  SuggestionAssignment._();

  factory SuggestionAssignment([void updates(SuggestionAssignmentBuilder b)]) =
      _$SuggestionAssignment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SuggestionAssignmentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SuggestionAssignment> get serializer =>
      _$SuggestionAssignmentSerializer();
}

class _$SuggestionAssignmentSerializer
    implements PrimitiveSerializer<SuggestionAssignment> {
  @override
  final Iterable<Type> types = const [
    SuggestionAssignment,
    _$SuggestionAssignment
  ];

  @override
  final String wireName = r'SuggestionAssignment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SuggestionAssignment object, {
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
    yield r'printer_name';
    yield serializers.serialize(
      object.printerName,
      specifiedType: const FullType(String),
    );
    yield r'explanation';
    yield serializers.serialize(
      object.explanation,
      specifiedType: const FullType(String),
    );
    if (object.orderFolio != null) {
      yield r'order_folio';
      yield serializers.serialize(
        object.orderFolio,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.productName != null) {
      yield r'product_name';
      yield serializers.serialize(
        object.productName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.estimatedMinutes != null) {
      yield r'estimated_minutes';
      yield serializers.serialize(
        object.estimatedMinutes,
        specifiedType: const FullType.nullable(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SuggestionAssignment object, {
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
    required SuggestionAssignmentBuilder result,
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
        case r'printer_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.printerName = valueDes;
          break;
        case r'explanation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.explanation = valueDes;
          break;
        case r'order_folio':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.orderFolio = valueDes;
          break;
        case r'product_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.productName = valueDes;
          break;
        case r'estimated_minutes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.estimatedMinutes = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SuggestionAssignment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SuggestionAssignmentBuilder();
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
