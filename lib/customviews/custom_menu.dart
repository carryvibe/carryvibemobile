import 'package:carryvibemobile/util/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomMenu extends StatelessWidget {
  final Icon icon;
  final String title;
  const CustomMenu({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      avatar: icon,
      titleText: title,
      icon: const Icon(Icons.arrow_forward),
      color: Colors.white,
      onTap: () => {},
    );
  }
}
