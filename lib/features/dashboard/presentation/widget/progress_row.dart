import 'package:flutter/material.dart';
import 'package:jivodsr/core/theme/app_colors.dart';
import 'package:jivodsr/core/theme/app_text_styles.dart';
import 'package:jivodsr/core/widgets/status_pill.dart';

class ProgressRow extends StatelessWidget {
  const ProgressRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
  });

  final String title;
  final String subtitle;
  final double progress; // 0.0 – 1.0

  static const double _behindBelow = 0.25;

  @override
  Widget build(BuildContext context) {
    
    final isBehind = progress < _behindBelow;
    final percent = (progress * 100).round();

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.label),
                    const SizedBox(height: 2),
                    Text(subtitle, style: AppTextStyles.caption),
                  ],
                ),
              ),
              isBehind
                  ? const StatusPill(
                      label: 'Behind',
                      icon: Icons.schedule,
                      tone: PillTone.warn,
                    )
                  : StatusPill(
                      label: '$percent%',
                      icon: Icons.check_circle_outline,
                    ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
            color: isBehind ? AppColors.barLow : AppColors.barFill,
          ),
        ],
      ),
    );
  }
}
