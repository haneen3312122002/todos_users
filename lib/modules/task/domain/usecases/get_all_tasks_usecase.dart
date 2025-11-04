import 'package:notes_tasks/modules/task/domain/entities/task_entity.dart';
import 'package:notes_tasks/modules/task/domain/repositories/get_all_tasks_repo.dart';

class GetAllTasksUseCase {
  final IGetAllTasksRepo repo;

  GetAllTasksUseCase(this.repo);

  Future<List<TaskEntity>> call() async {
    return await repo.getAllTasks();
  }
}
