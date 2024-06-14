import 'package:fake_api/features/cart/domain/domain.dart';

class CartProductModel extends CartProductEntity {
  CartProductModel({
    required super.productId,
    required super.quantity,
    required super.title,
    required super.price,
    required super.image,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) =>
      CartProductModel(
        productId: json['productId'] ?? 0,
        quantity: json['quantity'] ?? 0,
        title: json['title'] ?? '',
        price: json['price']?.toDouble() ?? 0.0,
        image: json['image'] ?? '',
      );

  factory CartProductModel.fromDomain(CartProductEntity cartProduct) =>
      CartProductModel(
        productId: cartProduct.productId,
        quantity: cartProduct.quantity,
        title: cartProduct.title,
        price: cartProduct.price,
        image: cartProduct.image,
      );

  Map<String, dynamic> toMap() => {
        'productId': productId,
        'quantity': quantity,
        'title': title,
        'price': price,
        'image': image,
      };
}
