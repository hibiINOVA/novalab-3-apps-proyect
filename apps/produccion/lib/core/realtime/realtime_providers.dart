import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/auth_providers.dart';
import '../config/app_config.dart';
import '../config/app_providers.dart';
import 'realtime_client.dart';

/// Canal de tiempo real. En modo mock usa [MockRealtimeClient] sobre el mismo
/// [MockBackend] que sirve las peticiones HTTP; en producción abre el `/ws`.
///
/// Se sobrescribe en las pruebas con un [ManualRealtimeClient].
final realtimeClientProvider = Provider<RealtimeClient>((ref) {
  final config = ref.watch(appConfigProvider);
  final RealtimeClient client;
  if (config.useMocks) {
    client = MockRealtimeClient(
      ref.watch(apiClientFactoryProvider).mockBackend,
    );
  } else {
    client = WebSocketRealtimeClient(
      realtimeUri(config, ref.read(accessTokenProvider)),
    );
  }
  client.start();
  ref.onDispose(client.close);
  return client;
});

/// Estado de la conexión de tiempo real, para indicadores en la UI.
final realtimeStatusProvider =
    NotifierProvider<RealtimeStatusNotifier, RealtimeStatus>(
      RealtimeStatusNotifier.new,
    );

class RealtimeStatusNotifier extends Notifier<RealtimeStatus> {
  @override
  RealtimeStatus build() {
    final client = ref.watch(realtimeClientProvider);
    final subscription = client.statusStream.listen((status) => state = status);
    ref.onDispose(subscription.cancel);
    return client.status;
  }
}

/// Deriva la URL del WebSocket a partir de la base HTTP.
///
/// `https` -> `wss`, `http` -> `ws`. Si la base es vacía (mismo origen), usa la
/// del documento actual (web). El token viaja como `?token=` (BE-08: no se
/// expone la IP de la impresora; esto es la conexión al backend).
Uri realtimeUri(AppConfig config, String? token) {
  final Uri base;
  if (config.apiBaseUrl.isEmpty) {
    final origin = Uri.base;
    base = origin.replace(
      scheme: origin.scheme == 'https' ? 'wss' : 'ws',
      path: '/ws',
    );
  } else {
    final parsed = Uri.parse(config.apiBaseUrl);
    base = parsed.replace(
      scheme: parsed.scheme == 'https' ? 'wss' : 'ws',
      path: '/ws',
    );
  }
  if (token == null || token.isEmpty) return base;
  return base.replace(
    queryParameters: <String, String>{...base.queryParameters, 'token': token},
  );
}
