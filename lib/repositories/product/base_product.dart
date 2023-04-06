


import '../../model/productModel.dart';

abstract class BaseProductRepository {
  Stream<List<Product>>getAllProducts();
}