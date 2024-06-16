import 'package:test/test.dart';
import 'package:fake_api/fake_api.dart';

void main() {
  group('FakeApiControllerException', () {
    test('should correctly format the exception message', () {
      const prefix = 'Error';
      const message = 'Something went wrong';
      final exception = FakeApiControllerException(prefix, message);

      final result = exception.toString();

      expect(result, equals('$prefix: $message'));
    });
  });
}
