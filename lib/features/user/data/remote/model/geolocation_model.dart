import 'package:fake_api/features/user/domain/domain.dart';

class GeolocationModel extends GeolocationEntity {
  GeolocationModel({
    required super.lat,
    required super.long,
  });

  factory GeolocationModel.fromJson(Map<String, dynamic> json) =>
      GeolocationModel(
        lat: json['lat'] ?? '',
        long: json['long'] ?? '',
      );

  factory GeolocationModel.fromDomain(GeolocationEntity geolocation) =>
      GeolocationModel(
        lat: geolocation.lat,
        long: geolocation.long,
      );

  Map<String, dynamic> toMap() => {
        'lat': lat,
        'long': long,
      };
}
