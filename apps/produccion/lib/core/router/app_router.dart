import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/auth_providers.dart';
import '../../features/auth/auth_state.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';

/// Router de la app con guardia de sesión.
///
/// Rutas: `/login` y `/` (tablero). Un usuario sin sesión siempre termina en
/// `/login`; con sesión, `/login` redirige al tablero.
final routerProvider = Provider<GoRouter>((ref) {
  final status = ref.watch(
    authControllerProvider.select((state) => state.status),
  );

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final loggedIn = status == AuthStatus.authenticated;
      final atLogin = state.matchedLocation == '/login';
      if (!loggedIn) {
        return atLogin ? null : '/login';
      }
      return atLogin ? '/' : null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
  );
});
