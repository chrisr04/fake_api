import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockCartRemoteDataSource extends Mock implements CartRemoteDataSource {}

void main() {
  late CartRepositoryImpl repository;
  late MockCartRemoteDataSource mockRemoteDataSource;
  late FakeApiParams fakeParams;

  setUpAll(() {
    fakeParams = FakeApiParams();
    mockRemoteDataSource = MockCartRemoteDataSource();
    repository = CartRepositoryImpl(mockRemoteDataSource);
  });

  group('CartRepositoryImpl getCarts', () {
    test('should return List<CartEntity> when remote data source succeeds',
        () async {
      final carts = <CartModel>[];
      when(() => mockRemoteDataSource.getCarts(params: fakeParams))
          .thenAnswer((_) async => carts);

      final result = await repository.getCarts(params: fakeParams);

      expect(result, isA<Right>());
      expect((result as Right).value, isA<List<CartEntity>>());
    });

    test('should return Left(NoInternetFailure) when SocketException occurs',
        () async {
      when(() => mockRemoteDataSource.getCarts(params: fakeParams))
          .thenThrow(const SocketException('No internet'));

      final result = await repository.getCarts(params: fakeParams);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<NoInternetFailure>());
    });

    test(
        'should return Left(InvalidResponseFailure) when FormatException occurs',
        () async {
      when(() => mockRemoteDataSource.getCarts(params: fakeParams))
          .thenThrow(const FormatException('Invalid response'));

      final result = await repository.getCarts(params: fakeParams);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<InvalidResponseFailure>());
    });

    test('should return Left(FetchDataFailure) on generic error', () async {
      when(() => mockRemoteDataSource.getCarts(params: fakeParams))
          .thenThrow(const NetworkException('NetworkException', 'Some error'));

      final result = await repository.getCarts(params: fakeParams);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<FetchDataFailure>());
    });
  });

  group('CartRepositoryImpl getCartById', () {
    const cartId = 1;

    test('should return CartEntity when remote data source succeeds', () async {
      when(() => mockRemoteDataSource.getCartById(cartId))
          .thenAnswer((_) async => CartModel.fromJson({}));

      final result = await repository.getCartById(cartId);

      expect(result, isA<Right>());
      expect((result as Right).value, isA<CartEntity>());
    });

    test('should return Left(NoInternetFailure) when SocketException occurs',
        () async {
      when(() => mockRemoteDataSource.getCartById(cartId))
          .thenThrow(const SocketException('No internet'));

      final result = await repository.getCartById(cartId);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<NoInternetFailure>());
    });

    test(
        'should return Left(InvalidResponseFailure) when FormatException occurs',
        () async {
      when(() => mockRemoteDataSource.getCartById(cartId))
          .thenThrow(const FormatException('Invalid response'));

      final result = await repository.getCartById(cartId);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<InvalidResponseFailure>());
    });

    test('should return Left(FetchDataFailure) on generic error', () async {
      when(() => mockRemoteDataSource.getCartById(cartId))
          .thenThrow(const NetworkException('NetworkException', 'Some error'));

      final result = await repository.getCartById(cartId);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<FetchDataFailure>());
    });
  });

  group('CartRepositoryImpl getCartsByUserId', () {
    const userId = 1;
    const carts = <CartModel>[];

    test('should return List<CartEntity> when remote data source succeeds',
        () async {
      when(() =>
              mockRemoteDataSource.getCartsByUserId(userId, params: fakeParams))
          .thenAnswer((_) async => carts);

      final result =
          await repository.getCartsByUserId(userId, params: fakeParams);

      expect(result, isA<Right>());
      expect((result as Right).value, isA<List<CartEntity>>());
    });

    test('should return Left(NoInternetFailure) when SocketException occurs',
        () async {
      when(() =>
              mockRemoteDataSource.getCartsByUserId(userId, params: fakeParams))
          .thenThrow(const SocketException('No internet'));

      final result =
          await repository.getCartsByUserId(userId, params: fakeParams);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<NoInternetFailure>());
    });

    test(
        'should return Left(InvalidResponseFailure) when FormatException occurs',
        () async {
      when(() =>
              mockRemoteDataSource.getCartsByUserId(userId, params: fakeParams))
          .thenThrow(const FormatException('Invalid response'));

      final result =
          await repository.getCartsByUserId(userId, params: fakeParams);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<InvalidResponseFailure>());
    });

    test('should return Left(FetchDataFailure) on generic error', () async {
      when(() =>
              mockRemoteDataSource.getCartsByUserId(userId, params: fakeParams))
          .thenThrow(const NetworkException('NetworkException', 'Some error'));

      final result =
          await repository.getCartsByUserId(userId, params: fakeParams);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<FetchDataFailure>());
    });
  });

  group('CartRepositoryImpl createCart', () {
    final cart = CartEntity(
      id: 1,
      userId: 2,
      date: DateTime.now(),
      products: [],
    );

    test('should return CartEntity when remote data source succeeds', () async {
      when(() => mockRemoteDataSource.createCart(cart))
          .thenAnswer((_) async => CartModel.fromJson({}));

      final result = await repository.createCart(cart);

      expect(result, isA<Right>());
      expect((result as Right).value, isA<CartEntity>());
    });

    test('should return Left(NoInternetFailure) when SocketException occurs',
        () async {
      when(() => mockRemoteDataSource.createCart(cart))
          .thenThrow(const SocketException('No internet'));

      final result = await repository.createCart(cart);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<NoInternetFailure>());
    });

    test(
        'should return Left(InvalidResponseFailure) when FormatException occurs',
        () async {
      when(() => mockRemoteDataSource.createCart(cart))
          .thenThrow(const FormatException('Invalid response'));

      final result = await repository.createCart(cart);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<InvalidResponseFailure>());
    });

    test('should return Left(FetchDataFailure) on generic error', () async {
      when(() => mockRemoteDataSource.createCart(cart))
          .thenThrow(const NetworkException('NetworkException', 'Some error'));

      final result = await repository.createCart(cart);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<FetchDataFailure>());
    });
  });

  group('CartRepositoryImpl updateCart', () {
    final cart = CartEntity(
      id: 1,
      userId: 2,
      date: DateTime.now(),
      products: [],
    );

    test('should return CartEntity when remote data source succeeds', () async {
      when(() => mockRemoteDataSource.updateCart(cart))
          .thenAnswer((_) async => CartModel.fromJson({}));

      final result = await repository.updateCart(cart);

      expect(result, isA<Right>());
      expect((result as Right).value, isA<CartEntity>());
    });

    test('should return Left(NoInternetFailure) when SocketException occurs',
        () async {
      when(() => mockRemoteDataSource.updateCart(cart))
          .thenThrow(const SocketException('No internet'));

      final result = await repository.updateCart(cart);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<NoInternetFailure>());
    });

    test(
        'should return Left(InvalidResponseFailure) when FormatException occurs',
        () async {
      when(() => mockRemoteDataSource.updateCart(cart))
          .thenThrow(const FormatException('Invalid response'));

      final result = await repository.updateCart(cart);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<InvalidResponseFailure>());
    });

    test('should return Left(FetchDataFailure) on generic error', () async {
      when(() => mockRemoteDataSource.updateCart(cart))
          .thenThrow(const NetworkException('NetworkException', 'Some error'));

      final result = await repository.updateCart(cart);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<FetchDataFailure>());
    });
  });

  group('CartRepositoryImpl deleteCart', () {
    const cartId = 1;

    test('should return CartEntity when remote data source succeeds', () async {
      when(() => mockRemoteDataSource.deleteCart(cartId))
          .thenAnswer((_) async => CartModel.fromJson({}));

      final result = await repository.deleteCart(cartId);

      expect(result, isA<Right>());
      expect((result as Right).value, isA<CartEntity>());
    });

    test('should return Left(NoInternetFailure) when SocketException occurs',
        () async {
      when(() => mockRemoteDataSource.deleteCart(cartId))
          .thenThrow(const SocketException('No internet'));

      final result = await repository.deleteCart(cartId);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<NoInternetFailure>());
    });

    test(
        'should return Left(InvalidResponseFailure) when FormatException occurs',
        () async {
      when(() => mockRemoteDataSource.deleteCart(cartId))
          .thenThrow(const FormatException('Invalid response'));

      final result = await repository.deleteCart(cartId);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<InvalidResponseFailure>());
    });

    test('should return Left(FetchDataFailure) on generic error', () async {
      when(() => mockRemoteDataSource.deleteCart(cartId))
          .thenThrow(const NetworkException('NetworkException', 'Some error'));

      final result = await repository.deleteCart(cartId);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<FetchDataFailure>());
    });
  });
}
