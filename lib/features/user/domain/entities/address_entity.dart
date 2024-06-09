import 'package:fake_api/features/user/domain/entities/geolocation_entity.dart';

class AddressEntity {
  const AddressEntity({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  final GeolocationEntity geolocation;
  final String city;
  final String street;
  final int number;
  final String zipcode;
}
