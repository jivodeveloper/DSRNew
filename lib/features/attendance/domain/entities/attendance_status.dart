enum AttendanceStatus {
  
  present('P', 'Present'),
  halfDay('HD', 'Half day'),
  absent('A', 'Absent'),
  weekOff('WO', 'Week off'),
  holiday('H', 'Holiday');

  final String code;
  final String label;

  const AttendanceStatus(this.code, this.label);
  
  bool get isWorkingDay => this ==present || this == halfDay || this == absent;

}

// enum Color { red, green }
