import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/core/features/job/service/job_provider.dart';
import 'package:notes_tasks/modules/job/domain/usecases/add_job_usecase.dart';
import 'package:notes_tasks/modules/job/domain/usecases/delete_job_usecase.dart';
import 'package:notes_tasks/modules/job/domain/usecases/get_jobs_by_category_usecase.dart';
import 'package:notes_tasks/modules/job/domain/usecases/update_job_usecase.dart';
import 'package:notes_tasks/modules/job/domain/usecases/watch_jobs_feed_usecase.dart';
import 'package:notes_tasks/modules/job/domain/usecases/watch_my_jobs_usecase.dart';

final watchJobsFeedUseCaseProvider = Provider<WatchJobsFeedUseCase>((ref) {
  final service = ref.read(jobsServiceProvider);
  return WatchJobsFeedUseCase(service);
});

final watchMyJobsUseCaseProvider = Provider<WatchMyJobsUseCase>((ref) {
  final service = ref.read(jobsServiceProvider);
  return WatchMyJobsUseCase(service);
});

final addJobUseCaseProvider = Provider<AddJobUseCase>((ref) {
  final service = ref.read(jobsServiceProvider);
  return AddJobUseCase(service);
});

final updateJobUseCaseProvider = Provider<UpdateJobUseCase>((ref) {
  final service = ref.read(jobsServiceProvider);
  return UpdateJobUseCase(service);
});

final deleteJobUseCaseProvider = Provider<DeleteJobUseCase>((ref) {
  final service = ref.read(jobsServiceProvider);
  return DeleteJobUseCase(service);
});
final getJobsByCategoryUseCaseProvider =
    Provider<GetJobsByCategoryUseCase>((ref) {
  final service = ref.watch(jobsServiceProvider);
  return GetJobsByCategoryUseCase(service);
});
