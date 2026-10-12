import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../features/auth/auth_providers.dart';
import '../api/api_client_factory.dart';
import '../config/app_config.dart';

/// Configuración efectiva (`--dart-define`).
final appConfigProvider = Provider<AppConfig>((ref) => AppConfig.current);

/// Fábrica del cliente HTTP (única instancia, conserva el estado del mock).
final apiClientFactoryProvider = Provider<ApiClientFactory>(
  (ref) => ApiClientFactory(ref.watch(appConfigProvider)),
);

/// Cliente tipado generado desde OpenAPI.
///
/// El token se lee en cada petición y el 401 dispara cierre de sesión.
final novalabApiProvider = Provider<NovalabApi>((ref) {
  final factory = ref.watch(apiClientFactoryProvider);
  return factory.create(
    getToken: () => ref.read(accessTokenProvider),
    onUnauthorized: () => ref.read(authControllerProvider.notifier).signOut(),
  );
});
