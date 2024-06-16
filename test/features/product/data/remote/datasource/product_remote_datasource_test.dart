import 'dart:convert';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fake_api/fake_api.dart';

import '../../../../../mocks/core_mocks.dart';

void main() {
  late ProductRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    mockHttpClient = MockHttpClient();
    dataSource = ProductRemoteDataSource(mockHttpClient);
  });

  group('ProductRemoteDataSource getCarts', () {
    test('should returns List<ProductModel> on successful response', () async {
      final url = Uri.parse('https://example.com/products');
      final response = MockResponse();
      final parmas = FakeApiParams();
      final responseJson = jsonEncode([]);

      when(
        () => mockHttpClient.url(
          '/products',
          queryParameters: parmas.toMap(),
        ),
      ).thenReturn(url);

      when(
        () => mockHttpClient.get(url),
      ).thenAnswer((_) async => response);

      when(() => response.body).thenReturn(responseJson);

      final carts = await dataSource.getProducts(params: parmas);

      expect(carts, isA<List<ProductModel>>());
    });

    test('should throws NetworkException on failure response', () async {
      final url = Uri.parse('https://example.com/products');
      final response = MockResponse();

      when(() => mockHttpClient.url('/products')).thenReturn(url);

      when(
        () => mockHttpClient.get(url),
      ).thenAnswer((_) async => response);

      when(() => response.body).thenThrow(
        const NetworkException('NetworkException', 'Somthing went wrong'),
      );

      expect(
        () => dataSource.getProducts(),
        throwsA(isA<NetworkException>()),
      );
    });
  });

  group('ProductRemoteDataSource getProductById', () {
    test('should returns a ProductModel on successful response', () async {
      const productId = 1;
      final url = Uri.parse('https://example.com/products/$productId');
      final response = MockResponse();
      final responseJson = jsonEncode({});

      when(() => mockHttpClient.url('/products/$productId')).thenReturn(url);

      when(
        () => mockHttpClient.get(url),
      ).thenAnswer((_) async => response);

      when(() => response.body).thenReturn(responseJson);

      final carts = await dataSource.getProductById(productId);

      expect(carts, isA<ProductModel>());
    });

    test('should throws a NetworkException on failure response', () async {
      const productId = 1;
      final url = Uri.parse('https://example.com/products/$productId');

      when(() => mockHttpClient.url('/products/$productId')).thenReturn(url);

      when(
        () => mockHttpClient.get(url),
      ).thenThrow(
        const NetworkException('NetworkException', 'Something went wrong'),
      );

      expect(
        () => dataSource.getProductById(productId),
        throwsA(isA<NetworkException>()),
      );
    });
  });

  group('ProductRemoteDataSource getCategories', () {
    test('should returns a List<String> on successful response', () async {
      final url = Uri.parse('https://example.com/products/categories');
      final response = MockResponse();
      final responseJson = jsonEncode([]);

      when(() => mockHttpClient.url('/products/categories')).thenReturn(url);

      when(
        () => mockHttpClient.get(url),
      ).thenAnswer((_) async => response);

      when(() => response.body).thenReturn(responseJson);

      final carts = await dataSource.getCategories();

      expect(carts, isA<List<String>>());
    });

    test('should a throws NetworkException on failure response', () async {
      final url = Uri.parse('https://example.com/products/categories');

      when(() => mockHttpClient.url('/products/categories')).thenReturn(url);

      when(
        () => mockHttpClient.get(url),
      ).thenThrow(
        const NetworkException('NetworkException', 'Something went wrong'),
      );

      expect(
        () => dataSource.getCategories(),
        throwsA(isA<NetworkException>()),
      );
    });
  });

  group('ProductRemoteDataSource getProductsByCategory', () {
    test('should returns a List<ProductModel> on successful response',
        () async {
      const cartegory = 'electronics';
      final url = Uri.parse('https://example.com/products/category/$cartegory');
      final response = MockResponse();
      final responseJson = jsonEncode([]);

      when(
        () => mockHttpClient.url('/products/category/$cartegory'),
      ).thenReturn(url);

      when(
        () => mockHttpClient.get(url),
      ).thenAnswer((_) async => response);

      when(() => response.body).thenReturn(responseJson);

      final carts = await dataSource.getProductsByCategory(cartegory);

      expect(carts, isA<List<ProductModel>>());
    });

    test('should throws a NetworkException on failure response', () async {
      const cartegory = 'electronics';
      final url = Uri.parse('https://example.com/products/category/$cartegory');

      when(
        () => mockHttpClient.url('/products/category/$cartegory'),
      ).thenReturn(url);

      when(
        () => mockHttpClient.get(url),
      ).thenThrow(
        const NetworkException('NetworkException', 'Something went wrong'),
      );

      expect(
        () => dataSource.getProductsByCategory(cartegory),
        throwsA(isA<NetworkException>()),
      );
    });
  });
}
