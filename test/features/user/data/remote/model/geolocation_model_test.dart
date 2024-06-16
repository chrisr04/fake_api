import 'package:test/test.dart';
import 'package:fake_api/fake_api.dart';

void main() {
  group('GeolocationModel', () {
    test('fromJson converts JSON correctly', () {
      final Map<String, dynamic> json = {
        'lat': '40.7128',
        'long': '-74.0060',
      };

      final model = GeolocationModel.fromJson(json);

      expect(model.lat, '40.7128');
      expect(model.long, '-74.0060');
    });

    test('fromDomain converts GeolocationEntity correctly', () {
      const geolocationEntity =
          GeolocationEntity(lat: '34.0522', long: '-118.2437');

      var model = GeolocationModel.fromDomain(geolocationEntity);

      expect(model.lat, '34.0522');
      expect(model.long, '-118.2437');
    });

    test('toMap converts to Map<String, dynamic> correctly', () {
      final model = GeolocationModel(lat: '51.5074', long: '-0.1278');

      final map = model.toMap();

      expect(map['lat'], '51.5074');
      expect(map['long'], '-0.1278');
    });
  });
}
