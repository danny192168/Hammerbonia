import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HammerboniaApp());
}

class HammerboniaApp extends StatelessWidget {
  const HammerboniaApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Hammerbonia',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFFFF8EE),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFEB5E28)),
      fontFamily: 'Trebuchet MS',
      useMaterial3: true,
    ),
    home: const HomeScreen(),
  );
}
