import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/modules/post/api/get_all_posts_api/get_all_posts_api_service.dart';
import 'package:notes_tasks/modules/post/api/get_all_posts_api/i_get_all_posts_api_service.dart';
import 'package:notes_tasks/modules/post/data/datasources/posts_datasourse.dart';
import 'package:notes_tasks/modules/post/data/repositories/posts_repo_impl.dart';
import 'package:notes_tasks/modules/post/domain/repositories/posts_repo.dart';
import 'package:notes_tasks/modules/post/domain/usecases/get_all_tasks_usecase.dart';

final getAllPostsApiServiceProvider = Provider<IGetAllPostsApiService>((ref) {
  return GetAllPostsApiService();
});

final getAllPostsDataSourceProvider =
    Provider<IGetAllPostsRemoteDataSource>((ref) {
  final api = ref.read(getAllPostsApiServiceProvider);
  return GetAllPostsRemoteDataSource(api);
});

final getAllPostsRepoProvider = Provider<IGetAllPostsRepo>((ref) {
  final ds = ref.read(getAllPostsDataSourceProvider);
  return GetAllPostsRepoImpl(ds);
});

final getAllPostsUseCaseProvider = Provider<GetAllPostsUseCase>((ref) {
  final repo = ref.read(getAllPostsRepoProvider);
  return GetAllPostsUseCase(repo);
});
