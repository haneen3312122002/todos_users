import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_tasks/modules/profile/domain/entities/project_entity.dart';

class ProjectModel extends ProjectEntity {
  const ProjectModel({
    required super.id,
    required super.title,
    required super.description,
    super.tools = const [],
    super.imageUrl,
    super.projectUrl,
    super.createdAt,
    super.updatedAt,
  });

  factory ProjectModel.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? {};

    return ProjectModel(
      id: doc.id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      tools: (data['tools'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      imageUrl: data['imageUrl'] as String?,
      projectUrl: data['projectUrl'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMapForCreate() {
    return {
      'title': title,
      'description': description,
      'tools': tools,
      'imageUrl': imageUrl,
      'projectUrl': projectUrl,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> toMapForUpdate() {
    return {
      'title': title,
      'description': description,
      'tools': tools,
      'imageUrl': imageUrl,
      'projectUrl': projectUrl,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}