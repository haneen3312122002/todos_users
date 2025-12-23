import 'package:notes_tasks/modules/auth/domain/entities/auth_entity.dart';

abstract class IRefreshTokenRepo {
  Future<AuthEntity> refreshToken(String refreshToken);
}