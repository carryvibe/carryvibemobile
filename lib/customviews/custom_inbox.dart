import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomInbox extends StatelessWidget {
  final String date;
  final String departure;
  final String destination;
  final String avatar;
  final String name;
  const CustomInbox(
      {Key? key,
      required this.date,
      required this.departure,
      required this.destination,
      required this.name,
      required this.avatar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      avatar: GFAvatar(
        backgroundImage: NetworkImage(avatar),
      ),
      titleText: name,
      subTitleText: departure + '>' + destination + '\n' + date,
      icon: Icon(Icons.arrow_forward_ios),
      color: Colors.white,
      onTap: () => {},
    );
  }
}
