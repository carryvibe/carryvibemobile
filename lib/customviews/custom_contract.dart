import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:flutter/gestures.dart';
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
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: (text + " "),
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(fontSize: AppConstants.fontSizeLarge),
        children: <TextSpan>[
          TextSpan(
            text: textButton,
            style: const TextStyle(
              color: appColor,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = onPressed,
          )
        ],
      ),
    );
  }
}
