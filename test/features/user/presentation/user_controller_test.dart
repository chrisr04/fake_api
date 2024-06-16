import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fake_api/fake_api.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late UserController userController;
  late MockUserRepository mockRepository;
  late FakeApiParams fakeParams;
  late UserEntity user;

  setUpAll(() {
    fakeParams = FakeApiParams();
    mockRepository = MockUserRepository();
    userController = UserController(mockRepository);
    user = const UserEntity(
      id: 1,
      name: UserNameEntity(
        firstname: 'John',
        lastname: 'Doe',
      ),
      username: 'johndoe',
      email: 'john.doe@example.com',
      phone: '123-456-7890',
      address: AddressEntity(
        city: 'New York',
        street: '123 Main St',
        zipcode: '10001',
        number: 1,
        geolocation: GeolocationEntity(
          lat: '34.5464',
          long: '345.343',
        ),
      ),
    );
  });

  group('UserController getUsers', () {
    test('returns a List<UserEntity> when repository call is successful',
        () async {
      final users = <UserEntity>[];
      when(() => mockRepository.getUsers(params: fakeParams))
          .thenAnswer((_) async => Right(users));

      final result = await userController.getUsers(params: fakeParams);

      expect(result, users);
    });

    test('throws UserControllerException when repository call fails', () async {
      const failureMessage = 'Failed to get users';
      when(() => mockRepository.getUsers(params: fakeParams)).thenAnswer(
          (_) async => const Left(FetchDataFailure(failureMessage)));

      expect(
        () => userController.getUsers(params: fakeParams),
        throwsA(isA<UserControllerException>()),
      );
    });
  });

  group('UserController getUserById', () {
    test('returns a UserEntity when repository call is successful', () async {
      when(() => mockRepository.getUserById(user.id))
          .thenAnswer((_) async => Right(user));

      final result = await userController.getUserById(user.id);

      expect(result, user);
    });

    test('throws UserControllerException when repository call fails', () async {
      const failureMessage = 'Failed to get users';
      when(() => mockRepository.getUserById(user.id)).thenAnswer(
          (_) async => const Left(FetchDataFailure(failureMessage)));

      expect(
        () => userController.getUserById(user.id),
        throwsA(isA<UserControllerException>()),
      );
    });
  });

  group('UserController createUser', () {
    test('returns a CartEntity when repository call is successful', () async {
      when(() => mockRepository.createUser(user))
          .thenAnswer((_) async => Right(user));

      final result = await userController.createUser(user);

      expect(result, user);
    });

    test('throws UserControllerException when repository call fails', () async {
      const failureMessage = 'Failed to get users';
      when(() => mockRepository.createUser(user)).thenAnswer(
          (_) async => const Left(FetchDataFailure(failureMessage)));

      expect(
        () => userController.createUser(user),
        throwsA(isA<UserControllerException>()),
      );
    });
  });
}
