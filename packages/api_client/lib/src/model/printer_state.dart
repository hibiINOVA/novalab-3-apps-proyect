//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'printer_state.g.dart';

class PrinterState extends EnumClass {
  @BuiltValueEnumConst(wireName: r'idle')
  static const PrinterState idle = _$idle;
  @BuiltValueEnumConst(wireName: r'printing')
  static const PrinterState printing = _$printing;
  @BuiltValueEnumConst(wireName: r'paused')
  static const PrinterState paused = _$paused;
  @BuiltValueEnumConst(wireName: r'offline')
  static const PrinterState offline = _$offline;
  @BuiltValueEnumConst(wireName: r'error')
  static const PrinterState error = _$error;

  static Serializer<PrinterState> get serializer => _$printerStateSerializer;

  const PrinterState._(String name) : super(name);

  static BuiltSet<PrinterState> get values => _$values;
  static PrinterState valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class PrinterStateMixin = Object with _$PrinterStateMixin;
