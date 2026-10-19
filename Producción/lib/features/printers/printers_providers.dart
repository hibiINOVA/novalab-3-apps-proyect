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

  /// Crea una nueva impresora (P-02 CRUD).
  Future<Printer?> createPrinter({
    required String name,
    String? model,
    String? octoprintUrl,
    String? apiKey,
    double? bedWidth,
    double? bedDepth,
    bool cameraAvailable = false,
    List<String>? cameras,
  }) async {
    final response = await ref
        .read(novalabApiProvider)
        .getPrintersApi()
        .createPrinter(
          printerCreateRequest: PrinterCreateRequest(
            (b) => b
              ..name = name
              ..model = model
              ..octoprintUrl = octoprintUrl
              ..apiKey = apiKey
              ..bedWidth = bedWidth
              ..bedDepth = bedDepth
              ..cameraAvailable = cameraAvailable
              ..cameras.replace(cameras ?? <String>[]),
          ),
        );
    final printer = response.data;
    if (printer != null) {
      final current = state.value ?? <Printer>[];
      state = AsyncData(<Printer>[...current, printer]);
    }
    return printer;
  }

  /// Actualiza una impresora existente.
  Future<Printer?> updatePrinter({
    required int id,
    String? name,
    String? model,
    String? octoprintUrl,
    String? apiKey,
    double? bedWidth,
    double? bedDepth,
    bool? cameraAvailable,
    List<String>? cameras,
  }) async {
    final response = await ref
        .read(novalabApiProvider)
        .getPrintersApi()
        .updatePrinter(
          printerId: id,
          printerUpdateRequest: PrinterUpdateRequest(
            (b) => b
              ..name = name
              ..model = model
              ..octoprintUrl = octoprintUrl
              ..apiKey = apiKey
              ..bedWidth = bedWidth
              ..bedDepth = bedDepth
              ..cameraAvailable = cameraAvailable
              ..cameras.replace(cameras ?? <String>[]),
          ),
        );
    final updated = response.data;
    if (updated != null) {
      final current = state.value ?? <Printer>[];
      state = AsyncData(current.map((p) => p.id == id ? updated : p).toList());
    }
    return updated;
  }

  /// Elimina una impresora.
  Future<bool> deletePrinter(int id) async {
    final response = await ref
        .read(novalabApiProvider)
        .getPrintersApi()
        .deletePrinter(printerId: id);
    if (response.statusCode == 204) {
      final current = state.value ?? <Printer>[];
      state = AsyncData(current.where((p) => p.id != id).toList());
      return true;
    }
    return false;
  }
}

/// Último snapshot de una cámara de impresora (BE-07/08).
///
/// [index] selecciona la cámara (0 = principal). Devuelve `null` si la
/// impresora no tiene cámara o aún no hay snapshot, para mostrar un marcador
/// de posición en lugar de un error.
final printerCameraSnapshotProvider =
    FutureProvider.family<Uint8List?, ({int printerId, int index})>((
      ref,
      key,
    ) async {
      try {
        final response = await ref
            .watch(novalabApiProvider)
            .getPrintersApi()
            .getPrinterCameraSnapshot(
              printerId: key.printerId,
              index: key.index,
            );
        return response.data;
      } on DioException catch (error) {
        if (error.response?.statusCode == 404) return null;
        rethrow;
      }
    });
