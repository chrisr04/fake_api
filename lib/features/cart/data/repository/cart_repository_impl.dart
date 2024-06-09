import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:fake_api/core/core.dart';
import 'package:fake_api/features/cart/domain/domain.dart';
import 'package:fake_api/features/cart/data/remote/remote.dart';

class CartRepositoryImpl implements CartRepository {
  const CartRepositoryImpl(this._remoteDataSource);

  final CartRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<CartEntity>>> getCarts({
    FakeApiParams? params,
  }) async {
    try {
      final carts = await _remoteDataSource.getCarts(params: params);
      return Right(carts);
    } on SocketException {
      return const Left(NoInternetFailure());
    } on FormatException {
      return const Left(InvalidResponseFailure());
    } catch (e) {
      return Left(FetchDataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> getCartById(int id) async {
    try {
      final cart = await _remoteDataSource.getCartById(id);
      return Right(cart);
    } on SocketException {
      return const Left(NoInternetFailure());
    } on FormatException {
      return const Left(InvalidResponseFailure());
    } catch (e) {
      return Left(FetchDataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartEntity>>> getCartsByUser(
    int userId, {
    FakeApiParams? params,
  }) async {
    try {
      final carts = await _remoteDataSource.getCartsByUser(
        userId,
        params: params,
      );
      return Right(carts);
    } on SocketException {
      return const Left(NoInternetFailure());
    } on FormatException {
      return const Left(InvalidResponseFailure());
    } catch (e) {
      return Left(FetchDataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> createCart(CartEntity cart) async {
    try {
      final createdCart = await _remoteDataSource.createCart(cart);
      return Right(createdCart);
    } on SocketException {
      return const Left(NoInternetFailure());
    } on FormatException {
      return const Left(InvalidResponseFailure());
    } catch (e) {
      return Left(FetchDataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> updateCart(
    CartEntity cart,
  ) async {
    try {
      final updatedCart = await _remoteDataSource.updateCart(cart);
      return Right(updatedCart);
    } on SocketException {
      return const Left(NoInternetFailure());
    } on FormatException {
      return const Left(InvalidResponseFailure());
    } catch (e) {
      return Left(FetchDataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartEntity>> deleteCart(int cartId) async {
    try {
      final deletedCart = await _remoteDataSource.deleteCart(cartId);
      return Right(deletedCart);
    } on SocketException {
      return const Left(NoInternetFailure());
    } on FormatException {
      return const Left(InvalidResponseFailure());
    } catch (e) {
      return Left(FetchDataFailure(e.toString()));
    }
  }
}
