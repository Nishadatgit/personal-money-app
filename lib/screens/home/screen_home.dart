import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/screens/add%20transaction/screen_add_transaction.dart';
import 'package:moneymanagement/screens/category/category_add_popup.dart';
import 'package:moneymanagement/screens/category/screen_category.dart';
import 'package:moneymanagement/screens/home/widgets/bottom_navigation.dart';
import 'package:moneymanagement/screens/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [ScreenTransaction(), ScreenCatogory()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Money Manager'),
        centerTitle: true,
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: selectedIndexNotifier,
            builder: (BuildContext ctx, int updatedIndex, Widget? _) {
              return _pages[updatedIndex];
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print('Add transaction');
            Navigator.of(context).pushNamed(ScreenaddTransaction.routeName);
          } else {
            showCategoryAddPopup(context);
          }
        },
        child:const Icon(Icons.add),
      ),
    );
  }
}
