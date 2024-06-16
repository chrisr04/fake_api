import 'package:fake_api/fake_api.dart';
import 'package:test/test.dart';

void main() {
  group('CartProductEntity', () {
    test('should create an instance with given values', () {
      const productId = 1;
      const quantity = 2;
      const title = 'Test Product';
      const price = 9.99;
      const image = 'image_url';

      const cartProductEntity = CartProductEntity(
        productId: productId,
        quantity: quantity,
        title: title,
        price: price,
        image: image,
      );

      expect(cartProductEntity.productId, productId);
      expect(cartProductEntity.quantity, quantity);
      expect(cartProductEntity.title, title);
      expect(cartProductEntity.price, price);
      expect(cartProductEntity.image, image);
    });
  });
}
