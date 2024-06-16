import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:fake_api/fake_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRepositoryImpl authRepository;
  late MockAuthRemoteDataSource mockRemoteDataSource;

  setUpAll(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    authRepository = AuthRepositoryImpl(mockRemoteDataSource);
  });

  group('AuthRepositoryImpl logIn', () {
    const username = 'test_username';
    const password = 'test_password';
    final token = TokenModel.fromJson({'token': '1234'});

    test(
        'should return Right(TokenEntity) when call to remote data source is successful',
        () async {
      when(() => mockRemoteDataSource.logIn(username, password))
          .thenAnswer((_) async => token);

      final result = await authRepository.logIn(username, password);

      expect(result, isA<Right>());
      expect((result as Right).value, isA<TokenEntity>());
    });

    test(
        'should return Left(NoInternetFailure) when there is a SocketException',
        () async {
      when(() => mockRemoteDataSource.logIn(username, password))
          .thenThrow(const SocketException('No Internet'));

      final result = await authRepository.logIn(username, password);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<NoInternetFailure>());
    });

    test(
        'should return Left(InvalidResponseFailure) when there is a FormatException',
        () async {
      when(() => mockRemoteDataSource.logIn(username, password))
          .thenThrow(const FormatException('Invalid Response'));

      final result = await authRepository.logIn(username, password);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<InvalidResponseFailure>());
    });

    test(
        'should return Left(FetchDataFailure) when there is a generic exception',
        () async {
      String errorMessage = 'Something went wrong';
      when(() => mockRemoteDataSource.logIn(username, password))
          .thenThrow(NetworkException('NetworkException', errorMessage));

      final result = await authRepository.logIn(username, password);

      expect(result, isA<Left>());
      expect((result as Left).value, isA<FetchDataFailure>());
    });
  });
}
