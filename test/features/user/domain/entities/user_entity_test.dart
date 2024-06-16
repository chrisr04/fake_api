import 'package:test/test.dart';
import 'package:fake_api/fake_api.dart';

void main() {
  group('UserEntity', () {
    test('should create a UserEntity instance', () {
      const id = 1;
      const name = UserNameEntity(
        firstname: 'John',
        lastname: 'Doe',
      );
      const username = 'johndoe';
      const email = 'john.doe@example.com';
      const phone = '123-456-7890';
      const address = AddressEntity(
        city: 'New York',
        street: '123 Main St',
        zipcode: '10001',
        number: 1,
        geolocation: GeolocationEntity(
          lat: '34.5464',
          long: '345.343',
        ),
      );

      const user = UserEntity(
        id: id,
        name: name,
        username: username,
        email: email,
        phone: phone,
        address: address,
      );

      expect(user.id, id);
      expect(user.name, name);
      expect(user.username, username);
      expect(user.email, email);
      expect(user.phone, phone);
      expect(user.address, address);
    });
  });
}
