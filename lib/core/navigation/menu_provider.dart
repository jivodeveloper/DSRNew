import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jivodsr/core/navigation/app_menu_item.dart';
import 'package:jivodsr/features/dashboard/presentation/providers/dashboard_provider.dart';

final menuItemsProvider = Provider<List<AppMenuItem>>((ref) {
  final details = ref.watch(userDetailsProvider).value;
  if (details == null) return const [];

  final modules = details.mobileModules;

  return [
    for (final module in modules)
      if (module == 'dashboard') AppMenuItem.forModule(module),
    for (final module in modules)
      if (module != 'dashboard') AppMenuItem.forModule(module),
  ];
});
