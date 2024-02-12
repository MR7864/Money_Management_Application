import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/screens/home/screen_home.dart';

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
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.black,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
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
