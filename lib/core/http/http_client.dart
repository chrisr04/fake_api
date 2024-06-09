import 'dart:convert';
import 'package:http/http.dart';
import 'package:fake_api/core/errors/errors.dart';
import 'package:fake_api/core/http/interceptors/http_interceptor.dart';
import 'package:fake_api/core/http/method/http_method.dart';
import 'package:fake_api/core/utils/error_handler.dart';

class HttpClient extends BaseClient {
  HttpClient(
    this._client, {
    this.baseUrl = '',
    this.baseHeaders = const {},
    this.interceptors = const [],
  });

  final Client _client;
  final String baseUrl;
  final Map<String, String> baseHeaders;
  final List<HttpInterceptor> interceptors;

  @override
  Future<Response> head(Uri url, {Map<String, String>? headers}) =>
      _sendRequest(HttpMethod.head.method, url, headers);

  @override
  Future<Response> get(Uri url, {Map<String, String>? headers}) =>
      _sendRequest(HttpMethod.get.method, url, headers);

  @override
  Future<Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      _sendRequest(HttpMethod.post.method, url, headers, body, encoding);

  @override
  Future<Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      _sendRequest(HttpMethod.put.method, url, headers, body, encoding);

  @override
  Future<Response> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      _sendRequest(HttpMethod.patch.method, url, headers, body, encoding);

  @override
  Future<Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      _sendRequest(HttpMethod.delete.method, url, headers, body, encoding);

  @override
  Future<StreamedResponse> send(BaseRequest request) => _client.send(request);

  Uri url(String path, {Map<String, dynamic>? queryParameters}) =>
      Uri.parse('$baseUrl$path').replace(
        queryParameters: queryParameters?.map(
          (key, value) => MapEntry(key, value.toString()),
        ),
      );

  Future<Response> _sendRequest(
    String method,
    Uri url,
    Map<String, String>? headers, [
    Object? body,
    Encoding? encoding,
  ]) async {
    Request request = Request(method, url);

    request.headers.addAll(baseHeaders);

    if (headers != null) request.headers.addAll(headers);
    if (encoding != null) request.encoding = encoding;

    if (body != null) {
      if (body is String) {
        request.body = body;
      } else if (body is List) {
        request.bodyBytes = body.cast<int>();
      } else if (body is Map) {
        request.bodyFields = body.cast<String, String>();
      } else {
        throw ArgumentError('Invalid request body "$body".');
      }
    }

    request = await _interceptRequest(request);

    Response response = await Response.fromStream(await send(request));

    if (response.statusCode >= 400) {
      final error = await ErrorHandler.getError(response);
      await _interceptError(error, response);
      throw error;
    }

    response = await _interceptResponse(response);

    return response;
  }

  Future<Request> _interceptRequest(Request request) async {
    Request interceptedRequest = request;
    for (final interceptor in interceptors) {
      interceptedRequest = await interceptor.onRequest(request);
    }
    return interceptedRequest;
  }

  Future<void> _interceptError(
    NetworkException error,
    Response response,
  ) async {
    for (final interceptor in interceptors) {
      await interceptor.onError(error, response);
    }
  }

  Future<Response> _interceptResponse(Response response) async {
    Response interceptedResponse = response;
    for (final interceptor in interceptors) {
      interceptedResponse = await interceptor.onResponse(response);
    }
    return interceptedResponse;
  }

  @override
  void close() => _client.close();
}
