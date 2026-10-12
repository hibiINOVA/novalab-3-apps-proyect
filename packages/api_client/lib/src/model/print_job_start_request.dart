//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'print_job_start_request.g.dart';

/// PrintJobStartRequest
///
/// Properties:
/// * [itemId]
/// * [printerId]
@BuiltValue()
abstract class PrintJobStartRequest
    implements Built<PrintJobStartRequest, PrintJobStartRequestBuilder> {
  @BuiltValueField(wireName: r'item_id')
  int get itemId;

  @BuiltValueField(wireName: r'printer_id')
  int get printerId;

  PrintJobStartRequest._();

  factory PrintJobStartRequest([void updates(PrintJobStartRequestBuilder b)]) =
      _$PrintJobStartRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrintJobStartRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrintJobStartRequest> get serializer =>
      _$PrintJobStartRequestSerializer();
}

class _$PrintJobStartRequestSerializer
    implements PrimitiveSerializer<PrintJobStartRequest> {
  @override
  final Iterable<Type> types = const [
    PrintJobStartRequest,
    _$PrintJobStartRequest
  ];

  @override
  final String wireName = r'PrintJobStartRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrintJobStartRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'item_id';
    yield serializers.serialize(
      object.itemId,
      specifiedType: const FullType(int),
    );
    yield r'printer_id';
    yield serializers.serialize(
      object.printerId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PrintJobStartRequest object, {
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
    required PrintJobStartRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'item_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.itemId = valueDes;
          break;
        case r'printer_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.printerId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PrintJobStartRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrintJobStartRequestBuilder();
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
