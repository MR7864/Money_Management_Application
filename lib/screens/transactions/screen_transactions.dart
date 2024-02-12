import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/db/category/category_db.dart';
import 'package:my_app/db/transactions/transaction_db.dart';
import 'package:my_app/models/category/category_model.dart';

import '../../models/transaction/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder:
          (BuildContext context, List<TransactionModel> newList, Widget? _) {
        return ListView.separated(
          padding: const EdgeInsets.all(10),
          //Values
          itemBuilder: (context, index) {
            final _value = newList[index];
            return Dismissible(
              key: Key(_value.id!),
              child: Card(
                child: ListTile(
                  leading: Stack(
                    children: [
                      Container(
                        width: 50, // Set the desired width
                        height: 50, // Set the desired height
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _value.type == categoryType.income
                              ? Colors.green
                              : Colors.red,
                          borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
                        ),
                        child: Text(
                          parseDate(_value.date),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14, // Set the desired font size
                            color: Colors.white, // Set the text color
                            fontWeight: FontWeight.bold, // Set the font weight if needed
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: Text('RS ${_value.amount}'),
                  subtitle: Text(_value.category.name),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: newList.length,
        );
      },
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedData = _date.split(' ');
    return '${_splitedData.last}\n${_splitedData.first}';
    //return '${date.day}\n${date.month}';
  }
}
