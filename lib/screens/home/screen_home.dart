import 'package:flutter/material.dart';
import 'package:my_app/screens/add_transaction/screen_add_transaction.dart';
import 'package:my_app/screens/category/category_add_popup.dart';
import 'package:my_app/screens/category/screen_category.dart';
import 'package:my_app/screens/home/widgets/bottom_navigation.dart';
import 'package:my_app/screens/transactions/screen_transactions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [
    ScreenTransaction(),
    ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('MONEY MANAGER'),
        actions: [
          IconButton(
              onPressed: () {
                signout(context);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigator(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updateIndex, _) {
            return _pages[updateIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print('Add Transaction');
            Navigator.of(context).pushNamed(ScreenaddTransaction.routeName);
          } else {
            print('Add Category');
          }
          showCategoryAddPopup(context);
          //   final _sample = CategoryModel(
          //       id: DateTime.now().millisecondsSinceEpoch.toString(),
          //       name: 'Travel',
          //       type: categoryType.expense);
          //   CategoryDB().insertCategory(_sample);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  signout(BuildContext context) async {
    final _sharedprefs = await SharedPreferences.getInstance();
    await _sharedprefs.clear();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const ScreenLogin()),
        (route) => false);
  }
}
