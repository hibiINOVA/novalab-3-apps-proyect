//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'item_state.g.dart';

class ItemState extends EnumClass {
  @BuiltValueEnumConst(wireName: r'pending')
  static const ItemState pending = _$pending;
  @BuiltValueEnumConst(wireName: r'queued')
  static const ItemState queued = _$queued;
  @BuiltValueEnumConst(wireName: r'printing')
  static const ItemState printing = _$printing;
  @BuiltValueEnumConst(wireName: r'printed')
  static const ItemState printed = _$printed;
  @BuiltValueEnumConst(wireName: r'failed')
  static const ItemState failed = _$failed;

  static Serializer<ItemState> get serializer => _$itemStateSerializer;

  const ItemState._(String name) : super(name);

  static BuiltSet<ItemState> get values => _$values;
  static ItemState valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ItemStateMixin = Object with _$ItemStateMixin;
