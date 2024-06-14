import 'package:fake_api/features/user/domain/domain.dart';
import 'package:fake_api/features/user/data/remote/model/address_model.dart';
import 'package:fake_api/features/user/data/remote/model/user_name_model.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.username,
    required super.email,
    required super.phone,
    required super.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? 0,
        name: UserNameModel.fromJson(json['name'] ?? {}),
        username: json['username'] ?? '',
        email: json['email'] ?? '',
        phone: json['phone'] ?? '',
        address: AddressModel.fromJson(json['address'] ?? {}),
      );

  factory UserModel.fromDomain(UserEntity user) => UserModel(
        id: user.id,
        name: user.name,
        username: user.username,
        email: user.email,
        phone: user.phone,
        address: user.address,
      );

  Map<String, dynamic> toMap() => {
        'name': UserNameModel.fromDomain(name).toMap(),
        'username': username,
        'email': email,
        'phone': phone,
        'address': AddressModel.fromDomain(address).toMap(),
      };
}
