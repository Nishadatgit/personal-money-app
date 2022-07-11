import 'package:flutter/material.dart';
import 'package:moneymanagement/screens/home/screen_home.dart';

import '../../../db/transaction/transaction_db.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 10,
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 15,
          currentIndex: updatedIndex,
          onTap: (newIndex) {
             TransactionDB.instance.refreshUi();
            ScreenHome.selectedIndexNotifier.value = newIndex;
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Transactions'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.category,
                ),
                label: 'Categories')
          ],
        );
      },
    );
  }
}
