//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'public_lookup_request.g.dart';

/// PublicLookupRequest
///
/// Properties:
/// * [folio]
/// * [phoneLast4]
@BuiltValue()
abstract class PublicLookupRequest
    implements Built<PublicLookupRequest, PublicLookupRequestBuilder> {
  @BuiltValueField(wireName: r'folio')
  String get folio;

  @BuiltValueField(wireName: r'phone_last4')
  String get phoneLast4;

  PublicLookupRequest._();

  factory PublicLookupRequest([void updates(PublicLookupRequestBuilder b)]) =
      _$PublicLookupRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PublicLookupRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PublicLookupRequest> get serializer =>
      _$PublicLookupRequestSerializer();
}

class _$PublicLookupRequestSerializer
    implements PrimitiveSerializer<PublicLookupRequest> {
  @override
  final Iterable<Type> types = const [
    PublicLookupRequest,
    _$PublicLookupRequest
  ];

  @override
  final String wireName = r'PublicLookupRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PublicLookupRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'folio';
    yield serializers.serialize(
      object.folio,
      specifiedType: const FullType(String),
    );
    yield r'phone_last4';
    yield serializers.serialize(
      object.phoneLast4,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PublicLookupRequest object, {
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
    required PublicLookupRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'folio':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.folio = valueDes;
          break;
        case r'phone_last4':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.phoneLast4 = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PublicLookupRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PublicLookupRequestBuilder();
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
