import 'package:test/test.dart';
import 'package:fake_api/fake_api.dart';

void main() {
  group('UserModel', () {
    test('fromJson should create a valid instance from JSON', () {
      final json = {
        'id': 1,
        'name': {
          'firstname': 'John',
          'lastname': 'Doe',
        },
        'username': 'johndoe',
        'email': 'john.doe@example.com',
        'phone': '123-456-7890',
        'address': {
          'street': '123 Elm St',
          'city': 'Springfield',
          'zipcode': '12345',
          'number': 2,
          'geolocation': {
            'lat': '2524',
            'long': '3463',
          },
        },
      };

      final userModel = UserModel.fromJson(json);

      expect(userModel.id, 1);
      expect(userModel.name.firstname, 'John');
      expect(userModel.name.lastname, 'Doe');
      expect(userModel.username, 'johndoe');
      expect(userModel.email, 'john.doe@example.com');
      expect(userModel.phone, '123-456-7890');
      expect(userModel.address.street, '123 Elm St');
      expect(userModel.address.city, 'Springfield');
      expect(userModel.address.zipcode, '12345');
      expect(userModel.address.number, 2);
      expect(userModel.address.geolocation.lat, '2524');
      expect(userModel.address.geolocation.long, '3463');
    });

    test('toMap should convert UserModel to a map', () {
      const userEntity = UserEntity(
        id: 1,
        name: UserNameEntity(firstname: 'Jane', lastname: 'Smith'),
        username: 'janesmith',
        email: 'jane.smith@example.com',
        phone: '987-654-3210',
        address: AddressEntity(
          street: '456 Oak St',
          city: 'Maplewood',
          zipcode: '54321',
          number: 2,
          geolocation: GeolocationEntity(
            lat: '345',
            long: '245346',
          ),
        ),
      );

      final userModel = UserModel.fromDomain(userEntity);
      final map = userModel.toMap();

      expect(map['name']['firstname'], 'Jane');
      expect(map['name']['lastname'], 'Smith');
      expect(map['username'], 'janesmith');
      expect(map['email'], 'jane.smith@example.com');
      expect(map['phone'], '987-654-3210');
      expect(map['address']['street'], '456 Oak St');
      expect(map['address']['city'], 'Maplewood');
      expect(map['address']['zipcode'], '54321');
      expect(map['address']['number'], 2);
      expect(map['address']['geolocation']['lat'], '345');
      expect(map['address']['geolocation']['long'], '245346');
    });
  });
}
