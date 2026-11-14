import 'dart:math';

enum ProgressPeriod {
  today('Today'),
  month('This month');

  const ProgressPeriod(this.label);

  final String label;
}

class DashboardProgress {
  const DashboardProgress({
    required this.period,
    required this.target,
    required this.shopsCovered,
    required this.shopsPlanned,
    required this.productiveCalls,
    required this.productiveTarget,
    this.dayOfMonth,
    this.daysInMonth,
  });

  final ProgressPeriod period;

  /// Sales target in ₹ for this period.
  final num target;

  final int shopsCovered;

  /// Today: shops on today's beat. Month: all assigned shops.
  final int shopsPlanned;

  final int productiveCalls;
  final int productiveTarget;

  /// Month only — used to work out the pace. null for today.
  final int? dayOfMonth;
  final int? daysInMonth;

  /// 0.0 – 1.0
  double get coverage => shopsPlanned == 0
      ? 0
      : (shopsCovered / shopsPlanned).clamp(0.0, 1.0).toDouble();

  /// 0.0 – 1.0
  double get productiveProgress => productiveTarget == 0
      ? 0
      : (productiveCalls / productiveTarget).clamp(0.0, 1.0).toDouble();

  int get shopsLeft => max(0, shopsPlanned - shopsCovered);

  int get productiveLeft => max(0, productiveTarget - productiveCalls);

  /// Where [soFar] will end up by month end at the current daily pace.
  /// e.g. 102 shops by day 22 of 31 → 144. null for today.
  int? projected(int soFar) {
    final day = dayOfMonth;
    final days = daysInMonth;
    if (day == null || days == null || day == 0) return null;
    return (soFar / day * days).round();
  }
}
