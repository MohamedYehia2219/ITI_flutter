import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quotes_app/data/datasource/remote/ApiService.dart';
import 'data/datasource/remote/constants.dart';
import 'home.dart';
import 'model/quote.dart';

Future<void> main() async {
  await Hive.initFlutter();
  QuoteBox = await Hive.openBox<Quote>('Quotes');
  Hive.registerAdapter(QuoteAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuoteScreen(),
    );
  }
}
