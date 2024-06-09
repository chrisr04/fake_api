import 'package:fake_api/features/auth/domain/domain.dart';

class TokenModel extends TokenEntity {
  const TokenModel({required super.token});

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        token: json['token'] ?? '',
      );
}
