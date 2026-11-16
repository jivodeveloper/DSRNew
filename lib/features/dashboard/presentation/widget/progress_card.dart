import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jivodsr/core/theme/app_colors.dart';
import 'package:jivodsr/core/theme/app_text_styles.dart';
import 'package:jivodsr/core/utils/extensions.dart';
import 'package:jivodsr/core/widgets/segmented_switch.dart';
import 'package:jivodsr/features/dashboard/domain/entities/dashboard_progress.dart';
import 'package:jivodsr/features/dashboard/presentation/providers/dashboard_provider.dart';
import 'package:jivodsr/features/dashboard/presentation/widget/progress_row.dart';

class ProgressCard extends ConsumerStatefulWidget {
  const ProgressCard({super.key});

  @override
  ConsumerState<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends ConsumerState<ProgressCard> {
  ProgressPeriod _period = ProgressPeriod.today;

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(dashboardProgressProvider(_period));

    final title = _period == ProgressPeriod.today
        ? "Today's progress"
        : '${DateTime.now().monthName} progress';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.trending_up,
                  size: 20,
                  color: AppColors.violet,
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(title, style: AppTextStyles.cardTitle)),
                TextButton.icon(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Details are coming soon')),
                  ),
                  icon: const Icon(Icons.arrow_forward, size: 17),
                  label: const Text('Details'),
                  iconAlignment: IconAlignment.end,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.activeFg,
                    textStyle: AppTextStyles.label,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            SegmentedSwitch<ProgressPeriod>(
              options: {
                for (final period in ProgressPeriod.values)
                  period: period.label,
              },
              selected: _period,
              onChanged: (period) => setState(() => _period = period),
            ),
            const SizedBox(height: 12),
            progress.when(
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, _) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  'Could not load progress.',
                  style: AppTextStyles.secondary,
                  textAlign: TextAlign.center,
                ),
              ),
              data: (data) => _ProgressRows(progress: data),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressRows extends StatelessWidget {
  const _ProgressRows({required this.progress});

  final DashboardProgress progress;

  @override
  Widget build(BuildContext context) {
    final p = progress;
    final isToday = p.period == ProgressPeriod.today;
    final target = p.target;
    final projectedShops = p.projected(p.shopsCovered);
    final projectedCalls = p.projected(p.productiveCalls);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Only when the API sends a ₹ target.
          if (target != null) ...[
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      isToday ? "Today's target" : 'Monthly target',
                      style: AppTextStyles.secondary,
                    ),
                  ),
                  Text(target.inr, style: AppTextStyles.bigNumber),
                ],
              ),
            ),
            const Divider(),
          ],
          ProgressRow(
            title: 'Shops covered',
            subtitle: isToday
                ? "${p.shopsCovered} of ${p.shopsPlanned} on today's beat · ${p.shopsLeft} left"
                : '${p.shopsCovered} of ${p.shopsPlanned} · ${p.shopsLeft} left',
            progress: p.coverage,
          ),
          const Divider(),
          ProgressRow(
            title: 'Productive calls',
            subtitle: p.productiveTarget == null
                ? '${p.productiveCalls} so far'
                : '${p.productiveCalls} of ${p.productiveTarget} · ${p.productiveLeft} to go',
            progress: p.productiveProgress,
          ),
          // Month only: where they'll end up at the current pace.
          if (projectedShops != null && projectedCalls != null) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.speed, size: 16, color: AppColors.textMuted),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Day ${p.dayOfMonth} of ${p.daysInMonth} · at this pace: '
                      '$projectedShops shops, $projectedCalls productive calls',
                      style: AppTextStyles.caption,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
