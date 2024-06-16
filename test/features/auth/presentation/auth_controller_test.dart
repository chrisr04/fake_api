import 'package:fake_api/fake_api.dart';
import 'package:test/test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthController authController;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authController = AuthController(mockAuthRepository);
  });

  group('AuthController logIn', () {
    const username = 'testuser';
    const password = 'testpassword';
    const token = TokenEntity(token: 'dummy_token');
    const failure = FetchDataFailure('Login failed');

    test('should return TokenEntity when login is successful', () async {
      when(() => mockAuthRepository.logIn(username, password))
          .thenAnswer((_) async => const Right(token));

      final result = await authController.logIn(username, password);

      expect(result, token);
    });

    test('should throw AuthControllerException when login fails', () async {
      when(() => mockAuthRepository.logIn(username, password))
          .thenAnswer((_) async => const Left(failure));

      final call = authController.logIn;

      expect(() => call(username, password),
          throwsA(isA<AuthControllerException>()));
    });
  });
}
