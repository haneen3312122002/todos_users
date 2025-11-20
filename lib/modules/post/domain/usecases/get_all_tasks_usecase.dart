import 'package:notes_tasks/modules/post/domain/entities/post_entity.dart';
import 'package:notes_tasks/modules/post/domain/repositories/posts_repo.dart';

class GetAllPostsUseCase {
  final IGetAllPostsRepo repo;

  GetAllPostsUseCase(this.repo);

  Future<List<PostEntity>> call({
    required int page,
    required int limit,
  }) {
    return repo.getAllPosts(page: page, limit: limit);
  }
}
