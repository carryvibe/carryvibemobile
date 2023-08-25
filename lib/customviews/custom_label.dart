import 'package:carryvibemobile/util/app_constants.dart';
import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign align;
  const CustomLabel(
      {Key? key,
      required this.text,
      this.textStyle = null,
      this.align = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle ??
          robotoBlack.copyWith(fontSize: AppConstants.fontSizeOverLarge),
      textAlign: align,
    );
  }
}

class CustomSecondLabel extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign align;
  const CustomSecondLabel(
      {Key? key,
      required this.text,
      this.textStyle = null,
      this.align = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle ??
          robotoBold.copyWith(fontSize: AppConstants.fontSizeExtraLarge),
      textAlign: align,
    );
  }
}

class CustomSubLabel extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign align;
  const CustomSubLabel(
      {Key? key,
      required this.text,
      this.textStyle = null,
      this.align = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle ??
          robotoRegular.copyWith(fontSize: AppConstants.fontSizeLarge),
      textAlign: align,
    );
  }
}

class LocationLabels extends StatelessWidget {
  final String departure;
  final String destination;

  LocationLabels({required this.departure, required this.destination});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: departure + '\n',
        style: robotoRegular.copyWith(
            fontSize: AppConstants.fontSizeDefault, color: Colors.black),
        children: [
          const WidgetSpan(
            child: Icon(
              Icons.arrow_downward_sharp,
              size: 16,
            ),
          ),
          TextSpan(
            text: '\n' + destination + '\n',
            style:
                robotoRegular.copyWith(fontSize: AppConstants.fontSizeDefault),
          ),
        ],
      ),
    );
  }
}
