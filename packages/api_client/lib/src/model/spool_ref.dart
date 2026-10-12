//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'spool_ref.g.dart';

/// SpoolRef
///
/// Properties:
/// * [id]
/// * [material]
/// * [color]
/// * [gramsRemaining]
@BuiltValue()
abstract class SpoolRef implements Built<SpoolRef, SpoolRefBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'material')
  String get material;

  @BuiltValueField(wireName: r'color')
  String get color;

  @BuiltValueField(wireName: r'grams_remaining')
  double? get gramsRemaining;

  SpoolRef._();

  factory SpoolRef([void updates(SpoolRefBuilder b)]) = _$SpoolRef;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SpoolRefBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SpoolRef> get serializer => _$SpoolRefSerializer();
}

class _$SpoolRefSerializer implements PrimitiveSerializer<SpoolRef> {
  @override
  final Iterable<Type> types = const [SpoolRef, _$SpoolRef];

  @override
  final String wireName = r'SpoolRef';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SpoolRef object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'material';
    yield serializers.serialize(
      object.material,
      specifiedType: const FullType(String),
    );
    yield r'color';
    yield serializers.serialize(
      object.color,
      specifiedType: const FullType(String),
    );
    if (object.gramsRemaining != null) {
      yield r'grams_remaining';
      yield serializers.serialize(
        object.gramsRemaining,
        specifiedType: const FullType.nullable(double),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SpoolRef object, {
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
    required SpoolRefBuilder result,
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
        case r'material':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.material = valueDes;
          break;
        case r'color':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.color = valueDes;
          break;
        case r'grams_remaining':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.gramsRemaining = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SpoolRef deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SpoolRefBuilder();
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
