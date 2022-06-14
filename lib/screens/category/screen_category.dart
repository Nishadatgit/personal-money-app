import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/screens/category/expense_category_list.dart';
import 'package:moneymanagement/screens/category/income_category_list.dart';

class ScreenCatogory extends StatefulWidget {
  const ScreenCatogory({Key? key}) : super(key: key);

  @override
  State<ScreenCatogory> createState() => _ScreenCatogoryState();
}

class _ScreenCatogoryState extends State<ScreenCatogory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'INCOME'),
              Tab(
                text: 'EXPENSE',
              )
            ]),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              IncomeCategory(),
              ExpenseCategory(),
            ],
          ),
        )
      ],
    );
  }
}
