import 'package:test/test.dart';
import 'package:fake_api/fake_api.dart';

void main() {
  group('AddressModel tests', () {
    test('fromJson creates AddressModel object correctly', () {
      Map<String, dynamic> json = {
        'geolocation': {
          'lat': '123.456',
          'lng': '789.012',
        },
        'city': 'Test City',
        'street': 'Test Street',
        'number': 42,
        'zipcode': '12345',
      };

      final addressModel = AddressModel.fromJson(json);

      expect(addressModel.geolocation, isA<GeolocationModel>());
      expect(addressModel.city, 'Test City');
      expect(addressModel.street, 'Test Street');
      expect(addressModel.number, 42);
      expect(addressModel.zipcode, '12345');
    });

    test('fromDomain converts AddressEntity to AddressModel correctly', () {
      final addressEntity = AddressEntity(
        geolocation: GeolocationModel(lat: '123.456', long: '789.012'),
        city: 'Test City',
        street: 'Test Street',
        number: 42,
        zipcode: '12345',
      );

      final addressModel = AddressModel.fromDomain(addressEntity);

      expect(addressModel.geolocation, addressEntity.geolocation);
      expect(addressModel.city, 'Test City');
      expect(addressModel.street, 'Test Street');
      expect(addressModel.number, 42);
      expect(addressModel.zipcode, '12345');
    });

    test('toMap converts AddressModel to Map correctly', () {
      final addressModel = AddressModel(
        geolocation: GeolocationModel(
          lat: '123.456',
          long: '789.012',
        ),
        city: 'Test City',
        street: 'Test Street',
        number: 42,
        zipcode: '12345',
      );

      final result = addressModel.toMap();

      expect(result['geolocation'], isA<Map<String, dynamic>>());
      expect(result['city'], 'Test City');
      expect(result['street'], 'Test Street');
      expect(result['number'], 42);
      expect(result['zipcode'], '12345');
    });
  });
}
