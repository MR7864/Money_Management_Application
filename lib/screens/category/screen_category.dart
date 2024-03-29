import 'package:flutter/material.dart';
import 'package:my_app/db/category/category_db.dart';
import 'package:my_app/screens/category/expense_category_list.dart';
import 'package:my_app/screens/category/income_category_list.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({Key? key}) : super(key: key);

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(indicatorSize: TabBarIndicatorSize.tab,
            controller: _tabController,
            splashBorderRadius: BorderRadius.circular(10),
            indicator: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(244, 28, 5, 74)),
            labelColor: Color.fromARGB(244, 235, 221, 255),
            tabs: const [
              Tab(text: 'INCOME'),
              Tab(text: 'EXPENSE'),
            ]),
        Expanded(
          child: TabBarView(controller: _tabController, children: const [
            IncomeCategoryList(),
            ExpenseCategoryList(),
          ]),
        )
      ],
    );
  }
}
