import 'package:notes_tasks/modules/users/domain/entities/user_entity.dart';

abstract class IGetAuthUserRepo {
  Future<UserEntity> getAuthUser(String token);
}
