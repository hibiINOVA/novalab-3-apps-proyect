import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novalab_api/novalab_api.dart';

import '../../../core/branding/branding_provider.dart';
import '../../../core/i18n/app_strings.dart';
import '../../auth/auth_providers.dart';
import '../../organization/organization_providers.dart';
import '../../organization/presentation/organization_requests_dialog.dart';
import '../../printers/presentation/printers_tab.dart';
import '../../queue/presentation/queue_tab.dart';

/// Ancho a partir del cual se usa [NavigationRail] en vez de [NavigationBar].
const double _railBreakpoint = 720;

/// Contenedor principal tras iniciar sesión.
///
/// Dos pestañas: tablero de impresoras (P-02) y cola (P-03). La marca se lee de
/// `brandingProvider`. Adapta la navegación a tablet/escritorio (riel lateral)
/// o móvil (barra inferior).
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _index = 0;

  static const List<Widget> _tabs = <Widget>[PrintersTab(), QueueTab()];
  static const List<NavigationRailDestination> _railDestinations =
      <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.print_outlined),
          selectedIcon: Icon(Icons.print),
          label: Text(AppStrings.navPrinters),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.view_kanban_outlined),
          selectedIcon: Icon(Icons.view_kanban),
          label: Text(AppStrings.navQueue),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final branding = ref.watch(brandingProvider).value;
    final businessName = branding?.businessName ?? AppStrings.appTitle;
    final wide = MediaQuery.sizeOf(context).width >= _railBreakpoint;

    final auth = ref.watch(authControllerProvider);
    final user = auth.user;
    final isOwner = user?.role == Role.owner;
    final orgStatus = ref.watch(organizationStatusProvider).value;
    final orgCode = orgStatus?.organization?.code ?? user?.organizationCode;
    final pendingCount = ref.watch(pendingRequestsProvider).value?.length ?? 0;

    final body = IndexedStack(index: _index, children: _tabs);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(businessName),
            if (orgCode != null)
              Text(
                'ID: $orgCode',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        actions: <Widget>[
          if (isOwner)
            IconButton(
              tooltip: AppStrings.orgRequestsTooltip,
              onPressed: () => OrganizationRequestsDialog.show(context),
              icon: Badge.count(
                count: pendingCount,
                isLabelVisible: pendingCount > 0,
                child: const Icon(Icons.group_outlined),
              ),
            ),
          IconButton(
            tooltip: AppStrings.logout,
            onPressed: () =>
                ref.read(authControllerProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: wide
          ? Row(
              children: <Widget>[
                NavigationRail(
                  selectedIndex: _index,
                  onDestinationSelected: (value) =>
                      setState(() => _index = value),
                  labelType: NavigationRailLabelType.all,
                  destinations: _railDestinations,
                ),
                const VerticalDivider(width: 1),
                Expanded(child: body),
              ],
            )
          : body,
      bottomNavigationBar: wide
          ? null
          : NavigationBar(
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
