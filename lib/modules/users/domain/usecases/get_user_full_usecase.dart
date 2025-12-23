import 'package:notes_tasks/modules/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/modules/users/domain/repositories/get_user_full_repo.dart';

class GetUserFullUseCase {
  final IGetUserFullRepo repo;

  GetUserFullUseCase(this.repo);

  Future<UserEntity> call(int id) async {
    return await repo.getUserFull(id);
  }
}