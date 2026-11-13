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
    this.fullName = '',
    this.isActive = false,
    this.dateJoined,
    this.updatedAt,
    this.lastLogin,
    this.pagePermissions = const {},
    this.accessAdmin = false,
    this.canManageCatalog = false,
    this.role,
    this.userVisibility = '',
    this.dataScope = '',
    this.permissionCodes = const [],
    this.applicationPermissionCodes = const [],
    this.groups = const [],
    this.enabledFeatures = const [],
    this.accessVersion = 0,
    this.recordScopeFingerprint = '',
    this.personName,
    this.personTypeId,
    this.personType,
    this.groupId,
    this.group,
    this.distanceAllowed,
    this.totalShops,
    this.assignedShops,
    this.shopsCovered,
    this.shopsProductive,
    this.targetMonth,
    this.fromDate,
    this.toDate,
    this.personId,
  });

  final String fullName;
  final bool isActive;
  final DateTime? dateJoined;
  final DateTime? updatedAt;
  final DateTime? lastLogin;
  final Map<String, dynamic> pagePermissions;
  final bool accessAdmin;
  final bool canManageCatalog;
  final Object? role;
  final String userVisibility;
  final String dataScope;
  final List<String> permissionCodes;
  final List<String> applicationPermissionCodes;
  final List<dynamic> groups;
  final List<String> enabledFeatures;
  final int accessVersion;
  final String recordScopeFingerprint;
  final String? personName;
  final int? personTypeId;
  final String? personType;
  final int? groupId;
  final String? group;
  final int? distanceAllowed;
  final int? totalShops;
  final int? assignedShops;
  final int? shopsCovered;
  final int? shopsProductive;
  final DateTime? targetMonth;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int? personId;

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

  String get name {
    if (fullName.trim().isNotEmpty) return fullName.trim();
    if (personName?.trim().isNotEmpty ?? false) return personName!.trim();
    return '$firstName $lastName'.trim();
  }

  // ---- Permissions ----

  /// This app is the mobile app, so "mobile" and "both" permissions apply here.
  static const _appPlatform = 'mobile';

  /// Module keys this user can open in the app, lower-cased,
  /// in the order the API sends them. e.g. [reports, attendance, dashboard, sale]
  List<String> get mobileModules => [
    for (final entry in permissions.entries)
      if ((entry.value.platform == _appPlatform ||
              entry.value.platform == 'both') &&
          (isSuperuser || entry.value.canView))
        entry.key.toLowerCase(),
  ];

  /// The mobile permission for [module] (any letter case), or null if none.
  ModulePermission? permissionFor(String module) {
    for (final entry in permissions.entries) {
      if ((entry.value.platform == _appPlatform ||
              entry.value.platform == 'both') &&
          entry.key.toLowerCase() == module.toLowerCase()) {
        return entry.value;
      }
    }
    return null;
  }

  bool canView(String module) =>
      isSuperuser || (permissionFor(module)?.canView ?? false);

  bool canAdd(String module) =>
      isSuperuser || (permissionFor(module)?.canAdd ?? false);

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    final permissionsJson = json['permissions'] as Map<String, dynamic>? ?? {};

    return UserDetails(
      fullName: json['full_name'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? false,
      dateJoined: json['date_joined'] == null
          ? null
          : DateTime.parse(json['date_joined'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      lastLogin: json['last_login'] == null
          ? null
          : DateTime.parse(json['last_login'] as String),
      pagePermissions: Map<String, dynamic>.unmodifiable(
        json['pagePermissions'] as Map<String, dynamic>? ?? const {},
      ),
      accessAdmin: json['accessAdmin'] as bool? ?? false,
      canManageCatalog: json['canManageCatalog'] as bool? ?? false,
      role: json['role'],
      userVisibility: json['userVisibility'] as String? ?? '',
      dataScope: json['data_scope'] as String? ?? '',
      permissionCodes: List<String>.unmodifiable(
        (json['permissionCodes'] as List?)?.cast<String>() ?? const <String>[],
      ),
      applicationPermissionCodes: List<String>.unmodifiable(
        (json['applicationPermissionCodes'] as List?)?.cast<String>() ??
            const <String>[],
      ),
      groups: List<dynamic>.unmodifiable(json['groups'] as List? ?? const []),
      enabledFeatures: List<String>.unmodifiable(
        (json['enabledFeatures'] as List?)?.cast<String>() ?? const <String>[],
      ),
      accessVersion: (json['access_version'] as num?)?.toInt() ?? 0,
      recordScopeFingerprint: json['recordScopeFingerprint'] as String? ?? '',
      personName: json['personName'] as String?,
      personTypeId: (json['personTypeId'] as num?)?.toInt(),
      personType: json['personType'] as String?,
      groupId: (json['groupId'] as num?)?.toInt(),
      group: json['group'] as String?,
      distanceAllowed: (json['distanceAllowed'] as num?)?.toInt(),
      totalShops: (json['totalShops'] as num?)?.toInt(),
      assignedShops: (json['assignedShops'] as num?)?.toInt(),
      shopsCovered: (json['shopsCovered'] as num?)?.toInt(),
      shopsProductive: (json['shopsProductive'] as num?)?.toInt(),
      targetMonth: json['targetMonth'] == null
          ? null
          : DateTime.parse(json['targetMonth'] as String),
      fromDate: json['fromDate'] == null
          ? null
          : DateTime.parse(json['fromDate'] as String),
      toDate: json['toDate'] == null
          ? null
          : DateTime.parse(json['toDate'] as String),
      personId: (json['personId'] as num?)?.toInt(),
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      email: json['email'] as String? ?? '',
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      phone: json['phone'] as String?,
      userType: json['user_type'] as String? ?? '',
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

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'is_active': isActive,
      'date_joined': dateJoined?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'last_login': lastLogin?.toIso8601String(),
      'pagePermissions': pagePermissions,
      'accessAdmin': accessAdmin,
      'canManageCatalog': canManageCatalog,
      'role': role,
      'userVisibility': userVisibility,
      'data_scope': dataScope,
      'permissionCodes': permissionCodes,
      'applicationPermissionCodes': applicationPermissionCodes,
      'groups': groups,
      'enabledFeatures': enabledFeatures,
      'access_version': accessVersion,
      'recordScopeFingerprint': recordScopeFingerprint,
      'personName': personName,
      'personTypeId': personTypeId,
      'personType': personType,
      'groupId': groupId,
      'group': group,
      'distanceAllowed': distanceAllowed,
      'totalShops': totalShops,
      'assignedShops': assignedShops,
      'shopsCovered': shopsCovered,
      'shopsProductive': shopsProductive,
      'targetMonth': targetMonth?.toIso8601String(),
      'fromDate': fromDate?.toIso8601String(),
      'toDate': toDate?.toIso8601String(),
      'personId': personId,
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
