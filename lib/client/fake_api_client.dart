import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:fake_api/core/core.dart';
import 'package:fake_api/features/auth/auth.dart';
import 'package:fake_api/features/product/product.dart';
import 'package:fake_api/features/cart/cart.dart';
import 'package:fake_api/features/user/user.dart';

/// FakeApiClient enables you to make HTTP requests to Fake API easily.
class FakeApiClient {
  late final HttpClient _httpClient;

  /// Provides all authentication methods for Fake API
  late final AuthController auth;

  /// Provides all product methods to consume data from Fake API
  late final ProductController products;

  /// Provides all user methods to consume data from Fake API
  late final UserController users;

  /// Provides all cart methods to consume data from Fake API
  late final CartController carts;

  /// Initializes the properties of the FakeApi class to ensure its correct operation.
  ///
  /// Note: if you try to access a property of the class without first calling this method
  /// you will receive a LateInitializationError error.
  void init() {
    _httpClient = HttpClient(
      Client(),
      baseUrl: 'https://fakestoreapi.com',
      baseHeaders: {
        'content-type': 'application/json',
      },
    );

    final authDataSource = AuthRemoteDataSource(_httpClient);
    final authRepository = AuthRepositoryImpl(authDataSource);
    auth = AuthController(authRepository);

    final productDataSource = ProductRemoteDataSource(_httpClient);
    final productRepository = ProductRepositoryImpl(productDataSource);
    products = ProductController(productRepository);

    final userDataSource = UserRemoteDataSource(_httpClient);
    final userRepository = UserRepositoryImpl(userDataSource);
    users = UserController(userRepository);

    final cartDataSource = CartRemoteDataSource(_httpClient);
    final cartRepository = CartRepositoryImpl(cartDataSource);
    carts = CartController(cartRepository);
  }

  /// Initializes the Fake Api class receiving as parameter
  /// the controller mocks needed for testing.
  @visibleForTesting
  void initMocks(
    AuthController authController,
    ProductController productController,
    UserController userController,
    CartController cartController,
  ) {
    auth = authController;
    products = productController;
    users = userController;
    carts = cartController;
  }

  /// Closes the Fake Api Client and cleans up any resources associated with it.
  void close() => _httpClient.close();
}
