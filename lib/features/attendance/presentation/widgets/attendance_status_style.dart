import 'package:flutter/material.dart';
import 'package:jivodsr/core/theme/app_colors.dart';
import 'package:jivodsr/core/widgets/status_pill.dart';
import 'package:jivodsr/features/attendance/domain/entities/attendance_status.dart';

extension AttendanceStatusStyle on AttendanceStatus {

  Color get fg => switch (this) {
    AttendanceStatus.present => AppColors.presentFg,
    AttendanceStatus.halfDay => AppColors.halfDayFg,
    AttendanceStatus.absent => AppColors.absentFg,
    AttendanceStatus.weekOff => AppColors.weekOffFg,
    AttendanceStatus.holiday => AppColors.holidayFg,
  };

  Color get bg => switch (this) {
    AttendanceStatus.present => AppColors.presentBg,
    AttendanceStatus.halfDay => AppColors.halfDayBg,
    AttendanceStatus.absent => AppColors.absentBg,
    AttendanceStatus.weekOff => AppColors.weekOffBg,
    AttendanceStatus.holiday => AppColors.holidayBg,
  };
  
  Color get border => switch (this) {
    AttendanceStatus.present => AppColors.presentBorder,
    AttendanceStatus.halfDay => AppColors.halfDayBorder,
    AttendanceStatus.absent => AppColors.absentBorder,
    AttendanceStatus.weekOff => AppColors.weekOffBorder,
    AttendanceStatus.holiday => AppColors.holidayBorder,
  };

  IconData get icon => switch (this) {
    AttendanceStatus.present => Icons.check_circle_outline,
    AttendanceStatus.halfDay => Icons.contrast,
    AttendanceStatus.absent => Icons.cancel_outlined,
    AttendanceStatus.weekOff => Icons.weekend_outlined,
    AttendanceStatus.holiday => Icons.celebration_outlined,
  };

  /// Ready-made pill, e.g. "✓ Present" in green.
  StatusPill get pill => StatusPill.colored(
    label: label,
    icon: icon,
    fg: fg,
    bg: bg,
    borderColor: border,
  );
}
