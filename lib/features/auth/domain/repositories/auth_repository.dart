import 'package:dartz/dartz.dart';
import 'package:fake_api/core/core.dart';
import 'package:fake_api/features/auth/domain/entities/token_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, TokenEntity>> logIn(String username, String password);
}
