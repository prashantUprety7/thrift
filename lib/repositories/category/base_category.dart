
import '../../model/category_model.dart';

abstract class BaseCategoryRepository {
  Stream<List<Category>>getAllcategories();
}