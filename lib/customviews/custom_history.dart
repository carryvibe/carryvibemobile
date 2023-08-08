import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class HistoryView extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const HistoryView({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      avatar: GFAvatar(
        child: Icon(Icons.history),
        backgroundColor: Colors.white,
      ),
      titleText: text,
      color: Colors.white,
      onTap: onPressed,
    );
  }
}
