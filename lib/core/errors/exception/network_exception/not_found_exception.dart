part of 'network_exception.dart';

class NotFoundException extends NetworkException {
  NotFoundException(String message) : super('NotFoundException', message);
}
