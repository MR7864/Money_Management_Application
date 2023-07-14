// ignore_for_file: empty_statements

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_app/db/category/category_db.dart';
import 'package:my_app/models/category/category_model.dart';
import 'package:my_app/models/transaction/transaction_model.dart';
import 'package:my_app/screens/add_transaction/screen_add_transaction.dart';
import 'package:my_app/screens/splash.dart';

// ignore: constant_identifier_names
const SAVE_KEY_NAME = 'UserLoggedIn';

Future<void> main() async {
  final odj1 = CategoryDB();
  final odj2 = CategoryDB();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(categoryTypeAdapter().typeId)) {
    Hive.registerAdapter(categoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Sample',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const ScreenSplash(),
      routes: {
        ScreenaddTransaction.routeName: (ctx) => const ScreenaddTransaction(),
      },
    );
  }
}
