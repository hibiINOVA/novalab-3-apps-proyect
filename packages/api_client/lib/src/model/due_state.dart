//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'due_state.g.dart';

class DueState extends EnumClass {
  /// Derivado de la fecha prometida; alimenta las alertas visuales (P-07)
  @BuiltValueEnumConst(wireName: r'none')
  static const DueState none = _$none;

  /// Derivado de la fecha prometida; alimenta las alertas visuales (P-07)
  @BuiltValueEnumConst(wireName: r'ok')
  static const DueState ok = _$ok;

  /// Derivado de la fecha prometida; alimenta las alertas visuales (P-07)
  @BuiltValueEnumConst(wireName: r'due_soon')
  static const DueState dueSoon = _$dueSoon;

  /// Derivado de la fecha prometida; alimenta las alertas visuales (P-07)
  @BuiltValueEnumConst(wireName: r'overdue')
  static const DueState overdue = _$overdue;

  static Serializer<DueState> get serializer => _$dueStateSerializer;

  const DueState._(String name) : super(name);

  static BuiltSet<DueState> get values => _$values;
  static DueState valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class DueStateMixin = Object with _$DueStateMixin;
