import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'screens/expenses.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var kColorScheme = ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: const Color.fromARGB(255, 129, 128, 129),
    );
    var kDarkColorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 129, 128, 129),
    );
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(colorScheme: kDarkColorScheme),
      theme: ThemeData().copyWith(colorScheme: kColorScheme),
      home: const Expenses(),
    );
  }
}
