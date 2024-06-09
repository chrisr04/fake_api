import 'package:fake_api/core/errors/errors.dart';
import 'package:http/http.dart';

abstract class HttpInterceptor {
  Future<Request> onRequest(Request request) async => request;
  Future<Response> onResponse(Response response) async => response;
  Future<void> onError(NetworkException error, Response response) async {}
}
