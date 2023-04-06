import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thriftly/repositories/category/base_category.dart';
import 'package:thriftly/model/category_model.dart';

class CategoryRepository extends BaseCategoryRepository {
  final FirebaseFirestore _firebaseFirestore;

  CategoryRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Category>> getAllcategories() {
    return _firebaseFirestore.collection('categories').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Category.fromSnapshot(doc)).toList();
    });
  }
}