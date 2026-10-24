import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jivodsr/core/error/app_exception.dart';
import 'package:jivodsr/features/attendance/domain/entities/attendance_day.dart';
import 'package:jivodsr/features/attendance/domain/entities/attendance_month.dart';
import 'package:jivodsr/features/attendance/domain/entities/attendance_status.dart';
import 'package:jivodsr/features/auth/presentation/providers/auth_controller.dart';
import 'package:jivodsr/features/auth/presentation/providers/auth_providers.dart';

final attendanceMonthProvider = FutureProvider.autoDispose<AttendanceMonth>((ref) async {

  final authStatus = ref.watch(authControllerProvider);
  if (authStatus != AuthStatus.authenticated) {
    throw const UnauthorizedException();
  }

  await Future.delayed(const Duration(milliseconds: 600)); 
  return _fakeMonth(DateTime.now());

});

AttendanceMonth _fakeMonth(DateTime now) {

  final days = <AttendanceDay>[]; 

  for (var d = 1; d <= now.day; d++) {

    final date = DateTime(now.year, now.month, d);

    final AttendanceStatus status;
    if (date.weekday == DateTime.sunday) {
      status = AttendanceStatus.weekOff;
    } else if (d == 7 || d == 15) {
      status = AttendanceStatus.absent;
    } else if (d == 9 || d == 17) {
      status = AttendanceStatus.halfDay;
    } else {
      status = AttendanceStatus.present;
    }
    
    final worked = status == AttendanceStatus.present ||
        status == AttendanceStatus.halfDay;

    final isToday = d == now.day;
    final outHour = status == AttendanceStatus.halfDay ? 13 : 18;

    days.add(
      AttendanceDay(
        date: date,
        status: status,
        punchIn: worked ? DateTime(now.year, now.month, d, 9, 41) : null,
        punchOut: worked && !isToday
            ? DateTime(now.year, now.month, d, outHour, 5)
            : null,
      ),
    );

  }

  return AttendanceMonth(year: now.year, month: now.month, days: days);
}
