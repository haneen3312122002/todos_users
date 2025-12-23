import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_tasks/core/shared/enums/role.dart';
import 'package:notes_tasks/modules/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel(
      {required super.uid,
      required super.name,
      required super.email,
      super.photoUrl,
      super.coverUrl,
      required super.role,
      super.skills = const [],
      super.bio});

  factory ProfileModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    final role = parseUserRole(data['role'] as String?);

    return ProfileModel(
        uid: doc.id,
        name: data['name'] as String? ?? '',
        email: data['email'] as String? ?? '',
        photoUrl: data['photoUrl'] as String?,
        coverUrl: data['coverUrl'] as String?,
        role: role,
        skills: (data['skills'] as List<dynamic>? ?? [])
            .map((e) => e.toString())
            .toList(),
        bio: data['bio'] as String? ?? 'your bio');
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'coverUrl': coverUrl,
      'role': role,
      'skills': skills,
      'bio': bio
    };
  }
}
