import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const LoveApp());
}

class LoveApp extends StatelessWidget {
  const LoveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Love App',
      theme: AppTheme.theme,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
