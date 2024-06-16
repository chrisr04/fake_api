import 'package:fake_api/fake_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GeolocationEntity', () {
    test('should create a GeolocationEntity instance', () {
      const String lat = '37.7749';
      const String long = '-122.4194';

      const geolocationEntity = GeolocationEntity(
        lat: lat,
        long: long,
      );

      expect(geolocationEntity.lat, lat);
      expect(geolocationEntity.long, long);
    });
  });
}
