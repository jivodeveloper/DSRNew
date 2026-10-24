/// Extension to format a DateTime object into a specific string format
extension DateTimeX on DateTime{

  static const _months = [
    'Janu',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];

  static const _weekdays = [
    'Mond',
    'Tues',
    'Wedn',
    'Thurs',
    'Fri',
    'Sat',
    'Sun'
  ];

  String get dMMMy => '${day.toString().padLeft(2, '0')}-${_months[month - 1]}-$year';

  String get monthShort => _months[month - 1].substring(0, 3);

  String get weekdayShort => _weekdays[weekday - 1].substring(0, 3);

  String get weekdayName => _weekdays[weekday - 1];

  String get monthName => _months[month - 1];

  String get hhmm =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';  
  
}

extension DurationX on Duration{

  String get hm => '${inHours}h ${inMinutes.remainder(60)}m';
  
}

extension RupeeX on num {
  
  String get inr {
    final digits = round().toString();
    if (digits.length <= 3) return '₹$digits';

    final last3 = digits.substring(digits.length - 3);
    var rest = digits.substring(0, digits.length - 3);

    final groups = <String>[];
    while (rest.length > 2) {
      groups.insert(0, rest.substring(rest.length - 2));
      rest = rest.substring(0, rest.length - 2);
    }
    if (rest.isNotEmpty) groups.insert(0, rest);

    return '₹${groups.join(',')},$last3';
  }
}


