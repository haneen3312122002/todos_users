abstract class IAddTaskApiService {
  Future<Map<String, dynamic>> addTask({
    required String todo,
    required bool completed,
    required int userId,
  });
}
