import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thriftly/model/productModel.dart';
import 'package:thriftly/repositories/product/base_product.dart';
import 'package:http/http.dart' as http;


class ProductRepository {
  static const String _baseUrl = "https://fakestoreapi.com/"; // Mock api

  Future<List<Product>> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + "products"));
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
        return parsed.map<Product>((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<Product> getProductById(String id) async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + "products/$id"));
      if (response.statusCode == 200) {
        return Product.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }
}
/*
class ProductRepository extends BaseProductRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProductRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Product>> getAllProducts() {
    return _firebaseFirestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }
}

 */