import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? prefixIcon;
  final bool obscureText;
  ValueChanged<String>? onChanged;

  CustomTextField({
    required this.controller,
    required this.labelText,
    this.prefixIcon,
    this.obscureText = false,
    this.onChanged = null,
  });

  @override
  Widget build(BuildContext context) {
    return GFTextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: onChanged,
    );
  }
}

class OtpTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final FocusNode focusNode;
  ValueChanged<String>? onChanged;

  OtpTextField({
    required this.controller,
    required this.focusNode,
    this.obscureText = false,
    this.onChanged = null,
  });

  @override
  Widget build(BuildContext context) {
    return GFTextField(
      controller: controller,
      focusNode: focusNode,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      maxLength: 1,
      decoration: const InputDecoration(
        counterText: '',
        contentPadding: EdgeInsets.all(10.0),
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}

class CustomTitleLineTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String labelText;
  final IconData? prefixIcon;
  final bool obscureText;
  ValueChanged<String>? onChanged;
  final Function()? onTap;

  CustomTitleLineTextField({
    required this.controller,
    required this.title,
    required this.labelText,
    this.prefixIcon,
    this.obscureText = false,
    this.onChanged = null,
    this.onTap = null,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomSecondLabel(
        text: title,
        align: TextAlign.left,
      ),
      GFTextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
        ),
        onChanged: onChanged,
        onTap: onTap,
      )
    ]);
  }
}
