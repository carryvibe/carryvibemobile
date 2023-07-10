import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:carryvibemobile/util/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomAds extends StatelessWidget {
  final String date;
  final String departure;
  final String destination;
  final String avatar;
  final String name;
  const CustomAds(
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
        avatar: AppIcon(
          assest: IconAssest.money,
          width: 32,
        ),
        title: CustomSecondLabel(text: date),
        subTitle:
            LocationLabels(departure: departure, destination: destination),
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
        ));
  }
}
