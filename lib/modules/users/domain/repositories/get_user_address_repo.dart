import 'package:notes_tasks/modules/users/domain/entities/user_entity.dart';

abstract class IGetUserAddressRepo {
  Future<AddressEntity> getUserAddress(int id);
}