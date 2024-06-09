import 'package:dartz/dartz.dart';
import 'package:fake_api/core/core.dart';
import 'package:fake_api/features/product/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    FakeApiParams? params,
  });
  Future<Either<Failure, ProductEntity>> getProductById(int id);
  Future<Either<Failure, List<String>>> getCategories();
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category,
  );
}
