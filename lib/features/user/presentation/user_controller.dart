import 'package:fake_api/core/core.dart';
import 'package:fake_api/features/user/domain/domain.dart';

class UserController {
  const UserController(this._repository);

  final UserRepository _repository;

  /// Returns all users from Api. If something was wrong
  /// it throws a FakeApiControllerException with information about the problem.
  ///
  /// [params] It allows add query parameters to Fake API request. More see [FakeApiParams]
  Future<List<UserEntity>> getUsers({FakeApiParams? params}) async {
    final failureOrUsers = await _repository.getUsers(params: params);
    final result = failureOrUsers.fold(
      (failure) => failure,
      (users) => users,
    );

    if (failureOrUsers.isLeft()) {
      final failure = result as Failure;
      throw UserControllerException(failure.message);
    }

    return result as List<UserEntity>;
  }

  /// Returns the user associated to [id] from Fake API. If something was wrong
  /// it throws a FakeApiControllerException with information about the problem.
  ///
  /// [id] Is the id of the product we want to obtain
  Future<UserEntity> getUserById(int id) async {
    final failureOrUsers = await _repository.getUserById(id);
    final result = failureOrUsers.fold(
      (failure) => failure,
      (user) => user,
    );

    if (failureOrUsers.isLeft()) {
      final failure = result as Failure;
      throw UserControllerException(failure.message);
    }

    return result as UserEntity;
  }

  /// Create a new user and return it. If something was wrong
  /// it throws a FakeApiControllerException with information about the problem.
  ///
  /// [user] Is the user to create in the Fake API
  Future<UserEntity> createUser(UserEntity user) async {
    final failureOrCreated = await _repository.createUser(user);
    final result = failureOrCreated.fold(
      (failure) => failure,
      (createdUser) => createdUser,
    );

    if (failureOrCreated.isLeft()) {
      final failure = result as Failure;
      throw UserControllerException(failure.message);
    }

    return result as UserEntity;
  }
}
