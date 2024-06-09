import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:fake_api/core/core.dart';
import 'package:fake_api/features/auth/domain/domain.dart';
import 'package:fake_api/features/auth/data/remote/remote.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, TokenEntity>> logIn(
    String username,
    String password,
  ) async {
    try {
      final token = await _remoteDataSource.logIn(username, password);
      return Right(token);
    } on SocketException {
      return const Left(NoInternetFailure());
    } on FormatException {
      return const Left(InvalidResponseFailure());
    } catch (e) {
      return Left(FetchDataFailure(e.toString()));
    }
  }
}
