import 'package:carryvibemobile/customviews/custom_ads.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/ads_model.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/enums.dart';
import 'package:flutter/material.dart';

class CarrierAdsView extends StatelessWidget {
  final List<CarrierAdsModel> carrierAdsModel;
  const CarrierAdsView({required this.carrierAdsModel});
  @override
  Widget build(BuildContext context) {
    return CarrierAdsScreen(carrierAdsModel: carrierAdsModel);
  }
}

class CarrierAdsScreen extends StatefulWidget {
  final List<CarrierAdsModel> carrierAdsModel;
  const CarrierAdsScreen({required this.carrierAdsModel});
  @override
  _CarrierAdsScreenState createState() =>
      _CarrierAdsScreenState(carrierAdsModel: carrierAdsModel);
}

class _CarrierAdsScreenState extends State<CarrierAdsScreen>
    with SingleTickerProviderStateMixin {
  final List<CarrierAdsModel> carrierAdsModel;
  _CarrierAdsScreenState({required this.carrierAdsModel});
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> getCustomAds() {
      return carrierAdsModel.map((e) {
        return CustomAds(
          image: e.photoFirst ?? "",
          date: (e.departureTime ?? "") + "\n" + (e.destinationTime ?? ""),
          departure: e.departureCity ?? "",
          destination: e.destinationCity ?? "",
          name: e.userName ?? "",
          avatar: e.userAvatar ?? "",
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
