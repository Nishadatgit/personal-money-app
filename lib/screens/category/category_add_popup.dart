import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/models/category/category_model.dart';

final selectedValueNotifier = ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          backgroundColor: Colors.white.withOpacity(1),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text('Add category'),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, right: 20, left: 20, bottom: 10),
              child: TextFormField(
                autofocus: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'type something';
                  }
                  return null;
                },
                controller: _nameEditingController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  isDense: true,
                  hintText: 'Category Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  RadioButton(title: 'Income', type: CategoryType.income),
                  RadioButton(title: 'Expense', type: CategoryType.expense)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.pink.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () {
                  final _name = _nameEditingController.text;
                  if (_name.isEmpty) {
                    return;
                  }
                  final _type = selectedValueNotifier.value;
                  final _category = CategoryModel(
                      name: _name,
                      type: _type,
                      id: DateTime.now().microsecondsSinceEpoch.toString());
                  CategoryDb().insertCategory(_category);
                  Navigator.of(ctx).pop();
                },
                child: const Text('Add'),
              ),
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  //final CategoryType selectedCategoryType;

  RadioButton({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ValueListenableBuilder(
          valueListenable: selectedValueNotifier,
          builder: (BuildContext ctx, CategoryType newValue, Widget? _) {
            return Radio<CategoryType>(
                value: type,
                groupValue: newValue,
                onChanged: (value) {
                  print(value);
                  if (value == null) {
                    return;
                  }
                  selectedValueNotifier.value = value;
                  selectedValueNotifier.notifyListeners();
                });
          }),
      Text(title)
    ]);
  }
}
