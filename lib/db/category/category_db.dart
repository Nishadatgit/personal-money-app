import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanagement/models/category/category_model.dart';

const CATEGORY_DB_NAME = 'category_database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String id);
}

class CategoryDb implements CategoryDbFunctions {
  CategoryDb._internal();
  static CategoryDb instance = CategoryDb._internal();

  factory CategoryDb() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeList = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseList = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _category_DB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _category_DB.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _category_DB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _category_DB.values.toList();
  }

  Future<void> refreshUI() async {
    final _allCategories = await getCategories();

    incomeList.value.clear();
    expenseList.value.clear();

    await Future.forEach(
      _allCategories,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeList.value.add(category);
        } else {
          expenseList.value.add(category);
        }
      },
    );
    incomeList.notifyListeners();
    expenseList.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String id) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.delete(id);
    refreshUI();
  }
}
