import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jivodsr/core/router/router_refresh.dart';
import 'package:jivodsr/core/router/routes.dart';
import 'package:jivodsr/core/router/shell/main_shell.dart';
import 'package:jivodsr/features/attendance/presentation/screens/attendance.dart';
import 'package:jivodsr/features/auth/presentation/providers/auth_controller.dart';
import 'package:jivodsr/features/auth/presentation/providers/auth_providers.dart';
import 'package:jivodsr/features/auth/presentation/screens/login_screen.dart';
import 'package:jivodsr/features/auth/presentation/screens/splash_screen.dart';
import 'package:jivodsr/features/dashboard/presentation/screens/dashboard.dart';
import 'package:jivodsr/features/shops/presentation/screens/Shops.dart';

final routerProvider = Provider<GoRouter>((ref) {

  final refreshNotifier = RouterRefreshNotifier();
  ref.onDispose(() {
    refreshNotifier.dispose();
  });

  ref.listen<AuthStatus>(authControllerProvider, (previous, next) {
    refreshNotifier.refresh();
  });

  return GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
       final authStatus = ref.read(authControllerProvider);
      final currentLocation = state.matchedLocation;

      final isOnSplash = currentLocation == Routes.splash;
      final isOnLogin = currentLocation == Routes.login;

      if (authStatus == AuthStatus.loading) {
        return isOnSplash ? null : Routes.splash;
      }

      if (authStatus == AuthStatus.unauthenticated) {
        return isOnLogin ? null : Routes.login;
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isOnSplash || isOnLogin) {
          return Routes.dashboard;
        }
      }
      
      return null;
    },
    routes: [

      GoRoute(path: Routes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: Routes.login, builder: (context, state) => const LoginScreen()),
      // GoRoute(path: Routes.dashboard, builder: (context, state) => const DashboardScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context,state,navigationshell){
          return MainShell(navigationShell: navigationshell);
        },
        branches: [
            
            StatefulShellBranch(routes: [
              GoRoute(path: Routes.dashboard,
              builder: (context,state){
                return const DashboardScreen();
              })
            ]),

            StatefulShellBranch(routes: [
              GoRoute(path: Routes.shops,
              builder: (context,state){
                return const Shops();
              })
            ]),

            StatefulShellBranch(routes: [
              GoRoute(path: Routes.attendance,
              builder: (context,state){
                return const Attendance();
              })
            ])

      ])
    ],
  );
});