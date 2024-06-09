import 'package:dartz/dartz.dart';
import 'package:fake_api/core/core.dart';
import 'package:fake_api/features/user/domain/entities/entities.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers({FakeApiParams? params});
  Future<Either<Failure, UserEntity>> getUserById(int id);
  Future<Either<Failure, UserEntity>> createUser(UserEntity user);
}
