import 'package:notes_tasks/core/constants/endpoints.dart';
import 'package:notes_tasks/core/services/api_service.dart';
import 'package:notes_tasks/users/data/models/user_model.dart';
import 'i_get_auth_user_api_service.dart';

class GetAuthUserApiService implements IGetAuthUserApiService {
  @override
  Future<UserModel> getAuthUser(String token) async {
    final data = await ApiService.get(
      AppEndpoints.getAuthUser,
      headers: {'Authorization': 'Bearer $token'},
    );
    return UserModel.fromMap(data);
  }
}
