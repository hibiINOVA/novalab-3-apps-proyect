//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'queue_item_state.g.dart';

class QueueItemState extends EnumClass {
  @BuiltValueEnumConst(wireName: r'pending')
  static const QueueItemState pending = _$pending;
  @BuiltValueEnumConst(wireName: r'queued')
  static const QueueItemState queued = _$queued;
  @BuiltValueEnumConst(wireName: r'printing')
  static const QueueItemState printing = _$printing;
  @BuiltValueEnumConst(wireName: r'printed')
  static const QueueItemState printed = _$printed;
  @BuiltValueEnumConst(wireName: r'failed')
  static const QueueItemState failed = _$failed;

  static Serializer<QueueItemState> get serializer =>
      _$queueItemStateSerializer;

  const QueueItemState._(String name) : super(name);

  static BuiltSet<QueueItemState> get values => _$values;
  static QueueItemState valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class QueueItemStateMixin = Object with _$QueueItemStateMixin;
