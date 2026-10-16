//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:novalab_api/src/model/membership_status.dart';
import 'package:novalab_api/src/model/organization.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user_organization_status.g.dart';

/// UserOrganizationStatus
///
/// Properties:
/// * [membershipStatus]
/// * [organization]
/// * [pendingRequestsCount]
@BuiltValue()
abstract class UserOrganizationStatus
    implements Built<UserOrganizationStatus, UserOrganizationStatusBuilder> {
  @BuiltValueField(wireName: r'membership_status')
  MembershipStatus get membershipStatus;
  // enum membershipStatusEnum {  none,  pending,  active,  rejected,  };

  @BuiltValueField(wireName: r'organization')
  Organization? get organization;

  @BuiltValueField(wireName: r'pending_requests_count')
  int? get pendingRequestsCount;

  UserOrganizationStatus._();

  factory UserOrganizationStatus(
          [void updates(UserOrganizationStatusBuilder b)]) =
      _$UserOrganizationStatus;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UserOrganizationStatusBuilder b) =>
      b..pendingRequestsCount = 0;

  @BuiltValueSerializer(custom: true)
  static Serializer<UserOrganizationStatus> get serializer =>
      _$UserOrganizationStatusSerializer();
}

class _$UserOrganizationStatusSerializer
    implements PrimitiveSerializer<UserOrganizationStatus> {
  @override
  final Iterable<Type> types = const [
    UserOrganizationStatus,
    _$UserOrganizationStatus
  ];

  @override
  final String wireName = r'UserOrganizationStatus';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UserOrganizationStatus object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'membership_status';
    yield serializers.serialize(
      object.membershipStatus,
      specifiedType: const FullType(MembershipStatus),
    );
    if (object.organization != null) {
      yield r'organization';
      yield serializers.serialize(
        object.organization,
        specifiedType: const FullType(Organization),
      );
    }
    if (object.pendingRequestsCount != null) {
      yield r'pending_requests_count';
      yield serializers.serialize(
        object.pendingRequestsCount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UserOrganizationStatus object, {
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
    required UserOrganizationStatusBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'membership_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MembershipStatus),
          ) as MembershipStatus;
          result.membershipStatus = valueDes;
          break;
        case r'organization':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Organization),
          ) as Organization;
          result.organization.replace(valueDes);
          break;
        case r'pending_requests_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pendingRequestsCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UserOrganizationStatus deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UserOrganizationStatusBuilder();
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
