import 'package:test/test.dart';
import 'package:fake_api/fake_api.dart';

void main() {
  group('UserNameEntity', () {
    test('should create a UserNameEntity with given first and last names', () {
      const firstName = 'John';
      const lastName = 'Doe';

      const userName = UserNameEntity(firstname: firstName, lastname: lastName);

      expect(userName.firstname, equals(firstName));
      expect(userName.lastname, equals(lastName));
    });
  });
}
