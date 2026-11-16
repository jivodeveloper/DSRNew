import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jivodsr/core/theme/app_colors.dart';
import 'package:jivodsr/core/theme/app_text_styles.dart';
import 'package:jivodsr/core/utils/extensions.dart';
import 'package:jivodsr/core/widgets/status_pill.dart';
import 'package:jivodsr/features/attendance/presentation/providers/attendance_providers.dart';
import 'package:jivodsr/features/attendance/presentation/widgets/attendance_status_style.dart';
import 'package:jivodsr/features/dashboard/domain/entities/user_details.dart';

class ProfileCard extends ConsumerWidget {
  const ProfileCard({super.key, required this.details});

  final UserDetails details;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Today's attendance pill, or null while loading / on error
    // so we never flash a wrong status.
    final todayPill = ref
        .watch(attendanceMonthProvider)
        .when<Widget?>(
          data: (month) =>
              month.dayFor(DateTime.now())?.status?.pill ??
              const StatusPill(
                label: 'Not marked',
                icon: Icons.schedule,
                tone: PillTone.warn,
              ),
          loading: () => null,
          error: (_, _) => null,
        );

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateTime.now().dMMMy, style: AppTextStyles.secondary),
            const SizedBox(height: 6),
            Row(
              children: [
                Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: AppColors.dot,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    details.name,
                    style: AppTextStyles.personName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (todayPill != null) ...[const SizedBox(width: 8), todayPill],
              ],
            ),
            const SizedBox(height: 6),
            Text.rich(
              TextSpan(
                style: AppTextStyles.secondary,
                children: [
                  const TextSpan(text: 'Organisation: '),
                  TextSpan(
                    text: details.organizationName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
