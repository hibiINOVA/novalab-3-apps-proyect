import 'package:dio/dio.dart';
import 'package:novalab_api/novalab_api.dart';

import '../config/app_config.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/mock_interceptor.dart';
import 'mock/mock_backend.dart';

/// Construye el cliente tipado ([NovalabApi]) y su [Dio] configurado.
///
/// Punto único de creación del cliente HTTP: base URL, interceptor de auth y,
/// en modo desarrollo, el backend simulado. El backend real se sirve detrás de
/// Caddy en el puerto privado (doc §2).
class ApiClientFactory {
  ApiClientFactory(this.config, {MockBackend? mockBackend})
    : _mockBackend = mockBackend ?? MockBackend();

  final AppConfig config;
  final MockBackend _mockBackend;

  NovalabApi create({
    String? Function()? getToken,
    void Function()? onUnauthorized,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.apiBaseUrl,
        connectTimeout: const Duration(seconds: 8),
        receiveTimeout: const Duration(seconds: 8),
        headers: <String, dynamic>{Headers.acceptHeader: 'application/json'},
        contentType: Headers.jsonContentType,
      ),
    );

    dio.interceptors.add(
      AuthInterceptor(
        getToken: getToken ?? () => null,
        onUnauthorized: onUnauthorized,
      ),
    );

    if (config.useMocks) {
      dio.interceptors.add(MockInterceptor(_mockBackend));
    }

    // `interceptors: const []` evita que NovalabApi agregue sus interceptores
    // de auth por defecto; el token lo maneja AuthInterceptor.
    return NovalabApi(dio: dio, interceptors: const <Interceptor>[]);
  }
}
