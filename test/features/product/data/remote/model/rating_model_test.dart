import 'package:test/test.dart';
import 'package:fake_api/fake_api.dart';

void main() {
  group('RatingModel', () {
    test('fromJson should correctly parse JSON', () {
      final json = {
        'rate': 4.5,
        'count': 100,
      };

      final ratingModel = RatingModel.fromJson(json);

      expect(ratingModel.rate, equals(json['rate']));
      expect(ratingModel.count, equals(json['count']));
    });
  });
}
