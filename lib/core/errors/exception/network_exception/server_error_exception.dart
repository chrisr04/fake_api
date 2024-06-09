part of 'network_exception.dart';

class ServerErrorException extends NetworkException {
  ServerErrorException(String message) : super('ServerErrorException', message);
}
