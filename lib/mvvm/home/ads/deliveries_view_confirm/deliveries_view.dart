import 'package:carryvibemobile/customviews/custom_ads.dart';
import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/ads_model.dart';
import 'package:carryvibemobile/mvvm/home/ads/deliveries_view_confirm/deliveries_viewmodel.dart';
import 'package:carryvibemobile/mvvm/home/publish/carrier_publish/carrier_publish_view.dart';
import 'package:carryvibemobile/mvvm/home/publish/publish_viewmodel.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:carryvibemobile/util/app_helpers.dart';
import 'package:carryvibemobile/util/enums.dart';
import 'package:flutter/material.dart';

class DeliveriesView extends StatelessWidget {
  AdsStatus status;
  DeliveriesViewModel viewModel;
  SenderAdsModel? senderAdsModel;
  CarrierAdsModel? carrierAdsModel;
  final Function(int?) id;
  DeliveriesView(
      {required this.viewModel,
      required this.status,
      required this.id,
      this.senderAdsModel,
      this.carrierAdsModel});
  @override
  Widget build(BuildContext context) {
    return DeliveriesScreen(
        viewModel: viewModel,
        status: status,
        id: id,
        senderAdsModel: senderAdsModel,
        carrierAdsModel: carrierAdsModel);
  }
}

class DeliveriesScreen extends StatefulWidget {
  AdsStatus status;
  DeliveriesViewModel viewModel;
  final Function(int?) id;
  SenderAdsModel? senderAdsModel;
  CarrierAdsModel? carrierAdsModel;
  DeliveriesScreen(
      {required this.viewModel,
      required this.status,
      required this.id,
      this.senderAdsModel,
      this.carrierAdsModel});
  @override
  _DeliveriesScreenState createState() => _DeliveriesScreenState(
      viewModel: viewModel,
      status: status,
      id: id,
      senderAdsModel: senderAdsModel,
      carrierAdsModel: carrierAdsModel);
}

class _DeliveriesScreenState extends State<DeliveriesScreen>
    with SingleTickerProviderStateMixin {
  AdsStatus status;
  List<CarrierAdsModel>? carrierAdsModels;
  List<SenderAdsModel>? senderAdsModels;
  SenderAdsModel? senderAdsModel;
  CarrierAdsModel? carrierAdsModel;
  final DeliveriesViewModel viewModel;
  final Function(int?) id;
  _DeliveriesScreenState(
      {required this.viewModel,
      required this.status,
      required this.id,
      this.carrierAdsModel,
      this.senderAdsModel}) {
    getByAds();
  }
  @override
  void dispose() {
    super.dispose();
  }

  void getByAds() async {
    List<SenderAdsModel>? senders;
    List<CarrierAdsModel>? carriers;
    if (status == AdsStatus.sender) {
      senders = await viewModel.getBySender();
    } else if (status == AdsStatus.carrier) {
      carriers = await viewModel.getByCarrier();
    }
    if (mounted) {
      setState(() {
        senderAdsModels = senders;
        carrierAdsModels = carriers;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> setupView() {
      if (status == AdsStatus.carrier) {
        if (carrierAdsModels != null) {
          return carrierAdsModels!.map((e) {
            return CustomAds(
              image: e.photoFirst ?? "",
              date: (e.departureTime ?? "") + "\n" + (e.destinationTime ?? ""),
              departure: e.departureCity ?? "",
              destination: e.destinationCity ?? "",
              name: e.userName ?? "",
              avatar: e.userAvatar ?? avatarImgUrl,
              onPressed: () {
                AppHelpers.showConfirmationDialog(
                    context: context,
                    title: "İlan Eşleşme",
                    subTitle: "Seçtiğiniz ilan ile eşleşiyorsunuz.",
                    primaryPress: () {
                      id(e.id);
                    });
              },
              onLongPress: () {},
            );
          }).toList();
        } else {
          return [CustomSubLabel(text: "İlan bulunamadı")];
        }
      } else {
        if (senderAdsModels != null) {
          return senderAdsModels!.map((e) {
            return CustomAds(
              image: e.photoFirst ?? "",
              date: e.content ?? "",
              departure: e.departureCity ?? "",
              destination: e.destinationCity ?? "",
              name: e.userName ?? "",
              avatar: e.userAvatar ?? avatarImgUrl,
              onPressed: () {
                AppHelpers.showConfirmationDialog(
                    context: context,
                    title: "İlan Eşleşme",
                    subTitle: "Seçtiğiniz ilan ile eşleşiyorsunuz.",
                    primaryPress: () {
                      id(e.id);
                    });
              },
              onLongPress: () {},
            );
          }).toList();
        } else {
          return [CustomSubLabel(text: "İlan bulunamadı")];
        }
      }
    }

    return Scaffold(
        appBar: AppBar(title: Text("İlanlar")),
        body: CustomListView(
            service: Service.shared(),
            constraint: false,
            children: [
                  constraint,
                  Container(
                    padding: EdgeInsets.all(16),
                    child: SecondaryButton(
                        text: "Yeni İlanı Ekle",
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled:
                                true, // Tam ekran bottom sheet için bu parametre gerekli
                            builder: (context) {
                              return FractionallySizedBox(
                                  heightFactor:
                                      0.9, // Ekranın tam yüksekliğini kullan
                                  child: Container(
                                      padding: EdgeInsets.all(16),
                                      child: CarrierPublishView(
                                        viewModel: PublishViewModel(
                                            service: Service.shared()),
                                        senderAdsModel: senderAdsModel,
                                        onConfirm: () {
                                          Navigator.pop(context);
                                          getByAds();
                                        },
                                      )));
                            },
                          );
                        }),
                  ),
                ] +
                setupView()));
  }
}
