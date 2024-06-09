part of 'network_exception.dart';

class UnauthorizedException extends NetworkException {
  UnauthorizedException(String message)
      : super('UnauthorizedException', message);
}
