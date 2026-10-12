import 'package:novalab_api/novalab_api.dart';

/// Estado de la sesión (P-01).
enum AuthStatus { unauthenticated, authenticating, authenticated }

class AuthState {
  const AuthState({
    this.status = AuthStatus.unauthenticated,
    this.user,
    this.accessToken,
    this.refreshToken,
    this.errorMessage,
  });

  final AuthStatus status;
  final User? user;
  final String? accessToken;
  final String? refreshToken;
  final String? errorMessage;

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isOwner => user?.role == Role.owner;

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? accessToken,
    String? refreshToken,
    String? errorMessage,
    bool clearError = false,
    bool clearSession = false,
  }) {
    return AuthState(
      status: clearSession
          ? AuthStatus.unauthenticated
          : (status ?? this.status),
      user: clearSession ? null : (user ?? this.user),
      accessToken: clearSession ? null : (accessToken ?? this.accessToken),
      refreshToken: clearSession ? null : (refreshToken ?? this.refreshToken),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
