import 'package:flutter/material.dart';
import 'design/design_system.dart';
import 'screens/home_screen.dart';

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
      home: const HomeScreen(), // Changed to HomeScreen to showcase the UI
      // home: const LoginScreen(), // Use this for login flow
    );
  }
}
