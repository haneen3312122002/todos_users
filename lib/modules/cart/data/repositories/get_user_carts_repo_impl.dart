import 'package:notes_tasks/modules/cart/data/datasources/get_user_carts_remote_datasource.dart';
import 'package:notes_tasks/modules/cart/domain/entities/cart_entity.dart';
import 'package:notes_tasks/modules/cart/domain/repositories/get_user_carts_repo.dart';

class GetUserCartsRepoImpl implements IGetUserCartsRepo {
  final IGetUserCartsRemoteDataSource dataSource;

  GetUserCartsRepoImpl(this.dataSource);

  @override
  Future<List<CartEntity>> getUserCarts(int userId) async {
    final models = await dataSource.getUserCarts(userId);
    return models.map((m) => m.toEntity()).toList();
  }
}
