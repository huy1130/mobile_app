class AuthUser {
  final String userId;
  final String email;
  final String fullName;
  final String actorRole;
  final String? phoneNumber;
  final String? avatarUrl;

  AuthUser({
    required this.userId,
    required this.email,
    required this.fullName,
    required this.actorRole,
    this.phoneNumber,
    this.avatarUrl,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      userId: json['userId'] ?? json['id'] ?? '',
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      actorRole: json['actorRole'] ?? json['role'] ?? 'PATIENT',
      phoneNumber: json['phoneNumber'],
      avatarUrl: json['avatarUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'fullName': fullName,
      'actorRole': actorRole,
      'phoneNumber': phoneNumber,
      'avatarUrl': avatarUrl,
    };
  }
}
