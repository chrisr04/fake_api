import 'package:fake_api/core/core.dart';
import 'package:fake_api/features/auth/domain/domain.dart';

class AuthController {
  const AuthController(this._repository);

  final AuthRepository _repository;

  /// Asynchronously log in to Fake API
  /// it throws a FakeApiControllerException with information about the problem.
  ///
  /// [username] username credential needed for log in
  /// [password] password credential needed for log in
  Future<TokenEntity> logIn(String username, String password) async {
    final failureOrToken = await _repository.logIn(username, password);
    final result = failureOrToken.fold(
      (failure) => failure,
      (token) => token,
    );

    if (failureOrToken.isLeft()) {
      final failure = result as Failure;
      throw AuthControllerException(failure.message);
    }

    return result as TokenEntity;
  }
}
