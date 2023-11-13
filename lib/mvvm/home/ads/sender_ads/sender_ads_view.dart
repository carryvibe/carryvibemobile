import 'package:carryvibemobile/customviews/custom_ads.dart';
import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/ads_model.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/enums.dart';
import 'package:flutter/material.dart';

class SenderAdsView extends StatelessWidget {
  final List<SenderAdsModel> senderAdsModel;
  const SenderAdsView({required this.senderAdsModel});
  @override
  Widget build(BuildContext context) {
    return SenderAdsScreen(senderAdsModel: senderAdsModel);
  }
}

class SenderAdsScreen extends StatefulWidget {
  final List<SenderAdsModel> senderAdsModel;
  const SenderAdsScreen({required this.senderAdsModel});
  @override
  _SenderAdsScreenState createState() =>
      _SenderAdsScreenState(senderAdsModel: senderAdsModel);
}

class _SenderAdsScreenState extends State<SenderAdsScreen>
    with SingleTickerProviderStateMixin {
  final List<SenderAdsModel> senderAdsModel;
  _SenderAdsScreenState({required this.senderAdsModel});
  AdsStatus selected = AdsStatus.sender;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> getCustomAds() {
      if (senderAdsModel.isEmpty) {
        return [CustomSubLabel(text: "İlan bulunamadı")];
      }
      return senderAdsModel.map((e) {
        return CustomAds(
          image: e.photoFirst ?? "",
          date: e.content ?? "",
          departure: e.departureCity ?? "",
          destination: e.destinationCity ?? "",
          name: e.userName ?? "",
          avatar: e.userAvatar ??
              "https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/68.png",
        );
      }).toList();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Kargo İlanları'),
        ),
        body: CustomListView(
            service: Service.shared(),
            constraint: false,
            children: getCustomAds()));
  }
}
