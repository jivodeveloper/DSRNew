import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jivodsr/core/error/app_exception.dart';
import 'package:jivodsr/core/theme/app_text_styles.dart';
import 'package:jivodsr/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:jivodsr/features/dashboard/presentation/widget/profile_card.dart';
import 'package:jivodsr/features/dashboard/presentation/widget/progress_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ref.watch(userDetailsProvider);

    return RefreshIndicator(
      onRefresh: () => ref.refresh(userDetailsProvider.future),
      child: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          userDetails.when(
            loading: () => const Padding(
              padding: EdgeInsets.only(top: 80),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => _ErrorCard(
              message: error is AppException
                  ? error.message
                  : 'Could not load your details.',
              onRetry: () => ref.invalidate(userDetailsProvider),
            ),
            data: (details) => Column(
              children: [
                
                ProfileCard(details: details),
                const SizedBox(height: 12),
                ProgressCard(details: details),
                const SizedBox(height: 12),
                // GoToCard(
                //   items: [
                //     GoToItem(
                //       icon: Icons.fingerprint,
                //       title: 'Attendance',
                //       subtitle: 'Mark in / out',
                //       onTap: () => context.go(Routes.attendance),
                //     ),
                //     GoToItem(
                //       icon: Icons.add,
                //       title: 'New order',
                //       subtitle: 'Orders',
                //       onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(content: Text('Orders are coming soon')),
                //       ),
                //     ),
                //     GoToItem(
                //       icon: Icons.storefront_outlined,
                //       title: 'Shops',
                //       subtitle: '${details.assignedShops} assigned',
                //       onTap: () => context.go(Routes.shops),
                //     ),
                //   ],
                // ),
            
             ],
            ),
          ),
        ],
      ),
    );
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
            Text(message, style: AppTextStyles.secondary, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            TextButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
