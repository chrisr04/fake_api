part 'auth_controller_exception.dart';
part 'user_controller_exception.dart';
part 'product_controller_exception.dart';
part 'cart_controller_exception.dart';

class FakeApiControllerException implements Exception {
  FakeApiControllerException(this._prefix, this.message);

  final String _prefix;
  final String message;

  @override
  String toString() => '$_prefix:\n\t$message';
}
