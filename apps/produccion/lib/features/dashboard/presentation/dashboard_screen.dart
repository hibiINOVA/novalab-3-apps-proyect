import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/branding/branding_provider.dart';
import '../../../core/i18n/app_strings.dart';
import '../../auth/auth_providers.dart';
import '../../printers/presentation/printers_tab.dart';
import '../../queue/presentation/queue_tab.dart';

/// Contenedor principal tras iniciar sesión.
///
/// Dos pestañas: tablero de impresoras (P-02) y cola (P-03). La marca se lee de
/// `brandingProvider`.
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final branding = ref.watch(brandingProvider).value;
    final businessName = branding?.businessName ?? AppStrings.appTitle;

    return Scaffold(
      appBar: AppBar(
        title: Text(businessName),
        actions: <Widget>[
          IconButton(
            tooltip: AppStrings.logout,
            onPressed: () =>
                ref.read(authControllerProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: IndexedStack(
        index: _index,
        children: const <Widget>[PrintersTab(), QueueTab()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.print_outlined),
            selectedIcon: Icon(Icons.print),
            label: AppStrings.navPrinters,
          ),
          NavigationDestination(
            icon: Icon(Icons.view_kanban_outlined),
            selectedIcon: Icon(Icons.view_kanban),
            label: AppStrings.navQueue,
          ),
        ],
      ),
    );
  }
}
