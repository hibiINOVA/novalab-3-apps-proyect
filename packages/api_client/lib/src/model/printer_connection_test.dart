//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'printer_connection_test.g.dart';

/// PrinterConnectionTest
///
/// Properties:
/// * [ok]
/// * [message]
/// * [version] - Versión del servidor OctoPrint si la conexión fue ok.
@BuiltValue()
abstract class PrinterConnectionTest
    implements Built<PrinterConnectionTest, PrinterConnectionTestBuilder> {
  @BuiltValueField(wireName: r'ok')
  bool get ok;

  @BuiltValueField(wireName: r'message')
  String get message;

  /// Versión del servidor OctoPrint si la conexión fue ok.
  @BuiltValueField(wireName: r'version')
  String? get version;

  PrinterConnectionTest._();

  factory PrinterConnectionTest(
      [void updates(PrinterConnectionTestBuilder b)]) = _$PrinterConnectionTest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrinterConnectionTestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrinterConnectionTest> get serializer =>
      _$PrinterConnectionTestSerializer();
}

class _$PrinterConnectionTestSerializer
    implements PrimitiveSerializer<PrinterConnectionTest> {
  @override
  final Iterable<Type> types = const [
    PrinterConnectionTest,
    _$PrinterConnectionTest
  ];

  @override
  final String wireName = r'PrinterConnectionTest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrinterConnectionTest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'ok';
    yield serializers.serialize(
      object.ok,
      specifiedType: const FullType(bool),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
    if (object.version != null) {
      yield r'version';
      yield serializers.serialize(
        object.version,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PrinterConnectionTest object, {
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
    required PrinterConnectionTestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'ok':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.ok = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.version = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PrinterConnectionTest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrinterConnectionTestBuilder();
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
