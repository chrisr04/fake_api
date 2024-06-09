part of 'fake_api_controller_exception.dart';

class UserControllerException extends FakeApiControllerException {
  UserControllerException(String message)
      : super('UserControllerException', message);
}
