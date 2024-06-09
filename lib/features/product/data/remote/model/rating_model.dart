import 'package:fake_api/features/product/domain/domain.dart';

class RatingModel extends RatingEntity {
  RatingModel({
    required super.rate,
    required super.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        rate: json['rate']?.toDouble() ?? 0.0,
        count: json['count'] ?? 0,
      );
}
