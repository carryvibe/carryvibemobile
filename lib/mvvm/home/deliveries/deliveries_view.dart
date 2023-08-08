import 'package:carryvibemobile/customviews/custom_ads.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/enums.dart';
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
    return CustomListView(
        service: Service.shared(),
        constraint: false,
        children: [
          CustomAds(
              image: "",
              date: "25 Haziran Pazar, 22:00",
              departure: "Küçükçekmece, İstanbul",
              destination: "Ümraniye, İstanbul",
              name: "Yunus Emre",
              avatar:
                  "https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/68.png"),
          CustomAds(
              image: "",
              date: "25 Haziran Pazar, 22:00",
              departure: "Küçükçekmece, İstanbul",
              destination: "Ümraniye, İstanbul",
              name: "Yunus Emre",
              avatar:
                  "https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/68.png"),
        ]);
  }
}
