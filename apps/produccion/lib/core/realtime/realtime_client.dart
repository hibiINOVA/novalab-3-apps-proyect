import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../api/mock/mock_backend.dart';
import 'realtime_message.dart';

/// Estado de la conexión de tiempo real.
enum RealtimeStatus { disconnected, connecting, connected }

/// Fuente de eventos en vivo para el tablero (doc §2, `/ws`).
///
/// Se abstrae para poder sustituirla por una implementación simulada mientras
/// no exista el backend. Expone el estado actual ([status]) además del stream
/// de cambios para que los suscriptores tardíos no pierdan el valor inicial.
abstract interface class RealtimeClient {
  Stream<RealtimeMessage> get messages;

  Stream<RealtimeStatus> get statusStream;

  RealtimeStatus get status;

  void start();

  Future<void> close();
}

/// Base con manejo común del estado de conexión.
abstract class _BaseRealtimeClient implements RealtimeClient {
  final StreamController<RealtimeMessage> _messages =
      StreamController<RealtimeMessage>.broadcast();
  final StreamController<RealtimeStatus> _statusController =
      StreamController<RealtimeStatus>.broadcast();

  RealtimeStatus _status = RealtimeStatus.disconnected;

  @override
  Stream<RealtimeMessage> get messages => _messages.stream;

  @override
  Stream<RealtimeStatus> get statusStream => _statusController.stream;

  @override
  RealtimeStatus get status => _status;

  void emitMessage(RealtimeMessage message) {
    if (!_messages.isClosed) _messages.add(message);
  }

  void setStatus(RealtimeStatus value) {
    _status = value;
    if (!_statusController.isClosed) _statusController.add(value);
  }

  Future<void> closeControllers() async {
    await _statusController.close();
    await _messages.close();
  }
}

/// Cliente WebSocket real. El token viaja como parámetro de consulta porque los
/// navegadores no permiten encabezados en `WebSocket`.
class WebSocketRealtimeClient extends _BaseRealtimeClient {
  WebSocketRealtimeClient(this.uri);

  final Uri uri;

  WebSocketChannel? _channel;

  @override
  void start() {
    if (_channel != null) return;
    setStatus(RealtimeStatus.connecting);
    try {
      final channel = WebSocketChannel.connect(uri);
      _channel = channel;
      channel.stream.listen(
        _onData,
        onDone: () => setStatus(RealtimeStatus.disconnected),
        onError: (Object _) => setStatus(RealtimeStatus.disconnected),
        cancelOnError: true,
      );
    } catch (_) {
      setStatus(RealtimeStatus.disconnected);
    }
  }

  void _onData(Object? data) {
    setStatus(RealtimeStatus.connected);
    if (data is! String) return;
    try {
      final decoded = jsonDecode(data);
      if (decoded is Map) {
        emitMessage(RealtimeMessage.fromJson(decoded.cast<String, Object?>()));
      }
    } catch (_) {
      // Ignorar mensajes no parseables.
    }
  }

  @override
  Future<void> close() async {
    await _channel?.sink.close();
    _channel = null;
    await closeControllers();
  }
}

/// Cliente de tiempo real simulado: avanza el [MockBackend] periódicamente y
/// emite un evento para que el panel refresque.
class MockRealtimeClient extends _BaseRealtimeClient {
  MockRealtimeClient(
    this.backend, {
    this.interval = const Duration(seconds: 4),
  });

  final MockBackend backend;

  /// Cadencia de simulación. En pruebas se inyecta un canal controlado a mano.
  final Duration interval;

  Timer? _timer;

  @override
  void start() {
    if (_timer != null) return;
    setStatus(RealtimeStatus.connected);
    _timer = Timer.periodic(interval, (_) {
      final id = backend.tick();
      if (id != null) {
        emitMessage(
          RealtimeMessage(
            type: 'printer.state',
            entity: 'printer',
            entityId: id,
          ),
        );
      }
    });
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    _timer = null;
    await closeControllers();
  }
}

/// Cliente de tiempo real controlado manualmente. Para pruebas: no crea timers.
class ManualRealtimeClient extends _BaseRealtimeClient {
  @override
  void start() => setStatus(RealtimeStatus.connected);

  @override
  Future<void> close() => closeControllers();

  /// Publica un mensaje en el stream (helper de pruebas).
  void emit(RealtimeMessage message) => emitMessage(message);
}
