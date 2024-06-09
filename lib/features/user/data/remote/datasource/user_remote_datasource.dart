import 'dart:convert';
import 'package:fake_api/fake_api.dart';
import 'package:fake_api/features/user/data/remote/model/model.dart';

class UserRemoteDataSource {
  const UserRemoteDataSource(this._http);

  final HttpClient _http;

  Future<List<UserModel>> getUsers({FakeApiParams? params}) async {
    final url = _http.url(
      '/users',
      queryParameters: params?.toMap(),
    );
    final response = await _http.get(url);
    final body = jsonDecode(response.body) as List;
    final users = body.map((e) => UserModel.fromJson(e)).toList();
    return users;
  }

  Future<UserModel> getUserById(int id) async {
    final url = _http.url('/users/$id');
    final response = await _http.get(url);
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final user = UserModel.fromJson(body);
    return user;
  }

  Future<UserModel> createUser(UserEntity user) async {
    final data = jsonEncode(UserModel.fromDomain(user).toMap());
    final url = _http.url('/users');
    final response = await _http.post(url, body: data);
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final createduser = UserModel.fromJson(body);
    return createduser;
  }
}
