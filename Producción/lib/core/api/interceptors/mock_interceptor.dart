import 'package:dio/dio.dart';

import '../mock/mock_backend.dart';

/// Interceptor que responde peticiones simuladas desde [MockBackend].
///
/// Solo se registra cuando `USE_MOCKS` está activo. Las rutas no simuladas
/// pasan al backend real.
class MockInterceptor extends Interceptor {
  MockInterceptor(
    this._backend, {
    this.latency = const Duration(milliseconds: 220),
  });

  final MockBackend _backend;

  /// Latencia artificial para que los estados de carga sean visibles en UI.
  final Duration latency;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final result = _backend.handle(
      options.method,
      options.path,
      options.data,
      query: options.queryParameters,
    );
    if (result == null) {
      return handler.next(options);
    }

    if (latency > Duration.zero) {
      await Future<void>.delayed(latency);
    }

    final response = Response<Object?>(
      requestOptions: options,
      statusCode: result.statusCode,
      data: result.data,
      headers: Headers.fromMap(<String, List<String>>{
        Headers.contentTypeHeader: <String>[result.contentType],
      }),
    );

    if (result.statusCode >= 200 && result.statusCode < 300) {
      return handler.resolve(response);
    }
    return handler.reject(
      DioException(
        requestOptions: options,
        response: response,
        type: DioExceptionType.badResponse,
      ),
    );
  }
}
