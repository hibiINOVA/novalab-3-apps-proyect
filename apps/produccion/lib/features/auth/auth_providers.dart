import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_controller.dart';
import 'auth_state.dart';

/// Sesión actual de la app.
final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

/// Access token vigente, o `null`. Lo consume el interceptor de auth.
final accessTokenProvider = Provider<String?>(
  (ref) => ref.watch(authControllerProvider).accessToken,
);
