import 'package:jivodsr/features/attendance/domain/entities/attendance_status.dart';

class AttendanceDay {

  const AttendanceDay({
    required this.date,
    this.status,
    this.punchIn,
    this.punchOut,
    this.remark,
  });
  
  final DateTime date;
  final AttendanceStatus? status; 
  final DateTime? punchIn;
  final DateTime? punchOut;
  final String? remark;

  bool get isMarked => status != null;
  bool get isPunchedOut => punchOut != null;

  Duration? get worked {
    final start = punchIn;
    if (start == null) return null;
    return (punchOut ?? DateTime.now()).difference(start);
  }

}