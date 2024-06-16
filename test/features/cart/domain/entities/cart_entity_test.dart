import 'package:fake_api/fake_api.dart';
import 'package:test/test.dart';

void main() {
  group('CartEntity', () {
    test('should create an instance with given parameters', () {
      const cartProduct1 = CartProductEntity(
        productId: 1,
        quantity: 2,
        title: 'Product 1',
        price: 20.0,
        image: 'https://example.com/test_image.jpg',
      );
      const cartProduct2 = CartProductEntity(
        productId: 2,
        quantity: 5,
        title: 'Product 2',
        price: 10.0,
        image: 'https://example.com/test_image.jpg',
      );

      final cart = CartEntity(
        id: 123,
        userId: 456,
        date: DateTime(2023, 6, 15),
        products: [cartProduct1, cartProduct2],
      );

      expect(cart.id, 123);
      expect(cart.userId, 456);
      expect(cart.date, DateTime(2023, 6, 15));
      expect(cart.products.length, 2);
      expect(cart.products[0], cartProduct1);
      expect(cart.products[1], cartProduct2);
    });
  });
}
