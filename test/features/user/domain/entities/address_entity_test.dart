import 'package:fake_api/fake_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AddressEntity constructor initializes correctly', () {
    const address = AddressEntity(
      city: 'Sample City',
      street: 'Sample Street',
      number: 123,
      zipcode: '12345',
      geolocation: GeolocationEntity(lat: '12.345', long: '67.890'),
    );

    expect(address.city, 'Sample City');
    expect(address.street, 'Sample Street');
    expect(address.number, 123);
    expect(address.zipcode, '12345');
    expect(address.geolocation.lat, '12.345');
    expect(address.geolocation.long, '67.890');
  });
}
