import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:fake_api/core/core.dart';
import 'package:fake_api/features/user/domain/domain.dart';
import 'package:fake_api/features/user/data/remote/datasource/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(this._remoteDataSource);

  final UserRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers({
    FakeApiParams? params,
  }) async {
    try {
      final users = await _remoteDataSource.getUsers(params: params);
      return Right(users);
    } on SocketException {
      return const Left(NoInternetFailure());
    } on FormatException {
      return const Left(InvalidResponseFailure());
    } catch (e) {
      return Left(FetchDataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserById(int id) async {
    try {
      final user = await _remoteDataSource.getUserById(id);
      return Right(user);
    } on SocketException {
      return const Left(NoInternetFailure());
    } on FormatException {
      return const Left(InvalidResponseFailure());
    } catch (e) {
      return Left(FetchDataFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> createUser(UserEntity user) async {
    try {
      final createdUser = await _remoteDataSource.createUser(user);
      return Right(createdUser);
    } on SocketException {
      return const Left(NoInternetFailure());
    } on FormatException {
      return const Left(InvalidResponseFailure());
    } catch (e) {
      return Left(FetchDataFailure(e.toString()));
    }
  }
}
