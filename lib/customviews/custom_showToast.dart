import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomShowToast extends StatelessWidget {
  final String text;
  final BuildContext contextToast;
  const CustomShowToast(
      {Key? key, required this.text, required this.contextToast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFToast.showToast(text, contextToast,
        toastPosition: GFToastPosition.BOTTOM);
  }
}
