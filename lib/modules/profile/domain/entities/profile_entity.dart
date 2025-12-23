import 'package:notes_tasks/core/shared/enums/role.dart';

class ProfileEntity {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final String? coverUrl;
  final UserRole role;
  final List<String> skills;
  final String? bio;

  const ProfileEntity(
      {required this.uid,
      required this.name,
      required this.email,
      this.photoUrl,
      this.coverUrl,
      required this.role,
      this.skills = const [],
      this.bio});
}
