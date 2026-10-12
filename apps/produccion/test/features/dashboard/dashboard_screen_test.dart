import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:produccion/core/config/app_providers.dart';
import 'package:produccion/core/realtime/realtime_client.dart';
import 'package:produccion/core/realtime/realtime_providers.dart';
import 'package:produccion/features/auth/auth_providers.dart';
import 'package:produccion/features/auth/data/auth_token_store.dart';
import 'package:produccion/features/dashboard/presentation/dashboard_screen.dart';

Future<void> _pumpDashboard(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final realtime = ManualRealtimeClient()..start();
  addTearDown(realtime.close);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authTokenStoreProvider.overrideWithValue(InMemoryAuthTokenStore()),
        mockLatencyProvider.overrideWithValue(Duration.zero),
        realtimeClientProvider.overrideWithValue(realtime),
      ],
      child: const MaterialApp(home: DashboardScreen()),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('en pantalla ancha usa riel lateral', (tester) async {
    await _pumpDashboard(tester, const Size(1200, 800));
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('en pantalla angosta usa barra inferior', (tester) async {
    await _pumpDashboard(tester, const Size(500, 800));
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
  });
}
