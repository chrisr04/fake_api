part of 'network_exception.dart';

class BadRequestException extends NetworkException {
  BadRequestException(String message) : super('BadRequestException', message);
}
