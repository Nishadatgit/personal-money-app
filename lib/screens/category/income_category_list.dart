import 'package:flutter/material.dart';

class IncomeCategory extends StatelessWidget {
  const IncomeCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 0,
          child: ListTile(
            title: Text('Income Data'),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete),
            ),
          ),
        );
      },
      separatorBuilder: (ctx, index) {
        return SizedBox(height: 10);
      },
      itemCount: 10,
    );
  }
}
