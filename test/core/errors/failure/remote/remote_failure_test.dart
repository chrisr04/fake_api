import 'package:fake_api/fake_api.dart';
import 'package:test/test.dart';

void main() {
  group('RemoteFailure', () {
    test('should create an instance with the correct message and statusCode',
        () {
      const message = 'An error occurred';
      const statusCode = 404;

      const failure = RemoteFailure(message, statusCode: statusCode);

      expect(failure.message, message);
      expect(failure.statusCode, statusCode);
    });

    test('should create an instance with the correct message and no statusCode',
        () {
      const message = 'An error occurred';

      const failure = RemoteFailure(message);

      expect(failure.message, message);
      expect(failure.statusCode, isNull);
    });

    test(
        'toString should return the correct string when statusCode is provided',
        () {
      const message = 'An error occurred';
      const statusCode = 404;

      const failure = RemoteFailure(message, statusCode: statusCode);

      expect(failure.toString(),
          'Remote Failure: $message\nStatus Code: $statusCode');
    });

    test(
        'toString should return the correct string when statusCode is not provided',
        () {
      const message = 'An error occurred';

      const failure = RemoteFailure(message);

      expect(failure.toString(), 'Remote Failure: $message\nStatus Code: ');
    });
  });
}
