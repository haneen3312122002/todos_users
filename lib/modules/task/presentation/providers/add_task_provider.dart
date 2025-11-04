import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/modules/task/api/add_task/add_task_api_service.dart';
import 'package:notes_tasks/modules/task/api/add_task/i_add_task_api_service.dart';
import 'package:notes_tasks/modules/task/data/datasources/add_task_remote_datasource.dart';
import 'package:notes_tasks/modules/task/data/repositories/add_task_repo_impl.dart';
import 'package:notes_tasks/modules/task/domain/repositories/add_task_repo.dart';
import 'package:notes_tasks/modules/task/domain/usecases/add_task_usecase.dart';

final addTaskApiServiceProvider = Provider<IAddTaskApiService>((ref) {
  return AddTaskApiService();
});

final addTaskDataSourceProvider = Provider<IAddTaskRemoteDataSource>((ref) {
  final api = ref.read(addTaskApiServiceProvider);
  return AddTaskRemoteDataSource(api);
});

final addTaskRepoProvider = Provider<IAddTaskRepo>((ref) {
  final ds = ref.read(addTaskDataSourceProvider);
  return AddTaskRepoImpl(ds);
});

final addTaskUseCaseProvider = Provider<AddTaskUseCase>((ref) {
  final repo = ref.read(addTaskRepoProvider);
  return AddTaskUseCase(repo);
});
