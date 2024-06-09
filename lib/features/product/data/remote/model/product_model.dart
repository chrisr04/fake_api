import 'package:fake_api/features/product/domain/domain.dart';
import 'package:fake_api/features/product/data/remote/model/rating_model.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
    required super.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        price: json['price']?.toDouble() ?? 0.0,
        description: json['description'] ?? '',
        category: json['category'] ?? '',
        image: json['image'] ?? '',
        rating: RatingModel.fromJson(json['rating'] ?? {}),
      );
}
