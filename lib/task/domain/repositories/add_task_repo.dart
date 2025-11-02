import 'package:notes_tasks/task/domain/entities/task_entity.dart';

abstract class IAddTaskRepo {
  Future<TaskEntity> addTask({
    required String todo,
    required bool completed,
    required int userId,
  });
}
