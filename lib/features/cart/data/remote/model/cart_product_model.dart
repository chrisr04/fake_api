import 'package:fake_api/features/cart/domain/domain.dart';

class CartProductModel extends CartProductEntity {
  CartProductModel({
    required super.productId,
    required super.quantity,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) =>
      CartProductModel(
        productId: json['productId'] ?? 0,
        quantity: json['quantity'] ?? 0,
      );

  factory CartProductModel.fromDomain(CartProductEntity cartProduct) =>
      CartProductModel(
        productId: cartProduct.productId,
        quantity: cartProduct.quantity,
      );

  Map<String, dynamic> toMap() => {
        'productId': productId,
        'quantity': quantity,
      };
}
