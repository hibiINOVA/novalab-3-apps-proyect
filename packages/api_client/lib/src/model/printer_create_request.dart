//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'printer_create_request.g.dart';

/// PrinterCreateRequest
///
/// Properties:
/// * [name]
/// * [model] - Modelo comercial de la impresora (p. ej. Prusa MK4)
/// * [octoprintUrl]
/// * [apiKey]
/// * [bedWidth]
/// * [bedDepth]
/// * [cameraAvailable]
/// * [cameras] - URLs de snapshot por cámara (BE-07). La primera es la principal. El backend las consume; jamás se exponen al cliente público.
@BuiltValue()
abstract class PrinterCreateRequest
    implements Built<PrinterCreateRequest, PrinterCreateRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  /// Modelo comercial de la impresora (p. ej. Prusa MK4)
  @BuiltValueField(wireName: r'model')
  String? get model;

  @BuiltValueField(wireName: r'octoprint_url')
  String? get octoprintUrl;

  @BuiltValueField(wireName: r'api_key')
  String? get apiKey;

  @BuiltValueField(wireName: r'bed_width')
  double? get bedWidth;

  @BuiltValueField(wireName: r'bed_depth')
  double? get bedDepth;

  @BuiltValueField(wireName: r'camera_available')
  bool? get cameraAvailable;

  /// URLs de snapshot por cámara (BE-07). La primera es la principal. El backend las consume; jamás se exponen al cliente público.
  @BuiltValueField(wireName: r'cameras')
  BuiltList<String>? get cameras;

  PrinterCreateRequest._();

  factory PrinterCreateRequest([void updates(PrinterCreateRequestBuilder b)]) =
      _$PrinterCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrinterCreateRequestBuilder b) =>
      b..cameraAvailable = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrinterCreateRequest> get serializer =>
      _$PrinterCreateRequestSerializer();
}

class _$PrinterCreateRequestSerializer
    implements PrimitiveSerializer<PrinterCreateRequest> {
  @override
  final Iterable<Type> types = const [
    PrinterCreateRequest,
    _$PrinterCreateRequest
  ];

  @override
  final String wireName = r'PrinterCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrinterCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    if (object.model != null) {
      yield r'model';
      yield serializers.serialize(
        object.model,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.octoprintUrl != null) {
      yield r'octoprint_url';
      yield serializers.serialize(
        object.octoprintUrl,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.apiKey != null) {
      yield r'api_key';
      yield serializers.serialize(
        object.apiKey,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.bedWidth != null) {
      yield r'bed_width';
      yield serializers.serialize(
        object.bedWidth,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.bedDepth != null) {
      yield r'bed_depth';
      yield serializers.serialize(
        object.bedDepth,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.cameraAvailable != null) {
      yield r'camera_available';
      yield serializers.serialize(
        object.cameraAvailable,
        specifiedType: const FullType(bool),
      );
    }
    if (object.cameras != null) {
      yield r'cameras';
      yield serializers.serialize(
        object.cameras,
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PrinterCreateRequest object, {
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
    required PrinterCreateRequestBuilder result,
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
        case r'model':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.model = valueDes;
          break;
        case r'octoprint_url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
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
        case r'bed_width':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.bedWidth = valueDes;
          break;
        case r'bed_depth':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.bedDepth = valueDes;
          break;
        case r'camera_available':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.cameraAvailable = valueDes;
          break;
        case r'cameras':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.cameras.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PrinterCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrinterCreateRequestBuilder();
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
