import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction_db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getTransaction();
}

class TransactionDB implements TransactionDbFunctions {
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);

    await _db.put(obj.id, obj);
  }

  @override
  Future<List<TransactionModel>> getTransaction() async {
    final _transactions =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _transactions.values.toList();
  }

  ValueNotifier<List<TransactionModel>> transactionNotifier = ValueNotifier([]);

  Future<void> refreshUi() async {
    final allTransactions = await getTransaction();
    transactionNotifier.value.clear();
    Future.forEach(allTransactions, (TransactionModel transaction) {
      transactionNotifier.value.add(transaction);
    });
    transactionNotifier.notifyListeners();
  }
}
