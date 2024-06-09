part of 'fake_api_controller_exception.dart';

class AuthControllerException extends FakeApiControllerException {
  AuthControllerException(String message)
      : super('AuthControllerException', message);
}
