import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:moneymanagement/db/transaction/transaction_db.dart';
import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionNotifier,
        builder: (ctx, List<TransactionModel> newList, _) {
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (ctx, index) {
              final transaction = newList[index];
              var dateTime = DateTime.parse(transaction.date.toString());
              var formattedDate =
                  "${dateTime.year}-${dateTime.month}-${dateTime.day}";
              formattedDate = Jiffy(formattedDate).yMMMMd;

              return Card(
                color: transaction.category.type == CategoryType.income
                    ? Colors.pink[400]!
                    : Colors.grey[400]!,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 5,
                child: ListTile(
                  title: Text('Rs .${transaction.amount}'),
                  subtitle: Text(
                    transaction.category.name.toUpperCase(),
                    style: TextStyle(
                        color: Colors.grey[200],
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Text(
                      formattedDate.trim(),
                      style: const TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: newList.length,
          );
        });
  }
}
