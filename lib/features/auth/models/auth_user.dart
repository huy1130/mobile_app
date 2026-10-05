class AuthUser {
  final String userId;
  final String email;
  final String fullName;
  final String actorRole;
  final String? phoneNumber;
  final String? avatarUrl;
  final Map<String, dynamic>? additionalProfile;

  AuthUser({
    required this.userId,
    required this.email,
    required this.fullName,
    required this.actorRole,
    this.phoneNumber,
    this.avatarUrl,
    this.additionalProfile,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      userId: json['userId'] ?? json['id'] ?? '',
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      actorRole: json['actorRole'] ?? json['role'] ?? 'PATIENT',
      phoneNumber: json['phoneNumber'],
      avatarUrl: json['avatarUrl'],
      additionalProfile: json['additionalProfile'] is Map<String, dynamic>
          ? json['additionalProfile'] as Map<String, dynamic>
          : null,
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
      if (additionalProfile != null) 'additionalProfile': additionalProfile,
    };
  }
}
