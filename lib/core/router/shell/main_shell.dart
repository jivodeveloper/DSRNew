import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jivodsr/features/auth/presentation/providers/auth_providers.dart';

class MainShell extends ConsumerWidget {

  const MainShell({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  static const _titles = [
    'Dashboard',
    'Visits',
    'Orders',
  ];

  void _changeTab(int index) {
    navigationShell.goBranch(
      index,
      initialLocation:
          index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = navigationShell.currentIndex;

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[currentIndex]),
      ),

      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const DrawerHeader(
                child: Row(
                  children: [

                    CircleAvatar(
                      radius: 28,
                      child: Icon(
                        Icons.person_outline,
                        size: 30,
                      ),
                    ),

                    SizedBox(width: 16),

                    Expanded(
                      child: Text(
                        'Jivo DSR',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              ListTile(
                leading: const Icon(Icons.dashboard_outlined),
                title: const Text('Dashboard'),
                selected: currentIndex == 0,
                onTap: () {
                  Navigator.pop(context);
                  _changeTab(0);
                },
              ),

              ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: const Text('Visits'),
                selected: currentIndex == 1,
                onTap: () {
                  Navigator.pop(context);
                  _changeTab(1);
                },
              ),

              ListTile(
                leading: const Icon(Icons.receipt_long_outlined),
                title: const Text('Orders'),
                selected: currentIndex == 2,
                onTap: () {
                  Navigator.pop(context);
                  _changeTab(2);
                },
              ),

              const Divider(),

              // More DSR drawer modules will be added here.

              const Spacer(),

              const Divider(),

              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ref.read(authControllerProvider.notifier).logout();
                },
              ),
            ],
          ),
        ),
      ),
      
      body: navigationShell,

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: _changeTab,
        destinations: const [

          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),

          NavigationDestination(
            icon: Icon(Icons.location_on_outlined),
            selectedIcon: Icon(Icons.location_on),
            label: 'Visits',
          ),

          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),

        ],
      ),

    );
  }

}