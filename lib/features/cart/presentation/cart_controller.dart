import 'package:fake_api/core/core.dart';
import 'package:fake_api/features/cart/domain/domain.dart';

class CartController {
  const CartController(this._repository);

  final CartRepository _repository;

  /// Returns all carts from Fake API. If something was wrong
  /// it throws a FakeApiControllerException with information about the problem.
  ///
  /// [params] It allows add query parameters to Fake API request. More see [FakeApiParams]
  Future<List<CartEntity>> getCarts({FakeApiParams? params}) async {
    final failureOrCarts = await _repository.getCarts(params: params);
    final result = failureOrCarts.fold(
      (failure) => failure,
      (carts) => carts,
    );

    if (failureOrCarts.isLeft()) {
      final failure = result as Failure;
      throw CartControllerException(failure.message);
    }

    return result as List<CartEntity>;
  }

  /// Returns the cart asociated to [id] from Fake API. If something was wrong
  /// it throws a FakeApiControllerException with information about the problem.
  ///
  /// [id] Is the id of the product we want to obtain
  Future<CartEntity> getCartById(int id) async {
    final failureOrCart = await _repository.getCartById(id);
    final result = failureOrCart.fold(
      (failure) => failure,
      (cart) => cart,
    );

    if (failureOrCart.isLeft()) {
      final failure = result as Failure;
      throw CartControllerException(failure.message);
    }

    return result as CartEntity;
  }

  /// Returns a cart list associated to [userId] from Fake API. If something was wrong
  /// it throws a FakeApiControllerException with information about the problem.
  ///
  /// [userId] It's the id from user associated to carts that we want to obtain.
  ///
  /// [params] It allows add query parameters to Fake API request. More see [FakeApiParams].
  Future<List<CartEntity>> getCartsByUserId(
    int userId, {
    FakeApiParams? params,
  }) async {
    final failureOrCart = await _repository.getCartsByUserId(
      userId,
      params: params,
    );
    final result = failureOrCart.fold(
      (failure) => failure,
      (cart) => cart,
    );

    if (failureOrCart.isLeft()) {
      final failure = result as Failure;
      throw CartControllerException(failure.message);
    }

    return result as List<CartEntity>;
  }

  /// Create a new cart and return it. If something was wrong
  /// it throws a FakeApiControllerException with information about the problem.
  ///
  /// [cart] Is the cart to create in the Fake API
  Future<CartEntity> createCart(CartEntity cart) async {
    final failureOrCreated = await _repository.createCart(cart);

    final result = failureOrCreated.fold(
      (failure) => failure,
      (createdCart) => createdCart,
    );

    if (failureOrCreated.isLeft()) {
      final failure = result as Failure;
      throw CartControllerException(failure.message);
    }

    return result as CartEntity;
  }

  /// Update the cart provided and returns it. If something was wrong
  /// it throws a FakeApiControllerException with information about the problem.
  ///
  /// [cart] It's the cart to update.
  Future<CartEntity> updateCart(CartEntity cart) async {
    final failureOrUpdated = await _repository.updateCart(cart);

    final result = failureOrUpdated.fold(
      (failure) => failure,
      (updatedCart) => updatedCart,
    );

    if (failureOrUpdated.isLeft()) {
      final failure = result as Failure;
      throw CartControllerException(failure.message);
    }

    return result as CartEntity;
  }

  /// Delete the cart associated to [id] and returns the entry cart. If something was wrong
  /// it throws a FakeApiControllerException with information about the problem.
  ///
  /// [id] It's the id of the cart to delete.
  Future<CartEntity> deleteCart(int id) async {
    final failureOrDeleted = await _repository.deleteCart(id);

    final result = failureOrDeleted.fold(
      (failure) => failure,
      (deletedCart) => deletedCart,
    );

    if (failureOrDeleted.isLeft()) {
      final failure = result as Failure;
      throw CartControllerException(failure.message);
    }

    return result as CartEntity;
  }
}
