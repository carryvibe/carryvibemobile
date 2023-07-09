import 'dart:async';
import 'package:carryvibemobile/mvvm/app/app_view.dart';
import 'package:carryvibemobile/mvvm/app/app_viewmodel.dart';
import 'package:carryvibemobile/util/app_icon.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  final AppViewModel _viewModel = AppViewModel();
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      // Splash ekranının görüntülenme süresini 2 saniye olarak ayarla
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AppView(viewModel: _viewModel)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: AppIcon(assest: IconAssest.logo)),
    );
  }
}
