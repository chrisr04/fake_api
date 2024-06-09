import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:fake_api/core/core.dart';
import 'package:fake_api/features/product/domain/domain.dart';
import 'package:fake_api/features/product/data/remote/remote.dart';

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl(this._remoteDataSource);

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    FakeApiParams? params,
  }) async {
    try {
      final products = await _remoteDataSource.getProducts(params: params);
      return Right(products);
    } on SocketException {
      return const Left(NoInternetFailure());
    } on FormatException {
      return const Left(InvalidResponseFailure());
    } catch (e) {
      return Left(FetchDataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductById(int id) async {
    try {
      final product = await _remoteDataSource.getProductById(id);
      return Right(product);
    } on SocketException {
      return const Left(NoInternetFailure());
    } on FormatException {
      return const Left(InvalidResponseFailure());
    } catch (e) {
      return Left(FetchDataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final categories = await _remoteDataSource.getCategories();
      return Right(categories);
    } on SocketException {
      return const Left(NoInternetFailure());
    } on FormatException {
      return const Left(InvalidResponseFailure());
    } catch (e) {
      return Left(FetchDataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category,
  ) async {
    try {
      final products = await _remoteDataSource.getProductsByCategory(category);
      return Right(products);
    } on SocketException {
      return const Left(NoInternetFailure());
    } on FormatException {
      return const Left(InvalidResponseFailure());
    } catch (e) {
      return Left(FetchDataFailure(e.toString()));
    }
  }
}
