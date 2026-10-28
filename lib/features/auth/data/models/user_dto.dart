import 'package:jivodsr/features/auth/domain/entities/user.dart';

class UserDto {
  const UserDto({
    required this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.userType,
    this.organizationName,
  });

  final int id;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? userType;
  final String? organizationName;

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: (json['id'] as num?)?.toInt() ?? 0,
      username: json['username'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      userType: json['user_type'] as String?,
      organizationName: json['organization_name'] as String?,
    );
  }

  User toEntity() {
    return User(
      id: id,
      name: '${firstName ?? ''} ${lastName ?? ''}'.trim(),
      type: userType,
      username: username,
    );
  }
}
