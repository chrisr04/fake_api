import 'package:fake_api/fake_api.dart';
import 'package:test/test.dart';

void main() {
  group('UserNameModel', () {
    test('fromJson creates a UserNameModel instance correctly', () {
      Map<String, dynamic> json = {
        'firstname': 'John',
        'lastname': 'Doe',
      };

      final userNameModel = UserNameModel.fromJson(json);

      expect(userNameModel.firstname, 'John');
      expect(userNameModel.lastname, 'Doe');
    });

    test('toMap returns a map with firstname and lastname', () {
      final userNameModel = UserNameModel(firstname: 'Jane', lastname: 'Smith');

      final result = userNameModel.toMap();

      expect(result['firstname'], 'Jane');
      expect(result['lastname'], 'Smith');
    });

    test('fromDomain converts UserNameEntity to UserNameModel correctly', () {
      const userNameEntity = UserNameEntity(
        firstname: 'Alex',
        lastname: 'Brown',
      );

      final userNameModel = UserNameModel.fromDomain(userNameEntity);

      expect(userNameModel.firstname, 'Alex');
      expect(userNameModel.lastname, 'Brown');
    });
  });
}
