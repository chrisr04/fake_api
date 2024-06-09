import 'package:fake_api/core/errors/errors.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:fake_api/core/http/interceptors/http_interceptor.dart';

class LogInterceptor extends HttpInterceptor {
  @override
  Future<Request> onRequest(Request request) async {
    debugPrint('*** REQUEST ***');
    debugPrint('uri: ${request.url}');
    debugPrint('method: ${request.method}');
    debugPrint('headers: {');
    for (final key in request.headers.keys) {
      debugPrint(' $key: ${request.headers[key]}');
    }
    debugPrint('}');
    debugPrint('body: ${request.body}\n');
    return request;
  }

  @override
  Future<Response> onResponse(Response response) async {
    debugPrint('*** RESPONSE ***');
    debugPrint('uri: ${response.request?.url}');
    debugPrint('method: ${response.request?.method}');
    debugPrint('statusCode: ${response.statusCode} ${response.reasonPhrase}');
    if (response.request != null) {
      debugPrint('headers: {');
      for (final key in response.headers.keys) {
        debugPrint(' $key: ${response.request?.headers[key]}');
      }
      debugPrint('}');
    }
    debugPrint('response: ${response.body}\n');
    return response;
  }

  @override
  Future<void> onError(
    NetworkException error,
    Response response,
  ) async {
    debugPrint('*** HTTP ERROR ***');
    debugPrint('uri: ${response.request?.url}');
    debugPrint('method: ${response.request?.method}');
    debugPrint('statusCode: ${response.statusCode} ${response.reasonPhrase}');
    if (response.request != null) {
      debugPrint('headers: {');
      for (final key in response.headers.keys) {
        debugPrint(' $key: ${response.request?.headers[key]}');
      }
      debugPrint('}');
    }
    debugPrint('error: ${error.message}\n');
  }
}
