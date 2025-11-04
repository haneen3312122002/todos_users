import 'package:notes_tasks/modules/cart/domain/entities/cart_entity.dart';

abstract class IGetCartByIdRepo {
  Future<CartEntity> getCartById(int id);
}
