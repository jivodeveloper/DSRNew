import 'package:jivodsr/features/attendance/domain/entities/attendance_day.dart';
import 'package:jivodsr/features/attendance/domain/entities/attendance_status.dart';

class AttendanceMonth {
  const AttendanceMonth({
    required this.year,
    required this.month,
    required this.days,
  });

  final int year;
  final int month;
  final List<AttendanceDay> days;

  int _count(AttendanceStatus status) =>
      days.where((d) => d.status == status).length;

  int get presentCount => _count(AttendanceStatus.present);
  int get halfDayCount => _count(AttendanceStatus.halfDay);
  int get absentCount => _count(AttendanceStatus.absent);
  int get offCount =>
      _count(AttendanceStatus.weekOff) + _count(AttendanceStatus.holiday);

  int get workingDays => presentCount + halfDayCount + absentCount;

  /// 0.0 – 1.0. A half day counts as ½.
  double get percentage => workingDays == 0
      ? 0
      : (presentCount + halfDayCount * 0.5) / workingDays;

  AttendanceDay? dayFor(DateTime date) => days
      .where((d) =>
          d.date.year == date.year &&
          d.date.month == date.month &&
          d.date.day == date.day)
      .firstOrNull;
}
