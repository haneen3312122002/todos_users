import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/core/features/job/service/job_provider.dart';
import 'package:notes_tasks/modules/job/domain/entities/job_entity.dart';

final jobByIdStreamProvider =
    StreamProvider.family<JobEntity?, String>((ref, jobId) {
  final service = ref.read(jobsServiceProvider);
  return service.watchJobById(jobId);
});
