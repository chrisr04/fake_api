import 'package:fake_api/fake_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TokenEntity', () {
    test('should be initialized with a token', () {
      const token = '12345';
      const tokenEntity = TokenEntity(token: token);

      expect(tokenEntity.token, equals(token));
    });
  });
}
