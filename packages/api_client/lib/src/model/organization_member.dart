//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:novalab_api/src/model/membership_status.dart';
import 'package:novalab_api/src/model/role.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'organization_member.g.dart';

/// OrganizationMember
///
/// Properties:
/// * [id]
/// * [userId]
/// * [userName]
/// * [userEmail]
/// * [role]
/// * [status]
/// * [organizationCode]
/// * [organizationName]
/// * [createdAt]
@BuiltValue()
abstract class OrganizationMember
    implements Built<OrganizationMember, OrganizationMemberBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'user_id')
  int get userId;

  @BuiltValueField(wireName: r'user_name')
  String get userName;

  @BuiltValueField(wireName: r'user_email')
  String get userEmail;

  @BuiltValueField(wireName: r'role')
  Role get role;
  // enum roleEnum {  owner,  operator,  };

  @BuiltValueField(wireName: r'status')
  MembershipStatus get status;
  // enum statusEnum {  none,  pending,  active,  rejected,  };

  @BuiltValueField(wireName: r'organization_code')
  String? get organizationCode;

  @BuiltValueField(wireName: r'organization_name')
  String? get organizationName;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  OrganizationMember._();

  factory OrganizationMember([void updates(OrganizationMemberBuilder b)]) =
      _$OrganizationMember;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrganizationMemberBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrganizationMember> get serializer =>
      _$OrganizationMemberSerializer();
}

class _$OrganizationMemberSerializer
    implements PrimitiveSerializer<OrganizationMember> {
  @override
  final Iterable<Type> types = const [OrganizationMember, _$OrganizationMember];

  @override
  final String wireName = r'OrganizationMember';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrganizationMember object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'user_id';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(int),
    );
    yield r'user_name';
    yield serializers.serialize(
      object.userName,
      specifiedType: const FullType(String),
    );
    yield r'user_email';
    yield serializers.serialize(
      object.userEmail,
      specifiedType: const FullType(String),
    );
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(Role),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(MembershipStatus),
    );
    if (object.organizationCode != null) {
      yield r'organization_code';
      yield serializers.serialize(
        object.organizationCode,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.organizationName != null) {
      yield r'organization_name';
      yield serializers.serialize(
        object.organizationName,
        specifiedType: const FullType.nullable(String),
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
    OrganizationMember object, {
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
    required OrganizationMemberBuilder result,
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
        case r'user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'user_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userName = valueDes;
          break;
        case r'user_email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userEmail = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Role),
          ) as Role;
          result.role = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MembershipStatus),
          ) as MembershipStatus;
          result.status = valueDes;
          break;
        case r'organization_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.organizationCode = valueDes;
          break;
        case r'organization_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.organizationName = valueDes;
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
  OrganizationMember deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrganizationMemberBuilder();
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
