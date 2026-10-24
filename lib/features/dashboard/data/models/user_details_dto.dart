import 'package:jivodsr/features/dashboard/domain/entities/user_details.dart';

class UserDetailsDto {
  const UserDetailsDto({
    required this.personId,
    this.personName,
    this.userName,
    this.personType,
    this.group,
    this.attStatus,
    this.target,
    this.productiveTarget,
    this.visitTarget,
    this.totalShops,
    this.assignedShops,
    this.shopsCovered,
    this.shopsProductive,
    this.distanceAllowed,
    this.startTime,
    this.endTime,
  });

  final int personId;
  final String? personName;
  final String? userName;
  final String? personType;
  final String? group;
  final String? attStatus;
  final num? target;
  final num? productiveTarget;
  final num? visitTarget;
  final num? totalShops;
  final num? assignedShops;
  final num? shopsCovered;
  final num? shopsProductive;
  final num? distanceAllowed;
  final Duration? startTime;
  final Duration? endTime;

  factory UserDetailsDto.fromJson(Map<String, dynamic> json) {
    return UserDetailsDto(
      personId: (json['personID'] as num?)?.toInt() ?? 0,
      personName: json['personName'] as String?,
      userName: json['userName'] as String?,
      personType: json['personType'] as String?,
      group: json['group'] as String?,
      attStatus: json['attStatus'] as String?,
      target: json['target'] as num?,
      productiveTarget: json['productiveTarget'] as num?,
      visitTarget: json['visitTarget'] as num?,
      totalShops: json['totalShops'] as num?,
      assignedShops: json['AssignedShops'] as num?, // capital A in API
      shopsCovered: json['shopsCovered'] as num?,
      shopsProductive: json['shopsProductive'] as num?,
      distanceAllowed: json['distanceAllowed'] as num?,
      startTime: _parseTimeSpan(json['startTime']),
      endTime: _parseTimeSpan(json['endTime']),
    );
  }

  // .NET TimeSpan comes as an object: { "TotalSeconds": 39671, ... }
  static Duration? _parseTimeSpan(Object? value) {
    if (value is! Map<String, dynamic>) return null;
    final seconds = value['TotalSeconds'] as num?;
    return seconds == null ? null : Duration(seconds: seconds.toInt());
  }

  UserDetails toEntity() {
    return UserDetails(
      id: personId,
      name: personName ?? '',
      userName: userName ?? '',
      type: personType,
      group: group,
      attendanceStatus: attStatus,
      target: target?.toDouble() ?? 0,
      productiveTarget: productiveTarget?.toInt() ?? 0,
      visitTarget: visitTarget?.toInt() ?? 0,
      totalShops: totalShops?.toInt() ?? 0,
      assignedShops: assignedShops?.toInt() ?? 0,
      shopsCovered: shopsCovered?.toInt() ?? 0,
      shopsProductive: shopsProductive?.toInt() ?? 0,
      distanceAllowed: distanceAllowed?.toInt() ?? 0,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
