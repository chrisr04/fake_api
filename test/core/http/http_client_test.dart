import 'dart:convert';
import 'dart:typed_data';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:fake_api/fake_api.dart';
import 'package:mocktail/mocktail.dart';

class MockInterceptor extends HttpInterceptor {}

class MockErrorHandler extends Mock implements ErrorHandler {}

void main() {
  late HttpClient httpClient;
  late MockInterceptor mockInterceptor;
  late MockClient mockClient;

  group('HttpClient', () {
    setUp(() {
      mockClient = MockClient(
        (request) async => Response(jsonEncode({"data": "test"}), 200),
      );
      mockInterceptor = MockInterceptor();
      httpClient = HttpClient(
        mockClient,
        baseUrl: 'https://example.com',
        interceptors: [mockInterceptor],
      );
    });

    tearDown(() {
      httpClient.close();
    });

    test('url method returns the complete Uri', () async {
      final url = httpClient.url('/test', queryParameters: {'limit': 2});

      expect(url.toString(), 'https://example.com/test?limit=2');
    });

    test('head method sends a HEAD request and returns response', () async {
      final url = httpClient.url('/test');
      final result = await httpClient.head(url);

      expect(result.statusCode, 200);
      expect(result.body, '{"data":"test"}');
    });

    test('get method sends a GET request and returns response', () async {
      final url = httpClient.url('/test');
      final result = await httpClient.get(url);

      expect(result.statusCode, 200);
      expect(result.body, '{"data":"test"}');
    });

    test('post method sends a POST request and returns response', () async {
      final url = httpClient.url('/test');
      final result = await httpClient.post(
        url,
        headers: {'Content-Type': 'application/json'},
        encoding: const Utf8Codec(),
        body: '{"name": "test"}',
      );

      expect(result.statusCode, 200);
      expect(result.body, '{"data":"test"}');
    });

    test('put method sends a PUT request and returns response', () async {
      final url = httpClient.url('/test');
      final result = await httpClient.put(
        url,
        body: {"name": "test"},
      );

      expect(result.statusCode, 200);
      expect(result.body, '{"data":"test"}');
    });

    test('patch method sends a PATCH request and returns response', () async {
      final url = httpClient.url('/test');
      final result = await httpClient.patch(url, body: Uint32List.fromList([]));

      expect(result.statusCode, 200);
      expect(result.body, '{"data":"test"}');
    });

    test('delete method sends a DELETE request and returns response', () async {
      final url = httpClient.url('/test');
      final result = await httpClient.delete(url);

      expect(result.statusCode, 200);
      expect(result.body, '{"data":"test"}');
    });
  });

  group('HttpClient Errors', () {
    setUp(() {
      mockClient = MockClient(
        (request) async => Response(jsonEncode({"message": "not found"}), 404),
      );
      mockInterceptor = MockInterceptor();
      httpClient = HttpClient(
        mockClient,
        baseUrl: 'https://example.com',
        baseHeaders: {'Content-Type': 'application/json'},
        interceptors: [mockInterceptor],
      );
    });

    tearDown(() {
      httpClient.close();
    });

    test(
        'should returns a NetworkException when the statusCode of response is greather than or equal to 400',
        () async {
      final url = httpClient.url('/test');
      expect(
        () => httpClient.get(url),
        throwsA(isA<NetworkException>()),
      );
    });

    test('should returns an ArgumentError when invalid request is sent',
        () async {
      final url = httpClient.url('/test');
      expect(
        () => httpClient.post(url, body: -1),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
