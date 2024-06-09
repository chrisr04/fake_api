import 'package:fake_api/core/core.dart';
import 'package:fake_api/features/product/domain/entities/product_entity.dart';
import 'package:fake_api/features/product/domain/repositories/product_repository.dart';

class ProductController {
  const ProductController(this._repository);

  final ProductRepository _repository;

  /// Returns all products from Fake API. If something was wrong
  /// it throws a FakeApiControllerException with information about the problem.
  ///
  /// [params] It allows add query parameters to Fake API request. More see [FakeApiParams]
  Future<List<ProductEntity>> getProducts({FakeApiParams? params}) async {
    final failureOrProducts = await _repository.getProducts(
      params: params,
    );

    final result = failureOrProducts.fold(
      (failure) => failure,
      (products) => products,
    );

    if (failureOrProducts.isLeft()) {
      final failure = result as Failure;
      throw ProductControllerException(failure.message);
    }

    return result as List<ProductEntity>;
  }

  /// Returns the product asociated to [id] from Fake API. If something was wrong
  /// it throws a FakeApiControllerException with information about the problem.
  ///
  /// [id] Is the id of the product we want to obtain
  Future<ProductEntity> getProductById(int id) async {
    final failureOrProduct = await _repository.getProductById(id);

    final result = failureOrProduct.fold(
      (failure) => failure,
      (product) => product,
    );

    if (failureOrProduct.isLeft()) {
      final failure = result as Failure;
      throw ProductControllerException(failure.message);
    }

    return result as ProductEntity;
  }

  /// Returns all the categories from Fake API. If something was wrong
  /// it throws a FakeApiControllerException with information about the problem.
  Future<List<String>> getCategories() async {
    final failureOrCategories = await _repository.getCategories();

    final result = failureOrCategories.fold(
      (failure) => failure,
      (categories) => categories,
    );

    if (failureOrCategories.isLeft()) {
      final failure = result as Failure;
      throw ProductControllerException(failure.message);
    }

    return result as List<String>;
  }

  /// Returns a product list associated to [category] from Fake API. If something was wrong
  /// it throws a FakeApiControllerException with information about the problem.
  ///
  /// [category] It is the category of products that we want to obtain
  Future<List<ProductEntity>> getProductsByCategory(String category) async {
    final failureOrProducts = await _repository.getProductsByCategory(
      category,
    );

    final result = failureOrProducts.fold(
      (failure) => failure,
      (products) => products,
    );

    if (failureOrProducts.isLeft()) {
      final failure = result as Failure;
      throw ProductControllerException(failure.message);
    }

    return result as List<ProductEntity>;
  }
}
