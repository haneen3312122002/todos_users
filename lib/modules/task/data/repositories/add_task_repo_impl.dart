import 'package:notes_tasks/modules/task/data/datasources/add_task_remote_datasource.dart';
import 'package:notes_tasks/modules/task/domain/entities/task_entity.dart';
import 'package:notes_tasks/modules/task/domain/repositories/add_task_repo.dart';

class AddTaskRepoImpl implements IAddTaskRepo {
  final IAddTaskRemoteDataSource dataSource;

  AddTaskRepoImpl(this.dataSource);

  @override
  Future<TaskEntity> addTask({
    required String todo,
    required bool completed,
    required int userId,
  }) async {
    final model = await dataSource.addTask(
      todo: todo,
      completed: completed,
      userId: userId,
    );
    return model.toEntity();
  }
}
