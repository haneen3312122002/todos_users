import 'package:notes_tasks/modules/auth/data/models/auth_model.dart';

abstract class IRefreshTokenApiService {
  Future<AuthModel> refreshToken(String refreshToken);
}
