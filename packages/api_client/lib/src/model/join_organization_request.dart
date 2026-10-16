//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'join_organization_request.g.dart';

/// JoinOrganizationRequest
///
/// Properties:
/// * [organizationCode]
@BuiltValue()
abstract class JoinOrganizationRequest
    implements Built<JoinOrganizationRequest, JoinOrganizationRequestBuilder> {
  @BuiltValueField(wireName: r'organization_code')
  String get organizationCode;

  JoinOrganizationRequest._();

  factory JoinOrganizationRequest(
          [void updates(JoinOrganizationRequestBuilder b)]) =
      _$JoinOrganizationRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(JoinOrganizationRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<JoinOrganizationRequest> get serializer =>
      _$JoinOrganizationRequestSerializer();
}

class _$JoinOrganizationRequestSerializer
    implements PrimitiveSerializer<JoinOrganizationRequest> {
  @override
  final Iterable<Type> types = const [
    JoinOrganizationRequest,
    _$JoinOrganizationRequest
  ];

  @override
  final String wireName = r'JoinOrganizationRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    JoinOrganizationRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'organization_code';
    yield serializers.serialize(
      object.organizationCode,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    JoinOrganizationRequest object, {
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
    required JoinOrganizationRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'organization_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.organizationCode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  JoinOrganizationRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = JoinOrganizationRequestBuilder();
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
