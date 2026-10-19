//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'organization.g.dart';

/// Organization
///
/// Properties:
/// * [id]
/// * [code] - ID único de la organización para compartir con operadores (p. ej. ORG-NOVA-8492)
/// * [name]
/// * [ownerId]
/// * [description]
/// * [vision]
/// * [mission]
/// * [hasLogo]
/// * [createdAt]
@BuiltValue()
abstract class Organization
    implements Built<Organization, OrganizationBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  /// ID único de la organización para compartir con operadores (p. ej. ORG-NOVA-8492)
  @BuiltValueField(wireName: r'code')
  String get code;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'owner_id')
  int get ownerId;

  @BuiltValueField(wireName: r'description')
  String? get description;

  @BuiltValueField(wireName: r'vision')
  String? get vision;

  @BuiltValueField(wireName: r'mission')
  String? get mission;

  @BuiltValueField(wireName: r'has_logo')
  bool? get hasLogo;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  Organization._();

  factory Organization([void updates(OrganizationBuilder b)]) = _$Organization;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrganizationBuilder b) => b..hasLogo = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<Organization> get serializer => _$OrganizationSerializer();
}

class _$OrganizationSerializer implements PrimitiveSerializer<Organization> {
  @override
  final Iterable<Type> types = const [Organization, _$Organization];

  @override
  final String wireName = r'Organization';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Organization object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'code';
    yield serializers.serialize(
      object.code,
      specifiedType: const FullType(String),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'owner_id';
    yield serializers.serialize(
      object.ownerId,
      specifiedType: const FullType(int),
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
    if (object.hasLogo != null) {
      yield r'has_logo';
      yield serializers.serialize(
        object.hasLogo,
        specifiedType: const FullType(bool),
      );
    }
    if (object.createdAt != null) {
      yield r'created_at';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Organization object, {
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
    required OrganizationBuilder result,
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
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'owner_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.ownerId = valueDes;
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
        case r'has_logo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasLogo = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Organization deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrganizationBuilder();
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
