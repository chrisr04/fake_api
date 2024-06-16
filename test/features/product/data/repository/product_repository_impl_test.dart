import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockProductRemoteDataSource extends Mock
    implements ProductRemoteDataSource {}

void main() {
  late ProductRepositoryImpl repository;
  late MockProductRemoteDataSource mockRemoteDataSource;
  late FakeApiParams fakeParams;

  setUpAll(() {
    fakeParams = FakeApiParams();
    mockRemoteDataSource = MockProductRemoteDataSource();
    repository = ProductRepositoryImpl(mockRemoteDataSource);
  });

  group('ProductRepositoryImpl getProducts', () {
    test('should return a List<ProductEntity> when remote data source succeeds',
        () async {
      final products = <ProductModel>[];
      when(() => mockRemoteDataSource.getProducts(params: fakeParams))
          .thenAnswer((_) async => products);

      final result = await repository.getProducts(params: fakeParams);

      expect(result, isA<Right>());
      expect((result as Right).value, isA<List<ProductEntity>>());
    });

    test('should return a Left(NoInternetFailure) when SocketException occurs',
        () async {
      when(() => mockRemoteDataSource.getProducts(params: fakeParams))
          .thenThrow(const SocketException('No internet'));

      final result = await repository.getProducts(params: fakeParams);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<NoInternetFailure>());
    });

    test(
        'should return a Left(InvalidResponseFailure) when FormatException occurs',
        () async {
      when(() => mockRemoteDataSource.getProducts(params: fakeParams))
          .thenThrow(const FormatException('Invalid response'));

      final result = await repository.getProducts(params: fakeParams);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<InvalidResponseFailure>());
    });

    test('should return Left(FetchDataFailure) on generic error', () async {
      when(() => mockRemoteDataSource.getProducts(params: fakeParams))
          .thenThrow(const NetworkException('NetworkException', 'Some error'));

      final result = await repository.getProducts(params: fakeParams);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<FetchDataFailure>());
    });
  });

  group('ProductRepositoryImpl getProductById', () {
    const productId = 1;

    test('should return a ProductEntity when remote data source succeeds',
        () async {
      when(() => mockRemoteDataSource.getProductById(productId))
          .thenAnswer((_) async => ProductModel.fromJson({}));

      final result = await repository.getProductById(productId);

      expect(result, isA<Right>());
      expect((result as Right).value, isA<ProductEntity>());
    });

    test('should return a Left(NoInternetFailure) when SocketException occurs',
        () async {
      when(() => mockRemoteDataSource.getProductById(productId))
          .thenThrow(const SocketException('No internet'));

      final result = await repository.getProductById(productId);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<NoInternetFailure>());
    });

    test(
        'should return a Left(InvalidResponseFailure) when FormatException occurs',
        () async {
      when(() => mockRemoteDataSource.getProductById(productId))
          .thenThrow(const FormatException('Invalid response'));

      final result = await repository.getProductById(productId);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<InvalidResponseFailure>());
    });

    test('should return a Left(FetchDataFailure) on generic error', () async {
      when(() => mockRemoteDataSource.getProductById(productId))
          .thenThrow(const NetworkException('NetworkException', 'Some error'));

      final result = await repository.getProductById(productId);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<FetchDataFailure>());
    });
  });

  group('ProductRepositoryImpl getCategories', () {
    test('should return a List<String> when remote data source succeeds',
        () async {
      final categories = ['Jewelery'];
      when(() => mockRemoteDataSource.getCategories())
          .thenAnswer((_) async => categories);

      final result = await repository.getCategories();

      expect(result, isA<Right>());
      expect((result as Right).value, isA<List<String>>());
    });

    test('should return a Left(NoInternetFailure) when SocketException occurs',
        () async {
      when(() => mockRemoteDataSource.getCategories())
          .thenThrow(const SocketException('No internet'));

      final result = await repository.getCategories();

      expect(result, isA<Left>());
      expect((result as Left).value, isA<NoInternetFailure>());
    });

    test(
        'should return a Left(InvalidResponseFailure) when FormatException occurs',
        () async {
      when(() => mockRemoteDataSource.getCategories())
          .thenThrow(const FormatException('Invalid response'));

      final result = await repository.getCategories();

      expect(result, isA<Left>());
      expect((result as Left).value, isA<InvalidResponseFailure>());
    });

    test('should return a Left(FetchDataFailure) on generic error', () async {
      when(() => mockRemoteDataSource.getCategories())
          .thenThrow(const NetworkException('NetworkException', 'Some error'));

      final result = await repository.getCategories();

      expect(result, isA<Left>());
      expect((result as Left).value, isA<FetchDataFailure>());
    });
  });

  group('ProductRepositoryImpl getCartsByUserId', () {
    const category = 'electronics';
    const products = <ProductModel>[];

    test('should return a List<ProductModel> when remote data source succeeds',
        () async {
      when(() => mockRemoteDataSource.getProductsByCategory(category))
          .thenAnswer((_) async => products);

      final result = await repository.getProductsByCategory(category);

      expect(result, isA<Right>());
      expect((result as Right).value, isA<List<ProductEntity>>());
    });

    test('should return a Left(NoInternetFailure) when SocketException occurs',
        () async {
      when(() => mockRemoteDataSource.getProductsByCategory(category))
          .thenThrow(const SocketException('No internet'));

      final result = await repository.getProductsByCategory(category);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<NoInternetFailure>());
    });

    test(
        'should return a Left(InvalidResponseFailure) when FormatException occurs',
        () async {
      when(() => mockRemoteDataSource.getProductsByCategory(category))
          .thenThrow(const FormatException('Invalid response'));

      final result = await repository.getProductsByCategory(category);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<InvalidResponseFailure>());
    });

    test('should return a Left(FetchDataFailure) on generic error', () async {
      when(() => mockRemoteDataSource.getProductsByCategory(category))
          .thenThrow(const NetworkException('NetworkException', 'Some error'));

      final result = await repository.getProductsByCategory(category);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<FetchDataFailure>());
    });
  });
}
