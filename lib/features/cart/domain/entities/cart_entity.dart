import 'package:fake_api/features/cart/domain/entities/cart_product_entity.dart';

class CartEntity {
  const CartEntity({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  final int id;
  final int userId;
  final DateTime date;
  final List<CartProductEntity> products;
}
