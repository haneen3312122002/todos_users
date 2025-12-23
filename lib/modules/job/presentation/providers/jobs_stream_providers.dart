import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/modules/job/domain/entities/job_entity.dart';
import 'package:notes_tasks/modules/job/presentation/providers/job_usecases_providers.dart';

final myJobsStreamProvider = StreamProvider<List<JobEntity>>((ref) {
  final useCase = ref.watch(watchMyJobsUseCaseProvider);
  return useCase();
});

final jobsFeedStreamProvider = StreamProvider<List<JobEntity>>((ref) {
  final useCase = ref.watch(watchJobsFeedUseCaseProvider);
  return useCase();
});
