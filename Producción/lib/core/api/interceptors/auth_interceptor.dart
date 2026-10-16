import 'package:dio/dio.dart';

/// Inyecta el token JWT en cada petición privada.
///
/// No conoce el almacenamiento del token: recibe callbacks para leerlo y para
/// reaccionar a un 401 (p. ej. cerrar sesión). El refresh de tokens se resuelve
/// en la capa de autenticación (P-01), no aquí.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.getToken, this.onUnauthorized});

  /// Devuelve el access token vigente, o `null` si no hay sesión.
  final String? Function() getToken;

  /// Se invoca cuando el backend responde 401.
  final void Function()? onUnauthorized;

  static const String _header = 'Authorization';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = getToken();
    if (token != null && token.isNotEmpty) {
      options.headers[_header] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      onUnauthorized?.call();
    }
    handler.next(err);
  }
}
