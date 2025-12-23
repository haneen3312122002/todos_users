enum UserRole { client, freelancer, admin }

UserRole parseUserRole(String? v) {
  switch ((v ?? '').toLowerCase()) {
    case 'client':
      return UserRole.client;
    case 'freelancer':
      return UserRole.freelancer;
    case 'admin':
      return UserRole.admin;
    default:
      return UserRole.freelancer; // خليها زي ما بدك
  }
}

/// 🔥 هذا اللي بدك تخزنيه في Firestore
String userRoleToString(UserRole role) => role.name;

/// ✅ للـ UI (ترجمة label)
extension UserRoleX on UserRole {
  String get labelKey {
    switch (this) {
      case UserRole.client:
        return 'role_client';
      case UserRole.freelancer:
        return 'role_freelancer';
      case UserRole.admin:
        return 'role_admin';
    }
  }
}
