import 'package:flutter/material.dart';
import 'package:jivodsr/core/theme/app_colors.dart';
import 'package:jivodsr/core/theme/app_text_styles.dart';
import 'package:jivodsr/core/utils/extensions.dart';
import 'package:jivodsr/features/dashboard/domain/entities/user_details.dart';
import 'package:jivodsr/core/widgets/status_pill.dart';

class ProfileCard extends StatelessWidget {

  const ProfileCard({super.key, required this.details});
  final UserDetails details;

  @override
  Widget build(BuildContext context) {
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
                
                const SizedBox(width: 8),
                details.isPresent
                    ? const StatusPill(
                        label: 'Present',
                        icon: Icons.check_circle_outline,
                      )
                    : const StatusPill(
                        label: 'Not marked',
                        icon: Icons.schedule,
                        tone: PillTone.warn,
                      ),

              ],
            ),
            const SizedBox(height: 6),
            Text.rich(
              TextSpan(
                style: AppTextStyles.secondary,
                children: [
                  const TextSpan(text: 'Your role: '),
                  TextSpan(
                    text: details.type ?? '-',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (details.group != null)
                    TextSpan(text: ' · ${details.group}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
