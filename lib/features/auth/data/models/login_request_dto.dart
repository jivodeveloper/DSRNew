class LoginResponseDto{

  const LoginResponseDto({
    required this.access,
    required this.refresh,
  });

  final String access;
  final String refresh;

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      access: json['access'] as String? ?? '',
      refresh: json['refresh'] as String? ?? '',
    );
    
  }
  
  bool get isValid => access.isNotEmpty;

}
