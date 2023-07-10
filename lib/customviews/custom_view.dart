import 'package:carryvibemobile/customviews/constraint.dart';
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

class CustomListView extends StatelessWidget {
  final List<Widget> children;

  const CustomListView({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;

    final double usableScreenHeight = screenHeight - appBarHeight;

    return Container(
        height: usableScreenHeight,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: constraintDouble),
            child: ListView(children: children)));
  }
}
