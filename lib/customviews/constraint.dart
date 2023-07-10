import 'package:flutter/material.dart';

const constraint = SizedBox(height: 16.0);

class ScreenSize {
  static final ScreenSize _shared = ScreenSize._internal();
  factory ScreenSize.shared() {
    return _shared;
  }
  ScreenSize._internal();

  double width(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double appBarHeight = AppBar().preferredSize.height;
  double tabBarHeight = Tab().preferredSize.height;
}
