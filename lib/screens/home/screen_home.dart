import 'package:flutter/material.dart';
import 'package:my_app/screens/Analytics/screen_analytics.dart';
import 'package:my_app/screens/add_transaction/screen_add_transaction.dart';
import 'package:my_app/screens/category/category_add_popup.dart';
import 'package:my_app/screens/category/screen_category.dart';
import 'package:my_app/screens/home/widgets/bottom_navigation.dart';
import 'package:my_app/screens/transactions/screen_transactions.dart';
import 'package:my_app/models/transaction/transaction_model.dart';
import 'package:my_app/models/category/category_model.dart';
import 'package:my_app/db/category/category_db.dart';
import 'package:my_app/db/transactions/transaction_db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = [
    ScreenTransaction(),
    ScreenCategory(),
    Builder(
      builder: (context) {
        final incomeTransactions = TransactionDB
            .instance.transactionListNotifier.value
            .where((transaction) => transaction.type == categoryType.income)
            .toList();
        final expenseTransactions = TransactionDB
            .instance.transactionListNotifier.value
            .where((transaction) => transaction.type == categoryType.expense)
            .toList();
        return ScreenAnalytics(
          incomeTransactions: incomeTransactions,
          expenseTransactions: expenseTransactions,
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[00],
      appBar: buildAppBar(context),
      bottomNavigationBar: MoneyManagerBottomNavigator(
        selectedIndexNotifier: selectedIndexNotifier,
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updateIndex, _) {
            return _pages[updateIndex];
          },
        ),
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: selectedIndexNotifier,
        builder: (BuildContext context, int updateIndex, _) {
          if (updateIndex == 2) {
            return SizedBox.shrink();
          } else {
            return FloatingActionButton(
              onPressed: () {
                if (selectedIndexNotifier.value == 0) {
                  print('Add Transaction');
                  Navigator.of(context)
                      .pushNamed(ScreenaddTransaction.routeName);
                } else {
                  print('Add Category');
                  showCategoryAddPopup(context);
                }
              },
              child: const Icon(Icons.add),
            );
          }
        },
      ),
    );
  }

AppBar? buildAppBar(BuildContext context) {
  if (selectedIndexNotifier.value == 2) {
    return null; // Hide AppBar for ScreenAnalytics
  } else {
    return AppBar(
      title: const Text(
        'MONEY MANAGER',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            signout(context);
          },
          child: Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Color.fromARGB(244, 28, 5, 74),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.exit_to_app,
              color: Color.fromARGB(244, 235, 221, 255),
            ),
          ),
        ),
      ],
    );
  }
}


  void signout(BuildContext context) async {
    final _sharedprefs = await SharedPreferences.getInstance();
    await _sharedprefs.clear();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const ScreenLogin()),
        (route) => false);
  }
}

class MoneyManagerBottomNavigator extends StatelessWidget {
  final ValueNotifier<int> selectedIndexNotifier;

  const MoneyManagerBottomNavigator({
    Key? key,
    required this.selectedIndexNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedIndexNotifier,
      builder: (BuildContext context, int updatedIndex, Widget? _) {
        return Container(
          padding: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            child: BottomNavigationBar(
              backgroundColor: Color.fromARGB(244, 234, 221, 255),
              selectedItemColor: Color.fromARGB(244, 28, 5, 74),
              unselectedItemColor: Color.fromARGB(255, 143, 143, 143),
              selectedFontSize: 13,
              unselectedFontSize: 13,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              currentIndex: updatedIndex,
              onTap: (newIndex) {
                selectedIndexNotifier.value = newIndex;
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Transactions',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.analytics),
                  label: 'Analytics',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
