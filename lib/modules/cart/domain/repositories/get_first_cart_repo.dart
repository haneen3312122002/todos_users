import 'package:notes_tasks/modules/cart/domain/entities/cart_entity.dart';

abstract class IGetFirstCartRepo {
  Future<CartEntity> getFirstCart();
}