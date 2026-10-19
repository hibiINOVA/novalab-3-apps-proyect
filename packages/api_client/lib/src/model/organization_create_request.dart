//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'organization_create_request.g.dart';

/// OrganizationCreateRequest
///
/// Properties:
/// * [name]
/// * [description]
/// * [vision]
/// * [mission]
@BuiltValue()
abstract class OrganizationCreateRequest
    implements
        Built<OrganizationCreateRequest, OrganizationCreateRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'vision')
  String? get vision;

  @BuiltValueField(wireName: r'mission')
  String? get mission;

  OrganizationCreateRequest._();

  factory OrganizationCreateRequest(
          [void updates(OrganizationCreateRequestBuilder b)]) =
      _$OrganizationCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrganizationCreateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrganizationCreateRequest> get serializer =>
      _$OrganizationCreateRequestSerializer();
}

class _$OrganizationCreateRequestSerializer
    implements PrimitiveSerializer<OrganizationCreateRequest> {
  @override
  final Iterable<Type> types = const [
    OrganizationCreateRequest,
    _$OrganizationCreateRequest
  ];

  @override
  final String wireName = r'OrganizationCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrganizationCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    if (object.description != null) {
      yield r'description';
      yield serializers.serialize(
        object.description,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.vision != null) {
      yield r'vision';
      yield serializers.serialize(
        object.vision,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.mission != null) {
      yield r'mission';
      yield serializers.serialize(
        object.mission,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    OrganizationCreateRequest object, {
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
    required OrganizationCreateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'description':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.description = valueDes;
          break;
        case r'vision':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.vision = valueDes;
          break;
        case r'mission':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.mission = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OrganizationCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrganizationCreateRequestBuilder();
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
