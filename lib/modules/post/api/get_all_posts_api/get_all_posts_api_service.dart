import 'package:notes_tasks/core/constants/endpoints.dart';
import 'package:notes_tasks/core/services/api/api_service.dart';
import 'i_get_all_posts_api_service.dart';

class GetAllPostsApiService implements IGetAllPostsApiService {
  @override
  Future<Map<String, dynamic>> getAllPosts({
    required int page,
    required int limit,
  }) async {
    final skip = (page - 1) * limit;

    final url = '${AppEndpoints.posts}?limit=$limit&skip=$skip';
    return await ApiService.get(url);
  }
}
