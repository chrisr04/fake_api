part of 'network_exception.dart';

class ServiceUnavailableException extends NetworkException {
  ServiceUnavailableException(String message)
      : super('ServiceUnavailableException', message);
}
