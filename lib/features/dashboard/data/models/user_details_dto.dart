import 'package:jivodsr/features/dashboard/domain/entities/user_details.dart';

class UserDetailsDto {
  const UserDetailsDto({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phone,
    required this.userType,
    required this.organization,
    required this.organizationName,
    required this.isSuperuser,
    required this.permissions,
  });

  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String? phone;
  final String userType;
  final int organization;
  final String organizationName;
  final bool isSuperuser;
  final Map<String, ModulePermission> permissions;

  factory UserDetailsDto.fromJson(Map<String, dynamic> json) {
    final permissionsJson = json['permissions'] as Map<String, dynamic>? ?? {};

    return UserDetailsDto(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      email: json['email'] as String? ?? '',
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      phone: json['phone'] as String?,
      userType: json['user_type'] as String,
      organization: (json['organization'] as num).toInt(),
      organizationName: json['organization_name'] as String,
      isSuperuser: json['isSuperuser'] as bool? ?? false,
      permissions: Map.unmodifiable(
        permissionsJson.map(
          (key, value) => MapEntry(
            key,
            ModulePermission.fromJson(value as Map<String, dynamic>),
          ),
        ),
      ),
    );
  }

  UserDetails toEntity() {
    return UserDetails(
      id: id,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      userType: userType,
      organization: organization,
      organizationName: organizationName,
      isSuperuser: isSuperuser,
      permissions: permissions,
    );
  }
}
