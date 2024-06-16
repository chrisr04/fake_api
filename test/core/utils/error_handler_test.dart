import 'package:fake_api/fake_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'dart:convert';

import '../../mocks/core_mocks.dart';

void main() {
  late MockResponse mockResponse;

  setUpAll(() {
    mockResponse = MockResponse();
  });

  group('ErrorHandler', () {
    test('returns BadRequestException on 400 status code', () async {
      when(() => mockResponse.statusCode).thenReturn(400);
      when(() => mockResponse.body)
          .thenReturn(jsonEncode({'message': 'Bad Request'}));

      final error = await ErrorHandler.getError(mockResponse);

      expect(error, isA<BadRequestException>());
      expect(error.message, 'Bad Request');
    });

    test('returns NotFoundException on 404 status code', () async {
      when(() => mockResponse.statusCode).thenReturn(404);
      when(() => mockResponse.body)
          .thenReturn(jsonEncode({'message': 'Not Found'}));

      final error = await ErrorHandler.getError(mockResponse);

      expect(error, isA<NotFoundException>());
      expect(error.message, 'Not Found');
    });

    test('returns UnauthorizedException on 401 status code', () async {
      when(() => mockResponse.statusCode).thenReturn(401);
      when(() => mockResponse.body)
          .thenReturn(jsonEncode({'message': 'Unauthorized'}));

      final error = await ErrorHandler.getError(mockResponse);

      expect(error, isA<UnauthorizedException>());
      expect(error.message, 'Unauthorized');
    });

    test('returns ServerErrorException on 500 status code', () async {
      when(() => mockResponse.statusCode).thenReturn(500);
      when(() => mockResponse.body)
          .thenReturn(jsonEncode({'message': 'Server Error'}));

      final error = await ErrorHandler.getError(mockResponse);

      expect(error, isA<ServerErrorException>());
      expect(error.message, 'Server Error');
    });

    test('returns ServiceUnavailableException on 503 status code', () async {
      when(() => mockResponse.statusCode).thenReturn(503);
      when(() => mockResponse.body)
          .thenReturn(jsonEncode({'message': 'Service Unavailable'}));

      final error = await ErrorHandler.getError(mockResponse);

      expect(error, isA<ServiceUnavailableException>());
      expect(error.message, 'Service Unavailable');
    });

    test('returns NetworkException on unknown status code', () async {
      when(() => mockResponse.statusCode).thenReturn(418);
      when(() => mockResponse.body).thenReturn('Unknown Error');

      final error = await ErrorHandler.getError(mockResponse);

      expect(error, isA<NetworkException>());
      expect(error.message, 'Unknown Error');
    });

    test('returns raw body if message key is not present', () async {
      when(() => mockResponse.statusCode).thenReturn(400);
      when(() => mockResponse.body).thenReturn('Raw error message');

      final error = await ErrorHandler.getError(mockResponse);

      expect(error, isA<BadRequestException>());
      expect(error.message, 'Raw error message');
    });

    test('handles non-JSON body gracefully', () async {
      when(() => mockResponse.statusCode).thenReturn(400);
      when(() => mockResponse.body).thenReturn('<html>Error</html>');

      final error = await ErrorHandler.getError(mockResponse);

      expect(error, isA<BadRequestException>());
      expect(error.message, '<html>Error</html>');
    });
  });
}
