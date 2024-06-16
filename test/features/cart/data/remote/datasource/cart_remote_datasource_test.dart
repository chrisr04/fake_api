import 'dart:convert';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fake_api/fake_api.dart';

import '../../../../../mocks/core_mocks.dart';

void main() {
  late CartRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    mockHttpClient = MockHttpClient();
    dataSource = CartRemoteDataSource(mockHttpClient);
  });

  group('CartRemoteDataSource getCarts', () {
    test('should returns List<CartModel> on successful response', () async {
      final url = Uri.parse('https://example.com/carts');
      final response = MockResponse();
      final parmas = FakeApiParams();
      final responseJson = jsonEncode([]);

      when(
        () => mockHttpClient.url(
          '/carts',
          queryParameters: parmas.toMap(),
        ),
      ).thenReturn(url);

      when(
        () => mockHttpClient.get(url),
      ).thenAnswer((_) async => response);

      when(() => response.body).thenReturn(responseJson);

      final carts = await dataSource.getCarts(params: parmas);

      expect(carts, isA<List<CartModel>>());
    });

    test('should throws NetworkException on failure response', () async {
      final url = Uri.parse('https://example.com/carts');
      final response = MockResponse();

      when(() => mockHttpClient.url('/carts')).thenReturn(url);

      when(
        () => mockHttpClient.get(url),
      ).thenAnswer((_) async => response);

      when(() => response.body).thenThrow(
        const NetworkException('NetworkException', 'Somthing went wrong'),
      );

      expect(
        () => dataSource.getCarts(),
        throwsA(isA<NetworkException>()),
      );
    });
  });

  group('CartRemoteDataSource getCartById', () {
    test('should returns CartModel on successful response', () async {
      const cartId = 1;
      final url = Uri.parse('https://example.com/carts/$cartId');
      final response = MockResponse();
      final responseJson = jsonEncode({});

      when(() => mockHttpClient.url('/carts/$cartId')).thenReturn(url);

      when(
        () => mockHttpClient.get(url),
      ).thenAnswer((_) async => response);

      when(() => response.body).thenReturn(responseJson);

      final carts = await dataSource.getCartById(cartId);

      expect(carts, isA<CartModel>());
    });

    test('should throws NetworkException on failure response', () async {
      const cartId = 1;
      final url = Uri.parse('https://example.com/carts/$cartId');

      when(() => mockHttpClient.url('/carts/$cartId')).thenReturn(url);

      when(
        () => mockHttpClient.get(url),
      ).thenThrow(
        const NetworkException('NetworkException', 'Something went wrong'),
      );

      expect(
        () => dataSource.getCartById(cartId),
        throwsA(isA<NetworkException>()),
      );
    });
  });

  group('CartRemoteDataSource getCartsByUserId', () {
    test('should returns List<CartModel> on successful response', () async {
      const userId = 1;
      final url = Uri.parse('https://example.com/carts/user/$userId');
      final params = FakeApiParams();
      final response = MockResponse();
      final responseJson = jsonEncode([]);

      when(
        () => mockHttpClient.url(
          '/carts/user/$userId',
          queryParameters: params.toMap(),
        ),
      ).thenReturn(url);

      when(
        () => mockHttpClient.get(url),
      ).thenAnswer((_) async => response);

      when(() => response.body).thenReturn(responseJson);

      final carts = await dataSource.getCartsByUserId(userId, params: params);

      expect(carts, isA<List<CartModel>>());
    });

    test('should throws NetworkException on failure response', () async {
      const userId = 1;
      final url = Uri.parse('https://example.com/carts/user/$userId');
      final params = FakeApiParams();

      when(
        () => mockHttpClient.url(
          '/carts/user/$userId',
          queryParameters: params.toMap(),
        ),
      ).thenReturn(url);

      when(
        () => mockHttpClient.get(url),
      ).thenThrow(
        const NetworkException('NetworkException', 'Something went wrong'),
      );

      expect(
        () => dataSource.getCartsByUserId(userId, params: params),
        throwsA(isA<NetworkException>()),
      );
    });
  });

  group('CartRemoteDataSource createCart', () {
    test('should returns CartModel on successful response', () async {
      final cart = CartEntity(
        id: 123,
        userId: 456,
        date: DateTime(2023, 6, 15),
        products: [],
      );
      final url = Uri.parse('https://example.com/carts');
      final response = MockResponse();
      final responseBody = jsonEncode(CartModel.fromDomain(cart).toMap());
      final responseJson = jsonEncode({});

      when(() => mockHttpClient.url('/carts')).thenReturn(url);

      when(
        () => mockHttpClient.post(
          url,
          body: responseBody,
        ),
      ).thenAnswer((_) async => response);

      when(() => response.body).thenReturn(responseJson);

      final carts = await dataSource.createCart(cart);

      expect(carts, isA<CartModel>());
    });

    test('should throws NetworkException on failure response', () async {
      final cart = CartEntity(
        id: 123,
        userId: 456,
        date: DateTime(2023, 6, 15),
        products: [],
      );
      final url = Uri.parse('https://example.com/carts');
      final responseBody = jsonEncode(CartModel.fromDomain(cart).toMap());

      when(() => mockHttpClient.url('/carts')).thenReturn(url);

      when(
        () => mockHttpClient.post(
          url,
          body: responseBody,
        ),
      ).thenThrow(
        const NetworkException('NetworkException', 'Something went wrong'),
      );

      expect(
        () => dataSource.createCart(cart),
        throwsA(isA<NetworkException>()),
      );
    });
  });

  group('CartRemoteDataSource updateCart', () {
    test('should returns CartModel on successful response', () async {
      final cart = CartEntity(
        id: 123,
        userId: 456,
        date: DateTime(2023, 6, 15),
        products: [],
      );
      final url = Uri.parse('https://example.com/carts/${cart.id}');
      final response = MockResponse();
      final responseBody = jsonEncode(CartModel.fromDomain(cart).toMap());
      final responseJson = jsonEncode({});

      when(() => mockHttpClient.url('/carts/${cart.id}')).thenReturn(url);

      when(
        () => mockHttpClient.put(
          url,
          body: responseBody,
        ),
      ).thenAnswer((_) async => response);

      when(() => response.body).thenReturn(responseJson);

      final carts = await dataSource.updateCart(cart);

      expect(carts, isA<CartModel>());
    });

    test('should throws NetworkException on failure response', () async {
      final cart = CartEntity(
        id: 123,
        userId: 456,
        date: DateTime(2023, 6, 15),
        products: [],
      );
      final url = Uri.parse('https://example.com/carts/${cart.id}');
      final responseBody = jsonEncode(CartModel.fromDomain(cart).toMap());

      when(() => mockHttpClient.url('/carts/${cart.id}')).thenReturn(url);

      when(
        () => mockHttpClient.put(
          url,
          body: responseBody,
        ),
      ).thenThrow(
        const NetworkException('NetworkException', 'Something went wrong'),
      );

      expect(
        () => dataSource.updateCart(cart),
        throwsA(isA<NetworkException>()),
      );
    });
  });

  group('CartRemoteDataSource deleteCart', () {
    test('should returns CartModel on successful response', () async {
      const cartId = 1;
      final url = Uri.parse('https://example.com/carts/$cartId');
      final response = MockResponse();
      final responseJson = jsonEncode({});

      when(() => mockHttpClient.url('/carts/$cartId')).thenReturn(url);

      when(() => mockHttpClient.delete(url)).thenAnswer((_) async => response);

      when(() => response.body).thenReturn(responseJson);

      final carts = await dataSource.deleteCart(cartId);

      expect(carts, isA<CartModel>());
    });

    test('should throws NetworkException on failure response', () async {
      const cartId = 1;
      final url = Uri.parse('https://example.com/carts/$cartId');

      when(() => mockHttpClient.url('/carts/$cartId')).thenReturn(url);

      when(
        () => mockHttpClient.delete(url),
      ).thenThrow(
        const NetworkException('NetworkException', 'Something went wrong'),
      );

      expect(
        () => dataSource.deleteCart(cartId),
        throwsA(isA<NetworkException>()),
      );
    });
  });
}
