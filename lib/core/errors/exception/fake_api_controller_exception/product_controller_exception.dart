part of 'fake_api_controller_exception.dart';

class ProductControllerException extends FakeApiControllerException {
  ProductControllerException(String message)
      : super('ProductControllerException', message);
}
