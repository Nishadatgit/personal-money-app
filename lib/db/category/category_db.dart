import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagement/models/category/category_model.dart';

const CATEGORY_DB_NAME = 'category_database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
}

class CategoryDb implements CategoryDbFunctions {
  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _category_DB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _category_DB.add(value);
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _category_DB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _category_DB.values.toList();
  }
}
