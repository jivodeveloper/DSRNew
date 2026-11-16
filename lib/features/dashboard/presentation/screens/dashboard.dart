import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jivodsr/core/error/app_exception.dart';
import 'package:jivodsr/core/router/routes.dart';
import 'package:jivodsr/core/theme/app_text_styles.dart';
import 'package:jivodsr/core/widgets/skeleton.dart';
import 'package:jivodsr/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:jivodsr/features/dashboard/presentation/widget/go_to_card.dart';
import 'package:jivodsr/features/dashboard/presentation/widget/profile_card.dart';
import 'package:jivodsr/features/dashboard/presentation/widget/progress_card.dart';
import 'package:jivodsr/features/attendance/presentation/providers/attendance_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  /// Pull-to-refresh: reload every card on the dashboard.
  Future<void> _refresh(WidgetRef ref) {
    ref.invalidate(dashboardProgressProvider); // both Today and This month
    ref.invalidate(attendanceMonthProvider); // the Present pill
    return ref.refresh(userDetailsProvider.future);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(userDetailsProvider);

    return RefreshIndicator(
      onRefresh: () => _refresh(ref),
      child: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          userDetails.when(
            loading: () => const Pulse(
              child: Column(
                children: [
                  SkeletonBox(height: 96), // profile card
                  SizedBox(height: 12),
                  SkeletonBox(height: 280), // progress card
                  SizedBox(height: 12),
                  SkeletonBox(height: 200), // go to card
                ],
              ),
            ),
            error: (error, _) => _ErrorCard(
              message: error is AppException
                  ? error.message
                  : 'Could not load your details.',
              onRetry: () => ref.invalidate(userDetailsProvider),
            ),
            data: (details) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileCard(details: details),
                const SizedBox(height: 12),
                const ProgressCard(),
                const SizedBox(height: 12),
                GoToCard(
                  items: [
                    GoToItem(
                      icon: Icons.event_available_outlined,
                      title: 'Attendance',
                      subtitle: 'Punch in, punch out and monthly summary',
                      onTap: () => context.go(Routes.attendance),
                    ),
                    GoToItem(
                      icon: Icons.add_shopping_cart_outlined,
                      title: 'New order',
                      subtitle: 'Take an order at a shop',
                      onTap: () => _comingSoon(context, 'New order'),
                    ),
                    GoToItem(
                      icon: Icons.storefront_outlined,
                      title: 'Shops',
                      subtitle: 'Shops on your beats',
                      onTap: () => context.go(Routes.shops),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _comingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$feature is coming soon')));
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              message,
              style: AppTextStyles.secondary,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            TextButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
