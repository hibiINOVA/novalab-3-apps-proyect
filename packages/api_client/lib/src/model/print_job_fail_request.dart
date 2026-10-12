//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'print_job_fail_request.g.dart';

/// PrintJobFailRequest
///
/// Properties:
/// * [reason]
@BuiltValue()
abstract class PrintJobFailRequest
    implements Built<PrintJobFailRequest, PrintJobFailRequestBuilder> {
  @BuiltValueField(wireName: r'reason')
  String get reason;

  PrintJobFailRequest._();

  factory PrintJobFailRequest([void updates(PrintJobFailRequestBuilder b)]) =
      _$PrintJobFailRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrintJobFailRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrintJobFailRequest> get serializer =>
      _$PrintJobFailRequestSerializer();
}

class _$PrintJobFailRequestSerializer
    implements PrimitiveSerializer<PrintJobFailRequest> {
  @override
  final Iterable<Type> types = const [
    PrintJobFailRequest,
    _$PrintJobFailRequest
  ];

  @override
  final String wireName = r'PrintJobFailRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrintJobFailRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PrintJobFailRequest object, {
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
    required PrintJobFailRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PrintJobFailRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrintJobFailRequestBuilder();
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
