import 'dart:convert';

import 'package:thriftly/product_Api/productapiservice.dart';
import 'package:thriftly/product_Api/productmodel.dart';
import 'package:http/http.dart' as http;

abstract class ProductRepositoryApi {
  Stream<List<ProductApi>> getAllProducts();
}

class ProductRepositoryImpl implements ProductRepositoryApi {
  final String baseUrl;

  ProductRepositoryImpl({required this.baseUrl});

  @override
  Stream<List<ProductApi>> getAllProducts() async* {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final products = data.map((json) => ProductApi(
        id: json['id'],
        name: json['title'],
        description: json['description'],
        price: json['price'].toDouble(),
      )).toList();
      yield products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
/*
abstract class BaseProductRepository {
  Future<List<Product>> getAllProducts();
}

class ProductRepositoryApi extends BaseProductRepository {
  final ProductApiProvider _apiProvider = ProductApiProvider();

  @override
  Future<List<Product>> getAllProducts() async {
    return _apiProvider.getAllProducts();
  }
}

 */