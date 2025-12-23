import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/modules/profile/domain/entities/project_entity.dart';
import 'package:notes_tasks/modules/profile/domain/usecases/prohect/get_projects_stream_usecase.dart';

final projectsStreamProvider = StreamProvider<List<ProjectEntity>>((ref) {
  final usecase = ref.watch(getProjectsStreamUseCaseProvider);
  return usecase();
});