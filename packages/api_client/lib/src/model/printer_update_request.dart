//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:novalab_api/src/model/printer_state.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'printer_update_request.g.dart';

/// PrinterUpdateRequest
///
/// Properties:
/// * [name]
/// * [model]
/// * [octoprintUrl]
/// * [apiKey]
/// * [bedWidth]
/// * [bedDepth]
/// * [cameraAvailable]
/// * [cameras] - URLs de snapshot por cámara (BE-07); reemplaza la lista.
/// * [state]
@BuiltValue()
abstract class PrinterUpdateRequest
    implements Built<PrinterUpdateRequest, PrinterUpdateRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

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

  /// URLs de snapshot por cámara (BE-07); reemplaza la lista.
  @BuiltValueField(wireName: r'cameras')
  BuiltList<String>? get cameras;

  @BuiltValueField(wireName: r'state')
  PrinterState? get state;
  // enum stateEnum {  idle,  printing,  paused,  offline,  error,  };

  PrinterUpdateRequest._();

  factory PrinterUpdateRequest([void updates(PrinterUpdateRequestBuilder b)]) =
      _$PrinterUpdateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrinterUpdateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrinterUpdateRequest> get serializer =>
      _$PrinterUpdateRequestSerializer();
}

class _$PrinterUpdateRequestSerializer
    implements PrimitiveSerializer<PrinterUpdateRequest> {
  @override
  final Iterable<Type> types = const [
    PrinterUpdateRequest,
    _$PrinterUpdateRequest
  ];

  @override
  final String wireName = r'PrinterUpdateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrinterUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType.nullable(String),
      );
    }
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
        specifiedType: const FullType.nullable(bool),
      );
    }
    if (object.cameras != null) {
      yield r'cameras';
      yield serializers.serialize(
        object.cameras,
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
      );
    }
    if (object.state != null) {
      yield r'state';
      yield serializers.serialize(
        object.state,
        specifiedType: const FullType(PrinterState),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PrinterUpdateRequest object, {
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
    required PrinterUpdateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
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
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
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
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PrinterState),
          ) as PrinterState;
          result.state = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PrinterUpdateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrinterUpdateRequestBuilder();
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
