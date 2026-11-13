import 'package:flutter/material.dart';
import 'package:jivodsr/core/router/routes.dart';

class AppMenuItem {
  const AppMenuItem({
    required this.module,
    required this.label,
    required this.icon,
    this.route,
  });

  final String module;
  final String label;
  final IconData icon;
  final String? route;

  factory AppMenuItem.forModule(String module) {
    return _screens[module] ??
        AppMenuItem(
          module: module,
          label: _labelFrom(module),
          icon: Icons.apps_outlined,
        );
  }

  static const _screens = <String, AppMenuItem>{
    'dashboard': AppMenuItem(
      module: 'dashboard',
      label: 'Dashboard',
      icon: Icons.space_dashboard_outlined,
      route: Routes.dashboard,
    ),
    'attendance': AppMenuItem(
      module: 'attendance',
      label: 'Attendance',
      icon: Icons.event_available_outlined,
      route: Routes.attendance,
    ),
  };

  static String _labelFrom(String module) => module
      .split(RegExp(r'[_\s-]+'))
      .where((word) => word.isNotEmpty)
      .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
      .join(' ');
}
