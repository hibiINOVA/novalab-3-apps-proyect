// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (Serializers().toBuilder()
      ..add(Branding.serializer)
      ..add(Error.serializer)
      ..add(LoginRequest.serializer)
      ..add(LoginResponse.serializer)
      ..add(OrderRef.serializer)
      ..add(Printer.serializer)
      ..add(PrinterState.serializer)
      ..add(Queue.serializer)
      ..add(QueueItem.serializer)
      ..add(QueueItemState.serializer)
      ..add(QueueReorderEntry.serializer)
      ..add(QueueReorderRequest.serializer)
      ..add(RefreshRequest.serializer)
      ..add(Role.serializer)
      ..add(SpoolRef.serializer)
      ..add(StatusEvent.serializer)
      ..add(User.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(QueueItem)]),
          () => ListBuilder<QueueItem>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(BuiltList, const [const FullType(QueueItem)])
          ]),
          () => MapBuilder<String, BuiltList<QueueItem>>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(QueueReorderEntry)]),
          () => ListBuilder<QueueReorderEntry>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(String),
            const FullType.nullable(JsonObject)
          ]),
          () => MapBuilder<String, JsonObject?>()))
    .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
