import 'package:flutter/material.dart';
import 'package:jivodsr/core/theme/app_colors.dart';
import 'package:jivodsr/core/theme/app_text_styles.dart';
import 'package:jivodsr/core/utils/extensions.dart';
import 'package:jivodsr/features/dashboard/domain/entities/user_details.dart';
import 'package:jivodsr/features/dashboard/presentation/widget/progress_row.dart';

class ProgressCard extends StatelessWidget {
  
  const ProgressCard({super.key, required this.details});

  final UserDetails details;
  
  @override
  Widget build(BuildContext context) {

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.trending_up, size: 20, color: AppColors.violet),
                const SizedBox(width: 8),
                Text("Today's progress", style: AppTextStyles.cardTitle),
              ],
            ),
            const SizedBox(height: 12),

            // Inner bordered list (like HO's "SAP sync" card)
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Target', style: AppTextStyles.secondary),
                        ),
                        Text(details.target.inr, style: AppTextStyles.bigNumber),
                      ],
                    ),
                  ),
                  const Divider(),
                  ProgressRow(
                    title: 'Shops covered',
                    subtitle:
                        '${details.shopsCovered} of ${details.assignedShops} · ${details.shopsLeft} left',
                    progress: details.coverageProgress,
                  ),
                  const Divider(),
                  ProgressRow(
                    title: 'Productive calls',
                    subtitle:
                        '${details.shopsProductive} of ${details.productiveTarget} · ${details.productiveLeft} to go',
                    progress: details.productiveProgress,
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
