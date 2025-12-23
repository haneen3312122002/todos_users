import 'package:notes_tasks/modules/users/domain/entities/user_entity.dart';

abstract class IGetBasicUsersRepo {
  Future<List<UserEntity>> getBasicUsers();
}