import 'dart:convert';

import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/util/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomAds extends StatelessWidget {
  final String image;
  final String date;
  final String departure;
  final String destination;
  final String avatar;
  final String name;
  final Function() onPressed;
  final Function() onLongPress;
  const CustomAds(
      {Key? key,
      required this.image,
      required this.date,
      required this.departure,
      required this.destination,
      required this.name,
      required this.avatar,
      required this.onPressed,
      required this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      avatar: image != ""
          ? Image.memory(
              base64Decode(image),
              width: 40,
            )
          : AppIcon(
              assest: IconAssest.logo,
              width: 40,
            ),
      title: CustomSecondLabel(text: date),
      subTitle: LocationLabels(departure: departure, destination: destination),
      color: Colors.white,
      description: Row(
        children: [
          GFAvatar(
              backgroundImage: NetworkImage(avatar),
              shape: GFAvatarShape.circle),
          const SizedBox(
            width: 8,
          ),
          Text(name)
        ],
      ),
      onLongPress: onLongPress,
      onTap: onPressed,
    );
  }
}
