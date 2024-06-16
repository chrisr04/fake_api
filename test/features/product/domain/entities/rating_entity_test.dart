import 'package:fake_api/fake_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RatingEntity', () {
    test('should create a RatingEntity with given rate and count', () {
      const double rate = 4.5;
      const int count = 100;

      const ratingEntity = RatingEntity(rate: rate, count: count);

      expect(ratingEntity.rate, equals(rate));
      expect(ratingEntity.count, equals(count));
    });
  });
}
