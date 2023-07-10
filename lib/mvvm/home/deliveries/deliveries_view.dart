import 'package:carryvibemobile/customviews/custom_ads.dart';
import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/ads_model.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:flutter/material.dart';

class DeliveriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DeliveriesScreen();
  }
}

class DeliveriesScreen extends StatefulWidget {
  @override
  _DeliveriesScreenState createState() => _DeliveriesScreenState();
}

class _DeliveriesScreenState extends State<DeliveriesScreen>
    with SingleTickerProviderStateMixin {
  AdsStatus selected = AdsStatus.sender;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomListView(children: [
      constraint,
      CustomSecondLabel(text: "Teslimatlarım"),
      CustomAds(
          date: "25 Haziran Pazar, 22:00",
          departure: "Küçükçekmece, İstanbul",
          destination: "Ümraniye, İstanbul",
          name: "Yunus Emre",
          avatar:
              "https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/68.png")
    ]);
  }
}
