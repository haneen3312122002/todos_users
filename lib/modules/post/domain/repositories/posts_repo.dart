import 'package:notes_tasks/modules/post/domain/entities/post_entity.dart';

abstract class IGetAllPostsRepo {
  Future<List<PostEntity>> getAllPosts({
    required int page,
    required int limit,
  });
}
