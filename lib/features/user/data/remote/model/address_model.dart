import 'package:fake_api/features/user/domain/domain.dart';
import 'package:fake_api/features/user/data/remote/model/geolocation_model.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    required super.geolocation,
    required super.city,
    required super.street,
    required super.number,
    required super.zipcode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        geolocation: GeolocationModel.fromJson(json['geolocation'] ?? {}),
        city: json['city'] ?? '',
        street: json['street'] ?? '',
        number: json['number'] ?? 0,
        zipcode: json['zipcode'] ?? '',
      );

  factory AddressModel.fromDomain(AddressEntity address) => AddressModel(
        geolocation: address.geolocation,
        city: address.city,
        street: address.street,
        number: address.number,
        zipcode: address.zipcode,
      );

  Map<String, dynamic> toMap() => {
        'geolocation': GeolocationModel.fromDomain(geolocation).toMap(),
        'city': city,
        'street': street,
        'number': number,
        'zipcode': zipcode,
      };
}
