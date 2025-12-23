// lib/modules/auth/domain/entities/auth_entity.dart

class AuthEntity {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final bool isEmailVerified;

  /// اختياري (حسب مشروعك) - لو عندك Roles
  final String? role;

  /// اختياري - للـ audit/analytics
  final DateTime? createdAt;

  const AuthEntity({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.isEmailVerified = false,
    this.role,
    this.createdAt,
  });

  AuthEntity copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    bool? isEmailVerified,
    String? role,
    DateTime? createdAt,
  }) {
    return AuthEntity(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'AuthEntity(uid: $uid, email: $email, displayName: $displayName, verified: $isEmailVerified, role: $role)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthEntity &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          email == other.email &&
          displayName == other.displayName &&
          photoUrl == other.photoUrl &&
          isEmailVerified == other.isEmailVerified &&
          role == other.role &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      uid.hashCode ^
      email.hashCode ^
      displayName.hashCode ^
      photoUrl.hashCode ^
      isEmailVerified.hashCode ^
      role.hashCode ^
      createdAt.hashCode;
}
