import 'package:jivodsr/features/auth/domain/entities/user.dart';

class UserDto {
  const UserDto({required this.personId, this.personType, this.personName});

  final int personId;
  final String? personType;
  final String? personName;

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      personId: json['personID'] as int? ?? 0,
      personType: json['personType'] as String?,
      personName: json['personName'] as String?,
    );
  }

  User toEntity() {
    return User(id: personId, name: personName ?? '', type: personType);
  }
}
