import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:flutter/material.dart';

class CustomContract extends StatelessWidget {
  final String text;
  final String textButton;
  final Function() onPressed;
  const CustomContract(
      {Key? key,
      required this.text,
      required this.textButton,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        LabelButton(text: textButton, onPressed: onPressed)
      ],
    );
  }
}
