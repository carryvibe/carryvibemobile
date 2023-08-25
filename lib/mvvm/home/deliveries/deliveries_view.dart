import 'package:carryvibemobile/customviews/custom_ads.dart';
import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/ads_model.dart';
import 'package:carryvibemobile/mvvm/home/deliveries/deliveries_viewmodel.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:carryvibemobile/util/enums.dart';
import 'package:flutter/material.dart';

class DeliveriesView extends StatelessWidget {
  DeliveriesViewModel viewModel;
  DeliveriesView({required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return DeliveriesScreen(viewModel: viewModel);
  }
}

class DeliveriesScreen extends StatefulWidget {
  DeliveriesViewModel viewModel;
  DeliveriesScreen({required this.viewModel});
  @override
  _DeliveriesScreenState createState() =>
      _DeliveriesScreenState(viewModel: viewModel);
}

class _DeliveriesScreenState extends State<DeliveriesScreen>
    with SingleTickerProviderStateMixin {
  AdsStatus selected = AdsStatus.sender;
  List<CarrierAdsModel>? carrierAdsModel;
  List<SenderAdsModel>? senderAdsModel;
  final DeliveriesViewModel viewModel;
  _DeliveriesScreenState({required this.viewModel}) {
    getByAds();
  }
  @override
  void dispose() {
    super.dispose();
  }

  void getByAds() async {
    var senders = await viewModel.getBySender();
    var carriers = await viewModel.getByCarrier();
    setState(() {
      senderAdsModel = senders;
      carrierAdsModel = carriers;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> setupView() {
      if (selected == AdsStatus.carrier) {
        if (carrierAdsModel != null) {
          return carrierAdsModel!.map((e) {
            return CustomAds(
              image: e.photoFirst ?? "",
              date: (e.departureTime ?? "") + "\n" + (e.destinationTime ?? ""),
              departure: e.departureCity ?? "",
              destination: e.destinationCity ?? "",
              name: e.userName ?? "",
              avatar: e.userAvatar ??
                  "https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/68.png",
            );
          }).toList();
        } else {
          return [CustomSubLabel(text: "İlan bulunamadı")];
        }
      } else {
        if (senderAdsModel != null) {
          return senderAdsModel!.map((e) {
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
        } else {
          return [CustomSubLabel(text: "İlan bulunamadı")];
        }
      }
    }

    return CustomListView(
        service: Service.shared(),
        constraint: false,
        children: [
              constraint,
              SegmentedButton<AdsStatus>(
                segments: const [
                  ButtonSegment<AdsStatus>(
                      value: AdsStatus.sender, label: Text("Kargo")),
                  ButtonSegment<AdsStatus>(
                      value: AdsStatus.carrier, label: Text("Kurye"))
                ],
                selected: <AdsStatus>{selected},
                onSelectionChanged: (Set<AdsStatus> newSelection) {
                  setState(() {
                    selected = newSelection.first;
                  });
                },
              )
            ] +
            setupView());
  }
}
