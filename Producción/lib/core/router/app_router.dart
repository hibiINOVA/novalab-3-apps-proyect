import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../features/auth/auth_providers.dart';
import '../../features/auth/auth_state.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/organization/organization_providers.dart';
import '../../features/organization/presentation/create_organization_screen.dart';
import '../../features/organization/presentation/join_organization_screen.dart';
import '../../features/organization/presentation/pending_approval_screen.dart';

/// Router de la app con guardia de sesión y organizaciones.
///
/// Rutas: `/login`, `/register`, `/organization/create`, `/organization/join`,
/// `/organization/pending` y `/` (tablero).
final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen(authControllerProvider, (_, _) => refresh.value++);
  ref.listen(organizationStatusProvider, (_, _) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: refresh,
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);
      final loggedIn = authState.status == AuthStatus.authenticated;
      final location = state.matchedLocation;
      final atAuthScreen = location == '/login' || location == '/register';

      if (!loggedIn) {
        return atAuthScreen ? null : '/login';
      }

      final user = authState.user;
      final role = user?.role;
      final status =
          user?.membershipStatus ??
          (user?.organizationId != null
              ? MembershipStatus.active
              : MembershipStatus.none);

      if (role == Role.owner) {
        if (status == MembershipStatus.none) {
          return location == '/organization/create'
              ? null
              : '/organization/create';
        }
      } else if (role == Role.operator_) {
        if (status == MembershipStatus.none ||
            status == MembershipStatus.rejected) {
          return location == '/organization/join' ? null : '/organization/join';
        }
        if (status == MembershipStatus.pending) {
          return location == '/organization/pending'
              ? null
              : '/organization/pending';
        }
      }

      // Usuario autenticado y activo en su organización
      final atOnboardingScreen = location.startsWith('/organization/');
      if (atAuthScreen || atOnboardingScreen) {
        return '/';
      }

      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/organization/create',
        name: 'organization_create',
        builder: (context, state) => const CreateOrganizationScreen(),
      ),
      GoRoute(
        path: '/organization/join',
        name: 'organization_join',
        builder: (context, state) => const JoinOrganizationScreen(),
      ),
      GoRoute(
        path: '/organization/pending',
        name: 'organization_pending',
        builder: (context, state) => const PendingApprovalScreen(),
      ),
      GoRoute(
        path: '/',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
  );
});
