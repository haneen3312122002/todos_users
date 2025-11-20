import 'package:notes_tasks/modules/post/data/datasources/posts_datasourse.dart';
import 'package:notes_tasks/modules/post/domain/entities/post_entity.dart';
import 'package:notes_tasks/modules/post/domain/repositories/posts_repo.dart';

class GetAllPostsRepoImpl implements IGetAllPostsRepo {
  final IGetAllPostsRemoteDataSource dataSource;

  GetAllPostsRepoImpl(this.dataSource);

  @override
  Future<List<PostEntity>> getAllPosts({
    required int page,
    required int limit,
  }) async {
    final models = await dataSource.getAllPosts(page: page, limit: limit);
    return models.map((e) => e.toEntity()).toList();
  }
}
