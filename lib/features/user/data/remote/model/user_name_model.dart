import 'package:fake_api/features/user/domain/domain.dart';

class UserNameModel extends UserNameEntity {
  UserNameModel({
    required super.firstname,
    required super.lastname,
  });

  factory UserNameModel.fromJson(Map<String, dynamic> json) => UserNameModel(
        firstname: json['firstname'] ?? '',
        lastname: json['lastname'] ?? '',
      );

  factory UserNameModel.fromDomain(UserNameEntity userName) => UserNameModel(
        firstname: userName.firstname,
        lastname: userName.lastname,
      );

  Map<String, dynamic> toMap() => {
        'firstname': firstname,
        'lastname': lastname,
      };
}
