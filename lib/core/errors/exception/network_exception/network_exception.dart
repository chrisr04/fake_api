part 'not_found_exception.dart';
part 'unauthorized_exception.dart';
part 'bad_request_exception.dart';
part 'server_error_exception.dart';
part 'service_unavailable_exception.dart';

class NetworkException implements Exception {
  const NetworkException(this._prefix, this.message);

  final String _prefix;
  final String message;

  @override
  String toString() => '$_prefix: $message';
}
