import 'dart:io';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/splash/splash_view.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
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

    return GestureDetector(
        onTap: () {
          Keyboard.shared().unfocus(context);
        },
        child: MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [const Locale('tr')],
          title: 'CarryVibe',
          theme: ThemeData(
            primarySwatch: primaryColor,
            appBarTheme: AppBarTheme(color: primaryColor),
            canvasColor: primaryColor,
          ),
          home: SplashScreen(),
        ));
  }
}
