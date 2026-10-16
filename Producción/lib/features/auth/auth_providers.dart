import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_controller.dart';
import 'auth_state.dart';
import 'data/auth_token_store.dart';

/// Almacenamiento de la sesión. Debe sobrescribirse en `main()` (con
/// SharedPreferences) o en las pruebas (con [InMemoryAuthTokenStore]).
final authTokenStoreProvider = Provider<AuthTokenStore>((ref) {
  throw UnimplementedError(
    'authTokenStoreProvider debe sobrescribirse en main() o en las pruebas.',
  );
});

/// Sesión restaurada al arrancar, leída antes de crear el [ProviderScope].
final initialAuthStateProvider = Provider<AuthState>(
  (ref) => const AuthState(),
);

/// Sesión actual de la app.
final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

/// Access token vigente, o `null`. Lo consume el interceptor de auth.
final accessTokenProvider = Provider<String?>(
  (ref) => ref.watch(authControllerProvider).accessToken,
);
