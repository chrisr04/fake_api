import 'package:fake_api/features/user/domain/entities/address_entity.dart';
import 'package:fake_api/features/user/domain/entities/user_name_entity.dart';

class UserEntity {
  const UserEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.address,
  });

  final int id;
  final UserNameEntity name;
  final String username;
  final String email;
  final String phone;
  final AddressEntity address;
}
