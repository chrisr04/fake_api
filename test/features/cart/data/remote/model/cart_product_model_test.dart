import 'package:fake_api/fake_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CartProductModel', () {
    test('fromJson creates an instance from a JSON object', () {
      final json = {
        'productId': 1,
        'quantity': 2,
        'title': 'Product Title',
        'price': 9.99,
        'image': 'image_url',
      };

      final cartProduct = CartProductModel.fromJson(json);

      expect(cartProduct.productId, 1);
      expect(cartProduct.quantity, 2);
      expect(cartProduct.title, 'Product Title');
      expect(cartProduct.price, 9.99);
      expect(cartProduct.image, 'image_url');
    });

    test('fromDomain creates an instance from a CartProductEntity', () {
      const cartProductEntity = CartProductEntity(
        productId: 1,
        quantity: 2,
        title: 'Product Title',
        price: 9.99,
        image: 'image_url',
      );

      final cartProduct = CartProductModel.fromDomain(cartProductEntity);

      expect(cartProduct.productId, 1);
      expect(cartProduct.quantity, 2);
      expect(cartProduct.title, 'Product Title');
      expect(cartProduct.price, 9.99);
      expect(cartProduct.image, 'image_url');
    });

    test('toMap converts an instance to a map', () {
      final cartProduct = CartProductModel(
        productId: 1,
        quantity: 2,
        title: 'Product Title',
        price: 9.99,
        image: 'image_url',
      );

      final map = cartProduct.toMap();

      expect(map, {
        'productId': 1,
        'quantity': 2,
        'title': 'Product Title',
        'price': 9.99,
        'image': 'image_url',
      });
    });
  });
}
