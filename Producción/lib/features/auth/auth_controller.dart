import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../core/config/app_providers.dart';
import '../../core/i18n/app_strings.dart';
import 'auth_providers.dart';
import 'auth_state.dart';

/// Controla la sesión del operador/dueño (P-01).
///
/// La lógica de credenciales vive en el backend; aquí solo se orquesta la
/// llamada, se guarda el resultado y se persiste la sesión en el dispositivo.
class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() => ref.watch(initialAuthStateProvider);

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
      final next = AuthState(
        status: AuthStatus.authenticated,
        user: data.user,
        accessToken: data.accessToken,
        refreshToken: data.refreshToken,
      );
      state = next;
      await _persist(next);
      return true;
    } on DioException catch (error) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: _messageFor(error),
      );
      return false;
    }
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
    required Role role,
  }) async {
    state = state.copyWith(status: AuthStatus.authenticating, clearError: true);

    try {
      final response = await ref
          .read(novalabApiProvider)
          .getAuthApi()
          .register(
            registerRequest: RegisterRequest(
              (b) => b
                ..name = name
                ..email = email
                ..password = password
                ..role = role,
            ),
          );
      final data = response.data;
      if (data == null) {
        state = state.copyWith(
          status: AuthStatus.unauthenticated,
          errorMessage: AppStrings.registerGenericError,
        );
        return false;
      }
      final next = AuthState(
        status: AuthStatus.authenticated,
        user: data.user,
        accessToken: data.accessToken,
        refreshToken: data.refreshToken,
      );
      state = next;
      await _persist(next);
      return true;
    } on DioException catch (error) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: _registerMessageFor(error),
      );
      return false;
    }
  }

  void signOut() {
    state = const AuthState();
    unawaited(_clearPersisted());
  }

  Future<void> refreshSessionUser() async {
    if (state.user == null) return;
    try {
      final response = await ref
          .read(novalabApiProvider)
          .getOrganizationsApi()
          .getCurrentOrganization();
      final status = response.data;
      if (status != null && state.user != null) {
        final updatedUser = state.user!.rebuild((b) {
          b
            ..organizationId = status.organization?.id
            ..organizationCode = status.organization?.code
            ..membershipStatus = status.membershipStatus;
        });
        final next = state.copyWith(user: updatedUser);
        state = next;
        await _persist(next);
      }
    } catch (_) {
      // Ignorar fallos de red al refrescar estado de sesión.
    }
  }

  Future<void> _persist(AuthState session) async {
    try {
      await ref.read(authTokenStoreProvider).save(session);
    } catch (_) {
      // No romper la sesión si falla la persistencia.
    }
  }

  Future<void> _clearPersisted() async {
    try {
      await ref.read(authTokenStoreProvider).clear();
    } catch (_) {
      // Ignorar fallos de almacenamiento al cerrar sesión.
    }
  }

  String _messageFor(DioException error) {
    switch (error.response?.statusCode) {
      case 429:
        return AppStrings.loginTooManyAttempts;
      default:
        return AppStrings.loginGenericError;
    }
  }

  String _registerMessageFor(DioException error) {
    switch (error.response?.statusCode) {
      case 409:
        return AppStrings.registerEmailTaken;
      case 429:
        return AppStrings.loginTooManyAttempts;
      default:
        return AppStrings.registerGenericError;
    }
  }
}
