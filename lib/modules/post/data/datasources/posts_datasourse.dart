import 'package:notes_tasks/modules/post/api/get_all_posts_api/i_get_all_posts_api_service.dart';
import 'package:notes_tasks/modules/post/data/models/post_model.dart';

abstract class IGetAllPostsRemoteDataSource {
  Future<List<PostModel>> getAllPosts({
    required int page,
    required int limit,
  });
}

class GetAllPostsRemoteDataSource implements IGetAllPostsRemoteDataSource {
  final IGetAllPostsApiService api;

  GetAllPostsRemoteDataSource(this.api);

  @override
  Future<List<PostModel>> getAllPosts({
    required int page,
    required int limit,
  }) async {
    final data = await api.getAllPosts(page: page, limit: limit);
    final List posts = data['posts'] ?? [];
    return posts.map((e) => PostModel.fromMap(e)).toList();
  }
}
