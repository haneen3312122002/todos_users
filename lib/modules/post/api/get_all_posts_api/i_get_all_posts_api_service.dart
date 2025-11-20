abstract class IGetAllPostsApiService {
  Future<Map<String, dynamic>> getAllPosts(
      {required int page, required int limit});
}
