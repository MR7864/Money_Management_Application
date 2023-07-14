import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/screens/home/screen_home.dart';

class MoneyManagerBottomNavigator extends StatelessWidget {
  const MoneyManagerBottomNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: ScreenHome.selectedIndexNotifier,
        builder: (BuildContext context, int updatedIndex, Widget? _) {
          return BottomNavigationBar(
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              currentIndex: updatedIndex,
              onTap: (newIndex) {
                ScreenHome.selectedIndexNotifier.value = newIndex;
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Transactions'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'Categorys')
              ]);
        });
  }
}
