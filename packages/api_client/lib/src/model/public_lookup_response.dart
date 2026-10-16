//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'public_lookup_response.g.dart';

/// PublicLookupResponse
///
/// Properties:
/// * [trackingToken]
@BuiltValue()
abstract class PublicLookupResponse
    implements Built<PublicLookupResponse, PublicLookupResponseBuilder> {
  @BuiltValueField(wireName: r'tracking_token')
  String get trackingToken;

  PublicLookupResponse._();

  factory PublicLookupResponse([void updates(PublicLookupResponseBuilder b)]) =
      _$PublicLookupResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PublicLookupResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PublicLookupResponse> get serializer =>
      _$PublicLookupResponseSerializer();
}

class _$PublicLookupResponseSerializer
    implements PrimitiveSerializer<PublicLookupResponse> {
  @override
  final Iterable<Type> types = const [
    PublicLookupResponse,
    _$PublicLookupResponse
  ];

  @override
  final String wireName = r'PublicLookupResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PublicLookupResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'tracking_token';
    yield serializers.serialize(
      object.trackingToken,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PublicLookupResponse object, {
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
    required PublicLookupResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'tracking_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.trackingToken = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PublicLookupResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PublicLookupResponseBuilder();
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
