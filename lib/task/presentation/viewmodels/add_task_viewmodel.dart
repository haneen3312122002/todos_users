import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/task/domain/entities/task_entity.dart';
import 'package:notes_tasks/task/domain/usecases/add_task_usecase.dart';
import 'package:notes_tasks/task/presentation/providers/add_task_provider.dart';

final addTaskViewModelProvider =
    AsyncNotifierProvider<AddTaskViewModel, TaskEntity?>(AddTaskViewModel.new);

class AddTaskViewModel extends AsyncNotifier<TaskEntity?> {
  late final AddTaskUseCase _addTaskUseCase = ref.read(addTaskUseCaseProvider);

  @override
  FutureOr<TaskEntity?> build() async => null;

  Future<void> addTask({
    required String todo,
    required bool completed,
    required int userId,
  }) async {
    state = const AsyncLoading();
    try {
      final task = await _addTaskUseCase(
        todo: todo,
        completed: completed,
        userId: userId,
      );
      state = AsyncData(task);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
