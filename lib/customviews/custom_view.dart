import 'package:carryvibemobile/util/app_constants.dart';
import 'package:flutter/material.dart';

class CustomView extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;

  const CustomView({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: constraintDouble),
          child: Column(
            mainAxisAlignment: mainAxisAlignment,
            children: children,
          ),
        ),
      ),
    );
  }
}
