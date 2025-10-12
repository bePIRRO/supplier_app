import 'package:flutter/material.dart';
import 'design/design_system.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supplier App',
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}
