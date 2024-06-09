import 'package:dartz/dartz.dart';
import 'package:fake_api/core/core.dart';
import 'package:fake_api/features/cart/domain/entities/entities.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartEntity>>> getCarts({FakeApiParams? params});
  Future<Either<Failure, CartEntity>> getCartById(int id);
  Future<Either<Failure, List<CartEntity>>> getCartsByUserId(
    int userId, {
    FakeApiParams? params,
  });
  Future<Either<Failure, CartEntity>> createCart(CartEntity cart);
  Future<Either<Failure, CartEntity>> updateCart(CartEntity cart);
  Future<Either<Failure, CartEntity>> deleteCart(int cartId);
}
