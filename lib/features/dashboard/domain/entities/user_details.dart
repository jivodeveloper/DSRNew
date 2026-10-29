class UserDetails {
  const UserDetails({
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

  String get name => '$firstName $lastName'.trim();

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    final permissionsJson =
        json['permissions'] as Map<String, dynamic>? ?? {};

    return UserDetails(
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
            ModulePermission.fromJson(
              value as Map<String, dynamic>,
            ),
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'user_type': userType,
      'organization': organization,
      'organization_name': organizationName,
      'isSuperuser': isSuperuser,
      'permissions': permissions.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
    };
  }
}




class ModulePermission {
  const ModulePermission({
    required this.platform,
    required this.canView,
    required this.canAdd,
    required this.canEdit,
    required this.canDelete,
    required this.canApprove,
    required this.canExport,
  });

  final String platform;
  final bool canView;
  final bool canAdd;
  final bool canEdit;
  final bool canDelete;
  final bool canApprove;
  final bool canExport;

  factory ModulePermission.fromJson(Map<String, dynamic> json) {
    return ModulePermission(
      platform: json['platform'] as String,
      canView: json['canView'] as bool? ?? false,
      canAdd: json['canAdd'] as bool? ?? false,
      canEdit: json['canEdit'] as bool? ?? false,
      canDelete: json['canDelete'] as bool? ?? false,
      canApprove: json['canApprove'] as bool? ?? false,
      canExport: json['canExport'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'platform': platform,
      'canView': canView,
      'canAdd': canAdd,
      'canEdit': canEdit,
      'canDelete': canDelete,
      'canApprove': canApprove,
      'canExport': canExport,
    };
  }
}