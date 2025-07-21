import 'package:flutter/material.dart';
import 'screens/expenses.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var kColorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 129, 128, 129),
    );
    return MaterialApp(
      theme: ThemeData().copyWith(colorScheme: kColorScheme),
      home: const Expenses(),
    );
  }
}
