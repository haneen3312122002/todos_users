import 'package:notes_tasks/modules/auth/domain/repositories/get_auth_user_repo.dart';
import 'package:notes_tasks/modules/users/domain/entities/user_entity.dart';

class GetAuthUserUseCase {
  final IGetAuthUserRepo repo;

  GetAuthUserUseCase(this.repo);

  Future<UserEntity> call(String token) async {
    return await repo.getAuthUser(token);
  }
}
