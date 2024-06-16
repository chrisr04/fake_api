import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

void main() {
  late UserRepositoryImpl repository;
  late MockUserRemoteDataSource mockRemoteDataSource;
  late FakeApiParams fakeParams;

  setUpAll(() {
    fakeParams = FakeApiParams();
    mockRemoteDataSource = MockUserRemoteDataSource();
    repository = UserRepositoryImpl(mockRemoteDataSource);
  });

  group('UserRepositoryImpl getUsers', () {
    test('should return a List<UserEntity> when remote data source succeeds',
        () async {
      final users = <UserModel>[];
      when(() => mockRemoteDataSource.getUsers(params: fakeParams))
          .thenAnswer((_) async => users);

      final result = await repository.getUsers(params: fakeParams);

      expect(result, isA<Right>());
      expect((result as Right).value, isA<List<UserEntity>>());
    });

    test('should return a Left(NoInternetFailure) when SocketException occurs',
        () async {
      when(() => mockRemoteDataSource.getUsers(params: fakeParams))
          .thenThrow(const SocketException('No internet'));

      final result = await repository.getUsers(params: fakeParams);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<NoInternetFailure>());
    });

    test(
        'should return a Left(InvalidResponseFailure) when FormatException occurs',
        () async {
      when(() => mockRemoteDataSource.getUsers(params: fakeParams))
          .thenThrow(const FormatException('Invalid response'));

      final result = await repository.getUsers(params: fakeParams);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<InvalidResponseFailure>());
    });

    test('should return Left(FetchDataFailure) on generic error', () async {
      when(() => mockRemoteDataSource.getUsers(params: fakeParams))
          .thenThrow(const NetworkException('NetworkException', 'Some error'));

      final result = await repository.getUsers(params: fakeParams);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<FetchDataFailure>());
    });
  });

  group('UserRepositoryImpl getUserById', () {
    const userId = 1;

    test('should return a UserEntity when remote data source succeeds',
        () async {
      when(() => mockRemoteDataSource.getUserById(userId))
          .thenAnswer((_) async => UserModel.fromJson({}));

      final result = await repository.getUserById(userId);

      expect(result, isA<Right>());
      expect((result as Right).value, isA<UserEntity>());
    });

    test('should return a Left(NoInternetFailure) when SocketException occurs',
        () async {
      when(() => mockRemoteDataSource.getUserById(userId))
          .thenThrow(const SocketException('No internet'));

      final result = await repository.getUserById(userId);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<NoInternetFailure>());
    });

    test(
        'should return a Left(InvalidResponseFailure) when FormatException occurs',
        () async {
      when(() => mockRemoteDataSource.getUserById(userId))
          .thenThrow(const FormatException('Invalid response'));

      final result = await repository.getUserById(userId);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<InvalidResponseFailure>());
    });

    test('should return a Left(FetchDataFailure) on generic error', () async {
      when(() => mockRemoteDataSource.getUserById(userId))
          .thenThrow(const NetworkException('NetworkException', 'Some error'));

      final result = await repository.getUserById(userId);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<FetchDataFailure>());
    });
  });

  group('UserRepositoryImpl createUser', () {
    const user = UserEntity(
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

    test('should return UserEntity when remote data source succeeds', () async {
      when(() => mockRemoteDataSource.createUser(user))
          .thenAnswer((_) async => UserModel.fromJson({}));

      final result = await repository.createUser(user);

      expect(result, isA<Right>());
      expect((result as Right).value, isA<UserEntity>());
    });

    test('should return Left(NoInternetFailure) when SocketException occurs',
        () async {
      when(() => mockRemoteDataSource.createUser(user))
          .thenThrow(const SocketException('No internet'));

      final result = await repository.createUser(user);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<NoInternetFailure>());
    });

    test(
        'should return Left(InvalidResponseFailure) when FormatException occurs',
        () async {
      when(() => mockRemoteDataSource.createUser(user))
          .thenThrow(const FormatException('Invalid response'));

      final result = await repository.createUser(user);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<InvalidResponseFailure>());
    });

    test('should return Left(FetchDataFailure) on generic error', () async {
      when(() => mockRemoteDataSource.createUser(user))
          .thenThrow(const NetworkException('NetworkException', 'Some error'));

      final result = await repository.createUser(user);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<FetchDataFailure>());
    });
  });
}
