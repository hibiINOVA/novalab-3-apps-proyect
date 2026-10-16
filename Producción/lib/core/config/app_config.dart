/// Configuración de la app leída desde `--dart-define`.
///
/// Ejemplos:
///   flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8081
///   flutter build web --dart-define=USE_MOCKS=false --dart-define=API_BASE_URL=
class AppConfig {
  const AppConfig({required this.apiBaseUrl, required this.useMocks});

  /// Base de la API. Vacío = mismo origen (el backend se sirve tras Caddy).
  final String apiBaseUrl;

  /// Usa respuestas simuladas locales en lugar del backend real.
  ///
  /// Por defecto `true` mientras el backend no existe. En producción pasar
  /// `--dart-define=USE_MOCKS=false` (doc §2, dos puertos).
  final bool useMocks;

  static const AppConfig _fromEnvironment = AppConfig(
    apiBaseUrl: String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'http://localhost:8081',
    ),
    useMocks: bool.fromEnvironment('USE_MOCKS', defaultValue: true),
  );

  /// Configuración efectiva del proceso actual.
  static AppConfig get current => _fromEnvironment;

  @override
  String toString() =>
      'AppConfig(apiBaseUrl: "$apiBaseUrl", useMocks: $useMocks)';
}
