import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_tasks/modules/job/domain/entities/job_entity.dart';

class JobModel extends JobEntity {
  const JobModel({
    required super.id,
    required super.clientId, // ✅ NEW
    required super.title,
    required super.description,
    List<String> skills = const [],
    super.imageUrl,
    super.jobUrl,
    super.budget,
    super.deadline,
    super.isOpen = true,
    super.category = '',
  }) : super(skills: skills);

  factory JobModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};

    return JobModel(
      id: doc.id,
      clientId: data['clientId'] as String? ?? '', // ✅ NEW
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      skills:
          (data['skills'] as List<dynamic>? ?? []).map((e) => '$e').toList(),
      imageUrl: data['imageUrl'] as String?,
      jobUrl: data['jobUrl'] as String?,
      budget: (data['budget'] as num?)?.toDouble(),
      deadline: (data['deadline'] as Timestamp?)?.toDate(),
      isOpen: data['isOpen'] as bool? ?? true,
      category: data['category'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMapForCreate({required String clientId}) {
    return {
      'clientId': clientId, // ✅ مهم
      'title': title,
      'description': description,
      'skills': skills,
      'imageUrl': imageUrl,
      'jobUrl': jobUrl,
      'budget': budget,
      'deadline': deadline,
      'isOpen': isOpen,
      'category': category,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': null,
    };
  }

  Map<String, dynamic> toMapForUpdate() {
    return {
      // ✅ ما بنغيّر clientId بالupdate
      'title': title,
      'description': description,
      'skills': skills,
      'imageUrl': imageUrl,
      'jobUrl': jobUrl,
      'budget': budget,
      'deadline': deadline,
      'isOpen': isOpen,
      'category': category,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
