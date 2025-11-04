import 'package:notes_tasks/modules/task/api/add_task/i_add_task_api_service.dart';
import 'package:notes_tasks/modules/task/data/models/task_model.dart';

abstract class IAddTaskRemoteDataSource {
  Future<TaskModel> addTask({
    required String todo,
    required bool completed,
    required int userId,
  });
}

class AddTaskRemoteDataSource implements IAddTaskRemoteDataSource {
  final IAddTaskApiService api;

  AddTaskRemoteDataSource(this.api);

  @override
  Future<TaskModel> addTask({
    required String todo,
    required bool completed,
    required int userId,
  }) async {
    final data = await api.addTask(
      todo: todo,
      completed: completed,
      userId: userId,
    );
    return TaskModel.fromMap(data);
  }
}
