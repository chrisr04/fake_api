import 'dart:convert';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fake_api/fake_api.dart';

import '../../../../../mocks/core_mocks.dart';

void main() {
  late UserRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;

  late UserEntity user;

  setUpAll(() {
    mockHttpClient = MockHttpClient();
    dataSource = UserRemoteDataSource(mockHttpClient);
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

  group('UserRemoteDataSource getUsers', () {
    test('should returns a List<UserModel> on successful response', () async {
      final url = Uri.parse('https://example.com/users');
      final response = MockResponse();
      final parmas = FakeApiParams();
      final responseJson = jsonEncode([]);

      when(
        () => mockHttpClient.url(
          '/users',
          queryParameters: parmas.toMap(),
        ),
      ).thenReturn(url);

      when(
        () => mockHttpClient.get(url),
      ).thenAnswer((_) async => response);

      when(() => response.body).thenReturn(responseJson);

      final carts = await dataSource.getUsers(params: parmas);

      expect(carts, isA<List<UserModel>>());
    });

    test('should throws a NetworkException on failure response', () async {
      final url = Uri.parse('https://example.com/users');
      final response = MockResponse();

      when(() => mockHttpClient.url('/users')).thenReturn(url);

      when(
        () => mockHttpClient.get(url),
      ).thenAnswer((_) async => response);

      when(() => response.body).thenThrow(
        const NetworkException('NetworkException', 'Somthing went wrong'),
      );

      expect(
        () => dataSource.getUsers(),
        throwsA(isA<NetworkException>()),
      );
    });
  });

  group('UserRemoteDataSource getUserById', () {
    test('should returns a UserModel on successful response', () async {
      const userId = 1;
      final url = Uri.parse('https://example.com/users/$userId');
      final response = MockResponse();
      final responseJson = jsonEncode({});

      when(() => mockHttpClient.url('/users/$userId')).thenReturn(url);

      when(
        () => mockHttpClient.get(url),
      ).thenAnswer((_) async => response);

      when(() => response.body).thenReturn(responseJson);

      final carts = await dataSource.getUserById(userId);

      expect(carts, isA<UserModel>());
    });

    test('should throws a NetworkException on failure response', () async {
      const userId = 1;
      final url = Uri.parse('https://example.com/users/$userId');

      when(() => mockHttpClient.url('/users/$userId')).thenReturn(url);

      when(
        () => mockHttpClient.get(url),
      ).thenThrow(
        const NetworkException('NetworkException', 'Something went wrong'),
      );

      expect(
        () => dataSource.getUserById(userId),
        throwsA(isA<NetworkException>()),
      );
    });
  });

  group('UserRemoteDataSource createUser', () {
    test('should returns a UserModel on successful response', () async {
      final url = Uri.parse('https://example.com/users');
      final response = MockResponse();
      final responseBody = jsonEncode(UserModel.fromDomain(user).toMap());
      final responseJson = jsonEncode({});

      when(() => mockHttpClient.url('/users')).thenReturn(url);

      when(
        () => mockHttpClient.post(
          url,
          body: responseBody,
        ),
      ).thenAnswer((_) async => response);

      when(() => response.body).thenReturn(responseJson);

      final carts = await dataSource.createUser(user);

      expect(carts, isA<UserModel>());
    });

    test('should throws a NetworkException on failure response', () async {
      final url = Uri.parse('https://example.com/users');
      final responseBody = jsonEncode(UserModel.fromDomain(user).toMap());

      when(() => mockHttpClient.url('/users')).thenReturn(url);

      when(
        () => mockHttpClient.post(
          url,
          body: responseBody,
        ),
      ).thenThrow(
        const NetworkException('NetworkException', 'Something went wrong'),
      );

      expect(
        () => dataSource.createUser(user),
        throwsA(isA<NetworkException>()),
      );
    });
  });
}
