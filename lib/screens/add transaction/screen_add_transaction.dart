import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/db/transaction/transaction_db.dart';
import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';

class ScreenaddTransaction extends StatefulWidget {
  const ScreenaddTransaction({Key? key}) : super(key: key);
  static const routeName = 'add-transaction';

  @override
  State<ScreenaddTransaction> createState() => _ScreenaddTransactionState();
}

class _ScreenaddTransactionState extends State<ScreenaddTransaction> {
  DateTime? _selectedDate;
  String? _displayDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  String? _categoryID;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[500],
        elevation: 0,
        title: const Text('Add transaction'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: _purposeTextEditingController,
                  decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                      hintText: 'Purpose'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 100,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _amountTextEditingController,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Amount',
                    hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton.icon(
                onPressed: () async {
                  final tempSelectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now(),
                  );

                  var dateTime = DateTime.parse(tempSelectedDate.toString());
                  var formattedDate =
                      "${dateTime.year}-${dateTime.month}-${dateTime.day}";
                  formattedDate = Jiffy(formattedDate).yMMMMd;

                  setState(() {
                    _displayDate = formattedDate;
                    _selectedDate = tempSelectedDate;
                  });
                },
                icon: const Icon(
                  Icons.calendar_today,
                  color: Colors.pink,
                ),
                label: Text(
                  _selectedDate == null
                      ? 'Select Date'
                      : _displayDate.toString().trim(),
                  style: const TextStyle(color: Colors.pink),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 230,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: CategoryType.income,
                            groupValue: _selectedCategoryType,
                            onChanged: (CategoryType? value) {
                              setState(() {
                                _selectedCategoryType = value;
                                _categoryID = null;
                              });
                            }),
                        const Text('Income'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                            value: CategoryType.expense,
                            groupValue: _selectedCategoryType,
                            onChanged: (CategoryType? value) {
                              setState(() {
                                _selectedCategoryType = value;
                                _categoryID = null;
                              });
                            }),
                        const Text('Expense'),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton(
                      value: _categoryID,
                      dropdownColor: Colors.grey[200],
                      underline: Container(
                        height: 2,
                        color: Colors.grey[100],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      hint: const Text(
                        'Select category',
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                      items: (_selectedCategoryType == CategoryType.expense
                              ? CategoryDb().expenseList
                              : CategoryDb().incomeList)
                          .value
                          .map((e) {
                        return DropdownMenuItem(
                          child: Text(e.name),
                          value: e.id,
                          onTap: () {
                            _selectedCategoryModel = e;
                          },
                        );
                      }).toList(),
                      onChanged: (String? selectedval) {
                        setState(() {
                          _categoryID = selectedval;
                        });
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 75.0),
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                          side: const BorderSide(color: Colors.grey),
                        ),
                      ),
                      onPressed: () {
                        addTransaction();
                      },
                      child: const Text('Submit')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;

    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }

    // if (_categoryID == null) {
    //   return;
    // }

    if (_selectedCategoryModel == null) {
      return;
    }

    if (_selectedDate == null) {
      return;
    }
    final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null) {
      return;
    }

    final _model = TransactionModel(
      purpose: _purposeText,
      amount: _parsedAmount,
      date: _selectedDate!,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!,
    );

    TransactionDB.instance.addTransaction(_model);
  }
}
