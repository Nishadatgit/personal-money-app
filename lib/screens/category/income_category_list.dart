import 'package:flutter/material.dart';
import 'package:moneymanagement/models/category/category_model.dart';

import '../../db/category/category_db.dart';

class IncomeCategory extends StatelessWidget {
  const IncomeCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDb().incomeList,
        builder: (BuildContext ctx, List<CategoryModel> newList, _) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final category = newList[index];
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    title: Text(category.name),
                    trailing: IconButton(
                      onPressed: () {
                        CategoryDb.instance.deleteCategory(category.id);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(height: 10);
            },
            itemCount: newList.length,
          );
        });
  }
}
