import 'package:test/test.dart';
import 'package:fake_api/fake_api.dart';

void main() {
  group('ProductEntity', () {
    test('should create a ProductEntity instance', () {
      const int id = 1;
      const String title = 'Sample Product';
      const double price = 99.99;
      const String description = 'This is a sample product description.';
      const String category = 'Sample Category';
      const String image = 'sample_image.jpg';
      const rating = RatingEntity(rate: 4.5, count: 20);

      const product = ProductEntity(
        id: id,
        title: title,
        price: price,
        description: description,
        category: category,
        image: image,
        rating: rating,
      );

      expect(product.id, id);
      expect(product.title, title);
      expect(product.price, price);
      expect(product.description, description);
      expect(product.category, category);
      expect(product.image, image);
      expect(product.rating, rating);
    });
  });
}
