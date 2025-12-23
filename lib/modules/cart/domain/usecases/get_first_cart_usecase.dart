import 'package:notes_tasks/modules/cart/domain/entities/cart_entity.dart';
import 'package:notes_tasks/modules/cart/domain/repositories/get_first_cart_repo.dart';

class GetFirstCartUseCase {
  final IGetFirstCartRepo repo;

  GetFirstCartUseCase(this.repo);

  Future<CartEntity> call() async {
    return await repo.getFirstCart();
  }
}