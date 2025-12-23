import 'package:notes_tasks/modules/users/domain/entities/user_entity.dart';

abstract class IGetUserFullRepo {
  Future<UserEntity> getUserFull(int id);
}