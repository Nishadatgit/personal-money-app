import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/models/category/category_model.dart';

class ScreenaddTransaction extends StatelessWidget {
  const ScreenaddTransaction({Key? key}) : super(key: key);
  static const routeName = 'add-transaction';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 10.0, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Purpose'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.calendar_today,
                color: Colors.pink,
              ),
              label: const Text(
                'Select Date',
                style: TextStyle(color: Colors.pink),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Row(
                  children: [
                    Radio(
                        value: CategoryType.income,
                        groupValue: CategoryType.income,
                        onChanged: (value) {}),
                    const Text('Income'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: CategoryType.income,
                        groupValue: CategoryType.expense,
                        onChanged: (value) {}),
                    const Text('Expense'),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButton(
                hint: const Text('Select category'),
                items: CategoryDb().expenseList.value.map((e) {
                  return DropdownMenuItem(
                    child: Text(e.name),
                    value: e.id,
                  );
                }).toList(),
                onChanged: (selectedval) {}),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Submit'))
          ],
        ),
      )),
    );
  }
}
