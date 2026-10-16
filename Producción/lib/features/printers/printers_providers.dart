import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../core/config/app_providers.dart';
import '../../core/realtime/realtime_message.dart';
import '../../core/realtime/realtime_providers.dart';

/// Lista de impresoras, cargada del backend y refrescada ante eventos en vivo.
final printersProvider =
    AsyncNotifierProvider<PrintersController, List<Printer>>(
      PrintersController.new,
    );

class PrintersController extends AsyncNotifier<List<Printer>> {
  StreamSubscription<RealtimeMessage>? _subscription;

  @override
  Future<List<Printer>> build() async {
    final client = ref.watch(realtimeClientProvider);
    _subscription = client.messages.listen(_onRealtimeMessage);
    ref.onDispose(() => _subscription?.cancel());
    return _fetchPrinters();
  }

  Future<List<Printer>> _fetchPrinters() async {
    final response = await ref
        .read(novalabApiProvider)
        .getPrintersApi()
        .listPrinters();
    return response.data?.toList() ?? <Printer>[];
  }

  Future<void> _onRealtimeMessage(RealtimeMessage message) async {
    if (message.entity != 'printer' && message.entity != 'queue') return;
    try {
      state = AsyncData(await _fetchPrinters());
    } catch (_) {
      // Conservar el último estado bueno ante fallos puntuales.
    }
  }

  /// Recarga manual (botón "Reintentar").
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchPrinters);
  }
}

/// Última miniatura de cámara de una impresora (BE-07/08).
///
/// Devuelve `null` si la impresora no tiene cámara o aún no hay snapshot, para
/// mostrar un marcador de posición en lugar de un error.
final printerCameraSnapshotProvider = FutureProvider.family<Uint8List?, int>((
  ref,
  printerId,
) async {
  try {
    final response = await ref
        .watch(novalabApiProvider)
        .getPrintersApi()
        .getPrinterCameraSnapshot(printerId: printerId);
    return response.data;
  } on DioException catch (error) {
    if (error.response?.statusCode == 404) return null;
    rethrow;
  }
});
