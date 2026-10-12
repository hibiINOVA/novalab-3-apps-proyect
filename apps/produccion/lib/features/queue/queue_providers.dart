import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../core/config/app_providers.dart';
import '../../core/realtime/realtime_message.dart';
import '../../core/realtime/realtime_providers.dart';

/// Cola de producción (P-03): items sin asignar y por impresora.
final queueProvider = AsyncNotifierProvider<QueueController, Queue>(
  QueueController.new,
);

class QueueController extends AsyncNotifier<Queue> {
  StreamSubscription<RealtimeMessage>? _subscription;

  @override
  Future<Queue> build() async {
    final client = ref.watch(realtimeClientProvider);
    _subscription = client.messages.listen(_onRealtimeMessage);
    ref.onDispose(() => _subscription?.cancel());
    return _fetchQueue();
  }

  Future<Queue> _fetchQueue() async {
    final response = await ref
        .read(novalabApiProvider)
        .getQueueApi()
        .getQueue();
    final queue = response.data;
    if (queue == null) {
      throw StateError('Respuesta de cola vacía.');
    }
    return queue;
  }

  Future<void> _onRealtimeMessage(RealtimeMessage message) async {
    if (message.entity != 'queue' && message.entity != 'printer') return;
    try {
      state = AsyncData(await _fetchQueue());
    } catch (_) {
      // Conservar el último estado bueno ante fallos puntuales.
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchQueue);
  }

  /// Mueve un item a otra columna y/o posición.
  ///
  /// Aplica el cambio de forma optimista y lo confirma con el backend; ante un
  /// conflicto de versión revierte y recarga. Devuelve `false` si falló.
  Future<bool> moveItem({
    required int itemId,
    required int? printerId,
    required int position,
  }) async {
    final current = state.value;
    if (current == null) return false;

    final moved = _applyMove(
      current,
      itemId: itemId,
      printerId: printerId,
      position: position,
    );
    if (identical(moved, current)) return true;

    state = AsyncData(moved);
    try {
      final response = await ref
          .read(novalabApiProvider)
          .getQueueApi()
          .reorderQueue(
            queueReorderRequest: QueueReorderRequest(
              (b) => b
                ..version = current.version
                ..items.addAll(_entries(moved)),
            ),
          );
      final queue = response.data;
      if (queue != null) state = AsyncData(queue);
      return true;
    } on DioException {
      state = AsyncData(current);
      await refresh();
      return false;
    }
  }
}

/// Aplana la cola como lista de entradas de reordenamiento.
List<QueueReorderEntry> _entries(Queue queue) {
  final result = <QueueReorderEntry>[];
  void add(Iterable<QueueItem> items) {
    for (final item in items) {
      result.add(
        QueueReorderEntry(
          (b) => b
            ..id = item.id
            ..printerId = item.printerId
            ..position = item.position ?? 0,
        ),
      );
    }
  }

  add(queue.unassigned);
  for (final list in queue.byPrinter.values) {
    add(list);
  }
  return result;
}

/// Devuelve una nueva [Queue] con el item movido, o la misma si no cambió.
Queue _applyMove(
  Queue current, {
  required int itemId,
  required int? printerId,
  required int position,
}) {
  final columns = <int?, List<QueueItem>>{null: current.unassigned.toList()};
  current.byPrinter.forEach((key, list) {
    columns[int.tryParse(key) ?? -1] = list.toList();
  });

  QueueItem? moving;
  for (final list in columns.values) {
    final index = list.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      moving = list.removeAt(index);
      break;
    }
  }
  if (moving == null) return current;

  final target = columns.putIfAbsent(printerId, () => <QueueItem>[]);
  final clamped = position.clamp(0, target.length).toInt();
  target.insert(clamped, moving);

  for (final entry in columns.entries) {
    for (var i = 0; i < entry.value.length; i++) {
      entry.value[i] = entry.value[i].rebuild(
        (b) => b
          ..printerId = entry.key
          ..position = i,
      );
    }
  }

  return current.rebuild((b) {
    b.unassigned.replace(columns[null] ?? <QueueItem>[]);
    b.byPrinter.clear();
    columns.forEach((key, list) {
      if (key != null) {
        b.byPrinter[key.toString()] = BuiltList<QueueItem>(list);
      }
    });
  });
}
