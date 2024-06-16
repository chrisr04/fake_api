import 'package:fake_api/fake_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TokenModel', () {
    test('should create an instance with the given token', () {
      const token = 'testToken';
      const tokenModel = TokenModel(token: token);

      expect(tokenModel.token, equals(token));
    });

    test('should create an instance from JSON', () {
      final json = {'token': 'testToken'};
      final tokenModel = TokenModel.fromJson(json);

      expect(tokenModel.token, equals('testToken'));
    });

    test('should handle missing token in JSON by setting it to empty string',
        () {
      final json = <String, dynamic>{};
      final tokenModel = TokenModel.fromJson(json);

      expect(tokenModel.token, equals(''));
    });

    test('should handle null token in JSON by setting it to empty string', () {
      final json = {'token': null};
      final tokenModel = TokenModel.fromJson(json);

      expect(tokenModel.token, equals(''));
    });
  });
}
