import 'package:notes_tasks/core/features/job/service/jobs_service.dart';
import 'package:notes_tasks/modules/job/domain/entities/job_entity.dart';

class GetJobsByCategoryUseCase {
  final JobsService _service;
  GetJobsByCategoryUseCase(this._service);

  Stream<List<JobEntity>> call({required String category}) {
    return _service.watchJobsByCategory(category);
  }
}
