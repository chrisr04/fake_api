import 'package:test/test.dart';
import 'package:fake_api/fake_api.dart';

void main() {
  group('ProductModel', () {
    test('fromJson should correctly parse JSON', () {
      final Map<String, dynamic> json = {
        'id': 1,
        'title': 'Sample Product',
        'price': 19.99,
        'description': 'A sample product description.',
        'category': 'Sample Category',
        'image': 'sample_product.jpg',
        'rating': {
          'rate': 4.0,
          'count': 10,
        },
      };

      final product = ProductModel.fromJson(json);

      expect(product.id, 1);
      expect(product.title, 'Sample Product');
      expect(product.price, 19.99);
      expect(product.description, 'A sample product description.');
      expect(product.category, 'Sample Category');
      expect(product.image, 'sample_product.jpg');
      expect(product.rating.rate, 4);
      expect(product.rating.count, 10);
    });
  });
}
