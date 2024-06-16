import 'package:fake_api/fake_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CartModel', () {
    test('fromJson creates an instance from JSON', () {
      final json = {
        'id': 1,
        'userId': 123,
        'date': '2022-12-01T00:00:00.000Z',
        'products': [
          {
            'productId': 1,
            'quantity': 2,
            'title': 'Product 1',
            'price': 9.99,
            'image': 'image_url',
          },
          {
            'productId': 2,
            'quantity': 3,
            'title': 'Product 2',
            'price': 9.99,
            'image': 'image_url',
          },
        ],
      };

      final cartModel = CartModel.fromJson(json);

      expect(cartModel.id, 1);
      expect(cartModel.userId, 123);
      expect(cartModel.date, DateTime.parse('2022-12-01T00:00:00.000Z'));
      expect(cartModel.products.length, 2);
      expect(cartModel.products[0].productId, 1);
      expect(cartModel.products[0].quantity, 2);
      expect(cartModel.products[0].title, 'Product 1');
      expect(cartModel.products[0].price, 9.99);
      expect(cartModel.products[0].image, 'image_url');
      expect(cartModel.products[1].productId, 2);
      expect(cartModel.products[1].quantity, 3);
      expect(cartModel.products[1].title, 'Product 2');
      expect(cartModel.products[1].price, 9.99);
      expect(cartModel.products[1].image, 'image_url');
    });

    test('fromDomain creates an instance from CartEntity', () {
      final cartEntity = CartEntity(
        id: 1,
        userId: 123,
        date: DateTime.parse('2022-12-01T00:00:00.000Z'),
        products: [
          CartProductModel(
            productId: 1,
            quantity: 2,
            title: 'Product 1',
            price: 9.99,
            image: 'image_url',
          ),
          CartProductModel(
            productId: 2,
            quantity: 3,
            title: 'Product 2',
            price: 9.99,
            image: 'image_url',
          ),
        ],
      );

      final cartModel = CartModel.fromDomain(cartEntity);

      expect(cartModel.id, 1);
      expect(cartModel.userId, 123);
      expect(cartModel.date, DateTime.parse('2022-12-01T00:00:00.000Z'));
      expect(cartModel.products.length, 2);
      expect(cartModel.products[0].productId, 1);
      expect(cartModel.products[0].quantity, 2);
      expect(cartModel.products[0].title, 'Product 1');
      expect(cartModel.products[0].price, 9.99);
      expect(cartModel.products[0].image, 'image_url');
      expect(cartModel.products[1].productId, 2);
      expect(cartModel.products[1].quantity, 3);
      expect(cartModel.products[1].title, 'Product 2');
      expect(cartModel.products[1].price, 9.99);
      expect(cartModel.products[1].image, 'image_url');
    });

    test('toMap converts an instance to a map', () {
      final cartModel = CartModel(
        id: 1,
        userId: 123,
        date: DateTime.parse('2022-12-01T00:00:00.000Z'),
        products: [
          CartProductModel(
            productId: 1,
            quantity: 2,
            title: 'Product 1',
            price: 9.99,
            image: 'image_url',
          ),
          CartProductModel(
            productId: 2,
            quantity: 3,
            title: 'Product 2',
            price: 9.99,
            image: 'image_url',
          ),
        ],
      );

      final map = cartModel.toMap();

      expect(map['userId'], 123);
      expect(map['date'], '2022-12-01T00:00:00.000Z');
      expect(map['products'].length, 2);
      expect(map['products'][0]['productId'], 1);
      expect(map['products'][0]['quantity'], 2);
      expect(map['products'][0]['title'], 'Product 1');
      expect(map['products'][0]['price'], 9.99);
      expect(map['products'][0]['image'], 'image_url');
      expect(map['products'][1]['productId'], 2);
      expect(map['products'][1]['quantity'], 3);
      expect(map['products'][1]['title'], 'Product 2');
      expect(map['products'][1]['price'], 9.99);
      expect(map['products'][1]['image'], 'image_url');
    });
  });
}
