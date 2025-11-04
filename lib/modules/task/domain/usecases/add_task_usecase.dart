import 'package:notes_tasks/modules/task/domain/entities/task_entity.dart';
import 'package:notes_tasks/modules/task/domain/repositories/add_task_repo.dart';

class AddTaskUseCase {
  final IAddTaskRepo repo;

  AddTaskUseCase(this.repo);

  Future<TaskEntity> call({
    required String todo,
    required bool completed,
    required int userId,
  }) {
    return repo.addTask(todo: todo, completed: completed, userId: userId);
  }
}
