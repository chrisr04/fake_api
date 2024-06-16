import 'dart:convert';
import 'package:fake_api/fake_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../mocks/core_mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late AuthRemoteDataSource dataSource;

  setUpAll(() {
    mockHttpClient = MockHttpClient();
    dataSource = AuthRemoteDataSource(mockHttpClient);
  });

  group('AuthRemoteDataSource logIn', () {
    test('should returns TokenModel on successful login', () async {
      const username = 'test_user';
      const password = 'test_pass';
      final url = Uri.parse('https://example.com/auth/login');
      final response = MockResponse();
      final responseBody = jsonEncode({
        'username': username,
        'password': password,
      });
      final responseJson = jsonEncode({
        'token': 'abc123',
      });

      when(() => mockHttpClient.url('/auth/login')).thenReturn(url);

      when(
        () => mockHttpClient.post(
          url,
          body: responseBody,
        ),
      ).thenAnswer((_) async => response);

      when(() => response.body).thenReturn(responseJson);

      final tokenModel = await dataSource.logIn(username, password);

      expect(tokenModel.token, 'abc123');
    });

    test('should throws NetworkException on failure login', () async {
      const username = 'test_user';
      const password = 'test_pass';
      final url = Uri.parse('https://example.com/auth/login');
      final responseBody = jsonEncode({
        'username': username,
        'password': password,
      });

      when(() => mockHttpClient.url('/auth/login')).thenReturn(url);

      when(
        () => mockHttpClient.post(
          url,
          body: responseBody,
        ),
      ).thenThrow(
        const NetworkException('NetworkException', 'Somthing went wrong'),
      );

      expect(
        () => dataSource.logIn(username, password),
        throwsA(isA<NetworkException>()),
      );
    });
  });
}
