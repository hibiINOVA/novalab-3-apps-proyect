import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:novalab_api/novalab_api.dart';
import 'package:produccion/core/api/api_client_factory.dart';
import 'package:produccion/core/config/app_config.dart';
import 'package:produccion/core/config/app_providers.dart';
import 'package:produccion/core/i18n/app_strings.dart';
import 'package:produccion/features/auth/auth_providers.dart';
import 'package:produccion/features/auth/auth_state.dart';
import 'package:produccion/features/organization/presentation/create_organization_screen.dart';
import 'package:produccion/features/organization/presentation/join_organization_screen.dart';
import 'package:produccion/features/organization/presentation/organization_requests_dialog.dart';
import 'package:produccion/features/organization/presentation/pending_approval_screen.dart';

void main() {
  Widget buildTestWidget({
    required Widget child,
    required Role role,
    MembershipStatus status = MembershipStatus.none,
  }) {
    final client = ApiClientFactory(
      const AppConfig(apiBaseUrl: 'http://localhost:8081', useMocks: true),
      mockLatency: Duration.zero,
    ).create();

    final user = User(
      (b) => b
        ..id = 10
        ..name = 'Test User'
        ..email = 'test@example.com'
        ..role = role
        ..membershipStatus = status,
    );

    final router = GoRouter(
      initialLocation: '/test',
      routes: [
        GoRoute(
          path: '/test',
          builder: (context, state) => child,
        ),
        GoRoute(
          path: '/organization/pending',
          builder: (context, state) =>
              const Scaffold(body: Text('PENDING_ROUTE')),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) =>
              const Scaffold(body: Text('DASHBOARD_ROUTE')),
        ),
      ],
    );

    return ProviderScope(
      overrides: [
        novalabApiProvider.overrideWithValue(client),
        mockLatencyProvider.overrideWithValue(Duration.zero),
        initialAuthStateProvider.overrideWithValue(
          AuthState(
            status: AuthStatus.authenticated,
            user: user,
            accessToken: 'test-token',
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }

  group('Flujo de organización', () {
    testWidgets('Dueño crea organización y ve su ID generado', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const CreateOrganizationScreen(),
          role: Role.owner,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.orgCreateTitle), findsOneWidget);
      expect(find.text(AppStrings.orgCreateSubmit), findsOneWidget);

      // Ingresa nombre de la organización
      await tester.enterText(
        find.byType(TextFormField),
        'Taller Master 3D',
      );
      await tester.tap(find.text(AppStrings.orgCreateSubmit));
      await tester.pumpAndSettle();

      // Debe mostrar la vista de éxito con el ID generado
      expect(find.text(AppStrings.orgCreatedSuccess), findsOneWidget);
      expect(find.text('Taller Master 3D'), findsOneWidget);
      expect(find.text(AppStrings.orgIdCopyHint), findsOneWidget);
      expect(find.text(AppStrings.orgGoToDashboard), findsOneWidget);
    });

    testWidgets('Operador ingresa ID de organización y envía solicitud',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const JoinOrganizationScreen(),
          role: Role.operator_,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.orgJoinTitle), findsOneWidget);
      expect(find.text(AppStrings.orgJoinSubmit), findsOneWidget);

      // Ingresa el ID de la organización demo
      await tester.enterText(
        find.byType(TextFormField),
        'ORG-NOVA-101',
      );
      await tester.tap(find.text(AppStrings.orgJoinSubmit));
      await tester.pumpAndSettle();

      expect(find.text('PENDING_ROUTE'), findsOneWidget);
    });

    testWidgets('Operador en espera ve pantalla de aprobación pendiente',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const PendingApprovalScreen(),
          role: Role.operator_,
          status: MembershipStatus.pending,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.orgPendingTitle), findsOneWidget);
      expect(find.text(AppStrings.orgPendingCheckStatus), findsOneWidget);
      expect(
        find.widgetWithText(OutlinedButton, AppStrings.logout),
        findsOneWidget,
      );
    });

    testWidgets('Dueño puede abrir diálogo de solicitudes y aceptar',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: const Scaffold(body: OrganizationRequestsDialog()),
          role: Role.owner,
          status: MembershipStatus.active,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.orgRequestsTitle), findsOneWidget);
    });
  });
}
