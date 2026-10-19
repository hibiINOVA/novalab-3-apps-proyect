//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:novalab_api/src/model/spool_ref.dart';
import 'package:novalab_api/src/model/printer_state.dart';
import 'package:built_collection/built_collection.dart';
import 'package:novalab_api/src/model/order_ref.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'printer.g.dart';

/// Printer
///
/// Properties:
/// * [id]
/// * [name]
/// * [state]
/// * [model]
/// * [progress]
/// * [remainingSeconds]
/// * [nozzleTemp]
/// * [nozzleTarget]
/// * [bedTemp]
/// * [bedTarget]
/// * [currentFile]
/// * [cameraAvailable]
/// * [cameras] - URLs de snapshot por cámara (solo admin; BE-08/BE-21).
/// * [loadedSpool]
/// * [currentOrder]
/// * [lastSeen]
@BuiltValue()
abstract class Printer implements Built<Printer, PrinterBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'state')
  PrinterState get state;
  // enum stateEnum {  idle,  printing,  paused,  offline,  error,  };

  @BuiltValueField(wireName: r'model')
  String? get model;

  @BuiltValueField(wireName: r'progress')
  double? get progress;

  @BuiltValueField(wireName: r'remaining_seconds')
  int? get remainingSeconds;

  @BuiltValueField(wireName: r'nozzle_temp')
  double? get nozzleTemp;

  @BuiltValueField(wireName: r'nozzle_target')
  double? get nozzleTarget;

  @BuiltValueField(wireName: r'bed_temp')
  double? get bedTemp;

  @BuiltValueField(wireName: r'bed_target')
  double? get bedTarget;

  @BuiltValueField(wireName: r'current_file')
  String? get currentFile;

  @BuiltValueField(wireName: r'camera_available')
  bool? get cameraAvailable;

  /// URLs de snapshot por cámara (solo admin; BE-08/BE-21).
  @BuiltValueField(wireName: r'cameras')
  BuiltList<String>? get cameras;

  @BuiltValueField(wireName: r'loaded_spool')
  SpoolRef? get loadedSpool;

  @BuiltValueField(wireName: r'current_order')
  OrderRef? get currentOrder;

  @BuiltValueField(wireName: r'last_seen')
  DateTime? get lastSeen;

  Printer._();

  factory Printer([void updates(PrinterBuilder b)]) = _$Printer;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PrinterBuilder b) => b..cameraAvailable = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<Printer> get serializer => _$PrinterSerializer();
}

class _$PrinterSerializer implements PrimitiveSerializer<Printer> {
  @override
  final Iterable<Type> types = const [Printer, _$Printer];

  @override
  final String wireName = r'Printer';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Printer object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'state';
    yield serializers.serialize(
      object.state,
      specifiedType: const FullType(PrinterState),
    );
    if (object.model != null) {
      yield r'model';
      yield serializers.serialize(
        object.model,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.progress != null) {
      yield r'progress';
      yield serializers.serialize(
        object.progress,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.remainingSeconds != null) {
      yield r'remaining_seconds';
      yield serializers.serialize(
        object.remainingSeconds,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.nozzleTemp != null) {
      yield r'nozzle_temp';
      yield serializers.serialize(
        object.nozzleTemp,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.nozzleTarget != null) {
      yield r'nozzle_target';
      yield serializers.serialize(
        object.nozzleTarget,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.bedTemp != null) {
      yield r'bed_temp';
      yield serializers.serialize(
        object.bedTemp,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.bedTarget != null) {
      yield r'bed_target';
      yield serializers.serialize(
        object.bedTarget,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.currentFile != null) {
      yield r'current_file';
      yield serializers.serialize(
        object.currentFile,
        specifiedType: const FullType.nullable(String),
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
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.loadedSpool != null) {
      yield r'loaded_spool';
      yield serializers.serialize(
        object.loadedSpool,
        specifiedType: const FullType.nullable(SpoolRef),
      );
    }
    if (object.currentOrder != null) {
      yield r'current_order';
      yield serializers.serialize(
        object.currentOrder,
        specifiedType: const FullType.nullable(OrderRef),
      );
    }
    if (object.lastSeen != null) {
      yield r'last_seen';
      yield serializers.serialize(
        object.lastSeen,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    Printer object, {
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
    required PrinterBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PrinterState),
          ) as PrinterState;
          result.state = valueDes;
          break;
        case r'model':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.model = valueDes;
          break;
        case r'progress':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.progress = valueDes;
          break;
        case r'remaining_seconds':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.remainingSeconds = valueDes;
          break;
        case r'nozzle_temp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.nozzleTemp = valueDes;
          break;
        case r'nozzle_target':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.nozzleTarget = valueDes;
          break;
        case r'bed_temp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.bedTemp = valueDes;
          break;
        case r'bed_target':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.bedTarget = valueDes;
          break;
        case r'current_file':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.currentFile = valueDes;
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
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.cameras.replace(valueDes);
          break;
        case r'loaded_spool':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(SpoolRef),
          ) as SpoolRef?;
          if (valueDes == null) continue;
          result.loadedSpool.replace(valueDes);
          break;
        case r'current_order':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OrderRef),
          ) as OrderRef?;
          if (valueDes == null) continue;
          result.currentOrder.replace(valueDes);
          break;
        case r'last_seen':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.lastSeen = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Printer deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PrinterBuilder();
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
