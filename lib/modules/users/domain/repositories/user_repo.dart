import 'package:notes_tasks/modules/users/domain/entities/user_entity.dart';

abstract class UserRepo {
  Future<List<UserEntity>> getBasicUsers();

  Future<UserEntity> getUserFull(int id);

  Future<BankEntity> getUserBank(int id);

  Future<CompanyEntity> getUserCompany(int id);

  Future<CryptoEntity> getUserCrypto(int id);

  Future<AddressEntity> getUserAddress(int id);
}