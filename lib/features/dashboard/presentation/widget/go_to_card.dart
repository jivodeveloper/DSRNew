import 'package:flutter/material.dart';
import 'package:jivodsr/core/theme/app_colors.dart';
import 'package:jivodsr/core/theme/app_text_styles.dart';

class GoToItem {
  const GoToItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
}

class GoToCard extends StatelessWidget {
  const GoToCard({super.key, required this.items});

  final List<GoToItem> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Go to', style: AppTextStyles.cardTitle),
            const SizedBox(height: 10),
            for (final item in items) ...[
              _GoToTile(item: item),
              if (item != items.last) const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }
}

class _GoToTile extends StatelessWidget {
  const _GoToTile({required this.item});

  final GoToItem item;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: AppColors.border),
    );

    return Material(
      color: AppColors.card,
      shape: shape,
      child: InkWell(
        customBorder: shape,
        onTap: item.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          child: Row(
            children: [
              Icon(item.icon, size: 20, color: AppColors.textSecondary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: AppTextStyles.label),
                    Text(item.subtitle, style: AppTextStyles.caption),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward, size: 18, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
