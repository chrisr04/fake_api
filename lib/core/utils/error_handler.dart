import 'dart:convert';
import 'package:http/http.dart';
import 'package:fake_api/core/errors/exception/exception.dart';

class ErrorHandler {
  static Future<NetworkException> getError(Response response) async {
    final error = await getMessage(response);
    switch (response.statusCode) {
      case 400:
        return BadRequestException(error);
      case 404:
        return NotFoundException(error);
      case 401:
        return UnauthorizedException(error);
      case 500:
        return ServerErrorException(error);
      case 503:
        return ServiceUnavailableException(error);
      default:
        return NetworkException('NetworkException', error);
    }
  }

  static Future<String> getMessage(Response response) async {
    final body = response.body;
    try {
      final error = jsonDecode(body);
      if (error is Map<String, dynamic> && error.containsKey('message')) {
        return error['message'] as String;
      }
    } catch (_) {}
    return body;
  }
}
