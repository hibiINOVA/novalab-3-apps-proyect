import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../core/config/app_providers.dart';
import '../../core/i18n/app_strings.dart';
import 'auth_state.dart';

/// Controla la sesión del operador/dueño (P-01).
///
/// La lógica de credenciales vive en el backend; aquí solo se orquesta la
/// llamada y se guarda el resultado. La persistencia se añade en la capa de
/// almacenamiento de tokens.
class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState();

  Future<bool> signIn({required String email, required String password}) async {
    state = state.copyWith(status: AuthStatus.authenticating, clearError: true);

    try {
      final response = await ref
          .read(novalabApiProvider)
          .getAuthApi()
          .login(
            loginRequest: LoginRequest(
              (b) => b
                ..email = email
                ..password = password,
            ),
          );
      final data = response.data;
      if (data == null) {
        state = state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: AppStrings.loginGenericError,
        );
        return false;
      }
      state = AuthState(
        status: AuthStatus.authenticated,
        user: data.user,
        accessToken: data.accessToken,
        refreshToken: data.refreshToken,
      );
      return true;
    } on DioException catch (error) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: _messageFor(error),
      );
      return false;
    }
  }

  void signOut() {
    state = const AuthState();
  }

  String _messageFor(DioException error) {
    switch (error.response?.statusCode) {
      case 429:
        return AppStrings.loginTooManyAttempts;
      default:
        return AppStrings.loginGenericError;
    }
  }
}
