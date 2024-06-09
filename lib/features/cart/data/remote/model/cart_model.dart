import 'package:fake_api/features/cart/domain/domain.dart';
import 'package:fake_api/features/cart/data/remote/model/cart_product_model.dart';

class CartModel extends CartEntity {
  CartModel({
    required super.id,
    required super.userId,
    required super.date,
    required super.products,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json['id'] ?? 0,
        userId: json['userId'] ?? 0,
        date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
        products: List.from(json['products'] ?? [])
            .map((e) => CartProductModel.fromJson(e))
            .toList(),
      );

  factory CartModel.fromDomain(CartEntity cart) => CartModel(
        id: cart.id,
        userId: cart.userId,
        date: cart.date,
        products: cart.products,
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'date': date.toIso8601String(),
        'products': products
            .map((e) => CartProductModel.fromDomain(e).toMap())
            .toList(),
      };
}
