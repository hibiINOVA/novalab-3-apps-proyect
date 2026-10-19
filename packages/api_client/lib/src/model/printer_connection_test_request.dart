//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'printer_connection_test_request.g.dart';

/// BE-01: prueba de conexión antes del alta de la impresora.
///
/// Properties:
/// * [octoprintUrl]
/// * [apiKey]
@BuiltValue()
abstract class PrinterConnectionTestRequest
    implements
        Built<PrinterConnectionTestRequest,
            PrinterConnectionTestRequestBuilder> {
  @BuiltValueField(wireName: r'octoprint_url')
  String get octoprintUrl;

  @BuiltValueField(wireName: r'api_key')
  String? get apiKey;

  PrinterConnectionTestRequest._();

  factory PrinterConnectionTestRequest(
          [void updates(PrinterConnectionTestRequestBuilder b)]) =
      _$PrinterConnectionTestRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrinterConnectionTestRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrinterConnectionTestRequest> get serializer =>
      _$PrinterConnectionTestRequestSerializer();
}

class _$PrinterConnectionTestRequestSerializer
    implements PrimitiveSerializer<PrinterConnectionTestRequest> {
  @override
  final Iterable<Type> types = const [
    PrinterConnectionTestRequest,
    _$PrinterConnectionTestRequest
  ];

  @override
  final String wireName = r'PrinterConnectionTestRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrinterConnectionTestRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'octoprint_url';
    yield serializers.serialize(
      object.octoprintUrl,
      specifiedType: const FullType(String),
    );
    if (object.apiKey != null) {
      yield r'api_key';
      yield serializers.serialize(
        object.apiKey,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PrinterConnectionTestRequest object, {
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
    required PrinterConnectionTestRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'octoprint_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.octoprintUrl = valueDes;
          break;
        case r'api_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.apiKey = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PrinterConnectionTestRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrinterConnectionTestRequestBuilder();
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
