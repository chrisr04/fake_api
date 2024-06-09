import 'dart:convert';
import 'package:fake_api/core/core.dart';
import 'package:fake_api/features/product/data/remote/model/product_model.dart';

class ProductRemoteDataSource {
  const ProductRemoteDataSource(this._http);

  final HttpClient _http;

  Future<List<ProductModel>> getProducts({
    FakeApiParams? params,
  }) async {
    final url = _http.url('/products', queryParameters: params?.toMap());
    final response = await _http.get(url);
    final body = jsonDecode(response.body) as List;
    final products = body.map((e) => ProductModel.fromJson(e)).toList();
    return products;
  }

  Future<ProductModel> getProductById(int id) async {
    final url = _http.url('/products/$id');
    final response = await _http.get(url);
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final product = ProductModel.fromJson(body);
    return product;
  }

  Future<List<String>> getCategories() async {
    final url = _http.url('/products/categories');
    final response = await _http.get(url);
    final body = jsonDecode(response.body);
    final categories = List<String>.from(body);
    return categories;
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final url = _http.url('/products/category/$category');
    final response = await _http.get(url);
    final body = jsonDecode(response.body) as List;
    final products = body.map((e) => ProductModel.fromJson(e)).toList();
    return products;
  }
}
