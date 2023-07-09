import 'package:carryvibemobile/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

// --> Primary Button
class PrimaryButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color color;
  final Color? textColor;

  const PrimaryButton({
    required this.text,
    required this.onPressed,
    this.color = appColor,
    this.textColor = null,
  });

  @override
  Widget build(BuildContext context) {
    return GFButton(
      onPressed: onPressed,
      text: text,
      shape: GFButtonShape.standard,
      type: GFButtonType.solid,
      size: GFSize.LARGE,
      color: color,
      textColor: textColor,
      blockButton: true,
    );
  }
}
// Primary Button<--

// --> LabelButton
class LabelButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const LabelButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
// LabelButton<--

