import 'dart:convert';
import 'package:fake_api/core/core.dart';
import 'package:fake_api/features/auth/data/remote/model/model.dart';

class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._http);

  final HttpClient _http;

  Future<TokenModel> logIn(String username, String password) async {
    final data = jsonEncode({
      'username': username,
      'password': password,
    });
    final url = _http.url('/auth/login');
    final response = await _http.post(
      url,
      body: data,
    );
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final token = TokenModel.fromJson(body);
    return token;
  }
}
