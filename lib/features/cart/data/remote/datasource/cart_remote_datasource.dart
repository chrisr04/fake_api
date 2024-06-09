import 'dart:convert';
import 'package:fake_api/core/core.dart';
import 'package:fake_api/features/cart/domain/domain.dart';
import 'package:fake_api/features/cart/data/remote/model/model.dart';

class CartRemoteDataSource {
  const CartRemoteDataSource(this._http);

  final HttpClient _http;

  Future<List<CartModel>> getCarts({FakeApiParams? params}) async {
    final url = _http.url(
      '/carts',
      queryParameters: params?.toMap(),
    );
    final response = await _http.get(url);
    final body = jsonDecode(response.body) as List;
    final carts = body.map((e) => CartModel.fromJson(e)).toList();
    return carts;
  }

  Future<CartModel> getCartById(int id) async {
    final url = _http.url('/carts/$id');
    final response = await _http.get(url);
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final cart = CartModel.fromJson(body);
    return cart;
  }

  Future<List<CartModel>> getCartsByUser(
    int userId, {
    FakeApiParams? params,
  }) async {
    final url = _http.url(
      '/carts/user/$userId',
      queryParameters: params?.toMap(),
    );
    final response = await _http.get(url);
    final body = jsonDecode(response.body) as List;
    final carts = body.map((e) => CartModel.fromJson(e)).toList();
    return carts;
  }

  Future<CartModel> createCart(CartEntity cart) async {
    final data = jsonEncode(CartModel.fromDomain(cart).toMap());
    final url = _http.url('/carts');
    final response = await _http.post(url, body: data);
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final createdCart = CartModel.fromJson(body);
    return createdCart;
  }

  Future<CartModel> updateCart(CartEntity cart) async {
    final data = jsonEncode(CartModel.fromDomain(cart).toMap());
    final url = _http.url('/carts/${cart.id}');
    final response = await _http.put(url, body: data);
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final createdCart = CartModel.fromJson(body);
    return createdCart;
  }

  Future<CartModel> deleteCart(int cartId) async {
    final url = _http.url('/carts/$cartId');
    final response = await _http.delete(url);
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final createdCart = CartModel.fromJson(body);
    return createdCart;
  }
}
