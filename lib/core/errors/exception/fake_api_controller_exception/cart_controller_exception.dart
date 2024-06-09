part of 'fake_api_controller_exception.dart';

class CartControllerException extends FakeApiControllerException {
  CartControllerException(String message)
      : super('CartControllerException', message);
}
