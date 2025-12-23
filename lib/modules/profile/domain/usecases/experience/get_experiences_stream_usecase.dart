import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:notes_tasks/core/features/profile/services/profile_provider.dart';
import 'package:notes_tasks/core/features/profile/services/profile_service.dart';
import 'package:notes_tasks/modules/profile/data/models/experience_model.dart';
import 'package:notes_tasks/modules/profile/domain/entities/experience_entity.dart';

final getExperiencesStreamUseCaseProvider =
    Provider<GetExperiencesStreamUseCase>((ref) {
  final profileService = ref.read(profileServiceProvider);
  return GetExperiencesStreamUseCase(profileService);
});

class GetExperiencesStreamUseCase {
  final ProfileService _service;

  GetExperiencesStreamUseCase(this._service);

  Stream<List<ExperienceEntity>> call() {
    return _service.watchExperiences().map(
      (QuerySnapshot<Map<String, dynamic>> snap) {
        return snap.docs
            .map(
              (doc) => ExperienceModel.fromDoc(doc),
            )
            .toList();
      },
    );
  }
}