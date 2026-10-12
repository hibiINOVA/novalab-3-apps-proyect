//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:novalab_api/src/model/item_state.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'print_job.g.dart';

/// PrintJob
///
/// Properties:
/// * [id]
/// * [itemId]
/// * [printerId]
/// * [state]
/// * [printerName]
/// * [startedAt]
/// * [finishedAt]
/// * [gramsReal]
/// * [minutesReal]
/// * [failureReason]
@BuiltValue()
abstract class PrintJob implements Built<PrintJob, PrintJobBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'item_id')
  int get itemId;

  @BuiltValueField(wireName: r'printer_id')
  int get printerId;

  @BuiltValueField(wireName: r'state')
  ItemState get state;
  // enum stateEnum {  pending,  queued,  printing,  printed,  failed,  };

  @BuiltValueField(wireName: r'printer_name')
  String? get printerName;

  @BuiltValueField(wireName: r'started_at')
  DateTime? get startedAt;

  @BuiltValueField(wireName: r'finished_at')
  DateTime? get finishedAt;

  @BuiltValueField(wireName: r'grams_real')
  double? get gramsReal;

  @BuiltValueField(wireName: r'minutes_real')
  int? get minutesReal;

  @BuiltValueField(wireName: r'failure_reason')
  String? get failureReason;

  PrintJob._();

  factory PrintJob([void updates(PrintJobBuilder b)]) = _$PrintJob;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrintJobBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PrintJob> get serializer => _$PrintJobSerializer();
}

class _$PrintJobSerializer implements PrimitiveSerializer<PrintJob> {
  @override
  final Iterable<Type> types = const [PrintJob, _$PrintJob];

  @override
  final String wireName = r'PrintJob';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PrintJob object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
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
    yield r'state';
    yield serializers.serialize(
      object.state,
      specifiedType: const FullType(ItemState),
    );
    if (object.printerName != null) {
      yield r'printer_name';
      yield serializers.serialize(
        object.printerName,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.startedAt != null) {
      yield r'started_at';
      yield serializers.serialize(
        object.startedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.finishedAt != null) {
      yield r'finished_at';
      yield serializers.serialize(
        object.finishedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.gramsReal != null) {
      yield r'grams_real';
      yield serializers.serialize(
        object.gramsReal,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.minutesReal != null) {
      yield r'minutes_real';
      yield serializers.serialize(
        object.minutesReal,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.failureReason != null) {
      yield r'failure_reason';
      yield serializers.serialize(
        object.failureReason,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PrintJob object, {
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
    required PrintJobBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
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
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ItemState),
          ) as ItemState;
          result.state = valueDes;
          break;
        case r'printer_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.printerName = valueDes;
          break;
        case r'started_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.startedAt = valueDes;
          break;
        case r'finished_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.finishedAt = valueDes;
          break;
        case r'grams_real':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.gramsReal = valueDes;
          break;
        case r'minutes_real':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.minutesReal = valueDes;
          break;
        case r'failure_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.failureReason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PrintJob deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrintJobBuilder();
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
