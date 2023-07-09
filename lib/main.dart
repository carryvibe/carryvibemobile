import 'package:carryvibemobile/mvvm/splash/splash_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    MaterialColor primaryColor = MaterialColor(0xFF01928B, {
      50: Color(0xFFF1FAF9),
      100: Color(0xFFD9F2F0),
      200: Color(0xFFB1EAE4),
      300: Color(0xFF89E2D8),
      400: Color(0xFF61DACC),
      500: Color(0xFF39D2C0),
      600: Color(0xFF11CAB4),
      700: Color(0xFF00BBA5),
      800: Color(0xFF00A996),
      900: Color(0xFF008B78),
    });

    return MaterialApp(
      title: 'CarryVibe',
      theme: ThemeData(primarySwatch: primaryColor),
      home: SplashScreen(),
    );
  }
}
