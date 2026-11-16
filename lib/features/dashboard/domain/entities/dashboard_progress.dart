import 'dart:math';

import 'package:jivodsr/features/dashboard/domain/entities/user_details.dart';

enum ProgressPeriod {
  today('Today'),
  month('This month');

  const ProgressPeriod(this.label);

  final String label;
}

class DashboardProgress {
  const DashboardProgress({
    required this.period,
    required this.shopsCovered,
    required this.shopsPlanned,
    required this.productiveCalls,
    this.target,
    this.productiveTarget,
    this.dayOfMonth,
    this.daysInMonth,
  });

  /// Month-to-date progress, built from the /userDetails response.
  factory DashboardProgress.monthFrom(UserDetails details) {
    final now = DateTime.now();
    final month = details.targetMonth ?? DateTime(now.year, now.month);
    final upTo = details.toDate ?? now;

    return DashboardProgress(
      period: ProgressPeriod.month,
      shopsCovered: details.shopsCovered ?? 0,
      shopsPlanned: details.assignedShops ?? 0,
      productiveCalls: details.shopsProductive ?? 0,
      dayOfMonth: upTo.day,
      daysInMonth: DateTime(month.year, month.month + 1, 0).day,
    );
  }

  final ProgressPeriod period;

  /// Sales target in ₹. null when the API doesn't send one.
  final num? target;

  final int shopsCovered;

  /// Today: shops on today's beat. Month: all assigned shops.
  final int shopsPlanned;

  final int productiveCalls;

  /// null when the API doesn't send one.
  final int? productiveTarget;

  /// Month only — used to work out the pace. null for today.
  final int? dayOfMonth;
  final int? daysInMonth;

  /// 0.0 – 1.0
  double get coverage => shopsPlanned == 0
      ? 0
      : (shopsCovered / shopsPlanned).clamp(0.0, 1.0).toDouble();

  /// 0.0 – 1.0, or null when there is no target to compare against.
  double? get productiveProgress {
    final t = productiveTarget;
    if (t == null) return null;
    return t == 0 ? 0 : (productiveCalls / t).clamp(0.0, 1.0).toDouble();
  }

  int get shopsLeft => max(0, shopsPlanned - shopsCovered);

  /// null when there is no target.
  int? get productiveLeft {
    final t = productiveTarget;
    return t == null ? null : max(0, t - productiveCalls);
  }

  /// Where [soFar] will end up by month end at the current daily pace.
  /// e.g. 102 shops by day 22 of 31 → 144. null for today.
  int? projected(int soFar) {
    final day = dayOfMonth;
    final days = daysInMonth;
    if (day == null || days == null || day == 0) return null;
    return (soFar / day * days).round();
  }
}
