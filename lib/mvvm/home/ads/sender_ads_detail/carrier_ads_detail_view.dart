import 'dart:convert';

import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/manager/user_default_manager.dart';
import 'package:carryvibemobile/mvvm/auth/verifyId/verify_view.dart';
import 'package:carryvibemobile/mvvm/auth/verifyId/verify_viewmodel.dart';
import 'package:carryvibemobile/mvvm/home/ads/ads_model.dart';
import 'package:carryvibemobile/mvvm/home/ads/deliveries_view_confirm/deliveries_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/deliveries_view_confirm/deliveries_viewmodel.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:carryvibemobile/util/app_helpers.dart';
import 'package:carryvibemobile/util/enums.dart';
import 'package:flutter/material.dart';

class CarrierAdsDetailView extends StatelessWidget {
  final CarrierAdsModel carrierAdsModel;
  const CarrierAdsDetailView({required this.carrierAdsModel});
  @override
  Widget build(BuildContext context) {
    return CarrierAdsDetailScreen(carrierAdsModel: carrierAdsModel);
  }
}

class CarrierAdsDetailScreen extends StatefulWidget {
  final CarrierAdsModel carrierAdsModel;
  const CarrierAdsDetailScreen({required this.carrierAdsModel});
  @override
  _CarrierAdsDetailScreenState createState() =>
      _CarrierAdsDetailScreenState(carrierAdsModel: carrierAdsModel);
}

class _CarrierAdsDetailScreenState extends State<CarrierAdsDetailScreen>
    with SingleTickerProviderStateMixin {
  final CarrierAdsModel carrierAdsModel;
  _CarrierAdsDetailScreenState({required this.carrierAdsModel});
  AdsStatus selected = AdsStatus.sender;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomSecondLabel(text: "Kurye"),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        body: CustomListView(
            service: Service.shared(),
            constraint: true,
            children: [
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TimelineItem(
                      title: carrierAdsModel.departureAddress ?? "",
                      subtitle: (carrierAdsModel.departureCountry ?? "") +
                          "/" +
                          (carrierAdsModel.departureCity ?? ""),
                      additionalInfo: 'Kalkış noktası',
                    ),
                    TimelineItem(
                      title: carrierAdsModel.destinationAddress ?? "",
                      subtitle: (carrierAdsModel.destinationCountry ?? "") +
                          "/" +
                          (carrierAdsModel.destinationCity ?? ""),
                      additionalInfo: 'Varış noktası',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: carrierAdsModel.userAvatar != null
                    ? Image.memory(
                        base64Decode(carrierAdsModel.userAvatar ?? ""),
                        width: 30,
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(avatarImgUrl),
                      ),
                title: Text(carrierAdsModel.userName ?? ""),
                //subtitle: Text('4,9/5 - 21 puan'),
              ),
              ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text('Doğrulanmış Profil'),
              ),
              Divider(),
              ListTile(
                title: Text("Kapasite"),
                trailing: Text(carrierAdsModel.cargoSize ?? ""),
              ),
              ListTile(
                title: Text("Taşıyabileceği Ağırlık"),
                trailing:
                    Text((carrierAdsModel.cargoWeight ?? 0).toString() + "kg"),
              ),
              ListTile(
                title: Text('Seyahat Türü'),
                trailing: Text((carrierAdsModel.travelType ?? "")),
              ),
              Divider(),
              /*
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Kargoyu paylaş'),
                onTap: () {
                  // Paylaşma işlevi
                },
              ),
              ListTile(
                leading: Icon(Icons.report_problem),
                title: Text('Kargoyu bildir'),
                onTap: () {
                  // Bildirme işlevi
                },
              ),*/
            ]),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          child: PrimaryButton(
            text: "Eşleşme Talebi Gönder",
            onPressed: () => {matchRequest()},
          ),
        ));
  }

  void matchRequest() async {
    bool? isVerifyId =
        await UserDefaultManager.shared().getValue(UserKeys.isVerifyId);
    if ((isVerifyId ?? false)) {
      final id = Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DeliveriesView(
                    viewModel: DeliveriesViewModel(service: Service.shared()),
                    status: AdsStatus.sender,
                    id: (int? id) {
                      Navigator.pop(context, id);
                    },
                    carrierAdsModel: carrierAdsModel,
                  )));
    } else {
      AppHelpers.showConfirmationDialog(
          context: context,
          title: "Eşleşme",
          subTitle:
              "Eşleşme talebi gönderebilmeniz için Kimlik doğrulama yapmanız gerekmektedir.",
          primaryButton: "Kimlik Doğrula",
          primaryPress: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled:
                  true, // Tam ekran bottom sheet için bu parametre gerekli
              builder: (context) {
                return FractionallySizedBox(
                    heightFactor: 0.41, // Ekranın tam yüksekliğini kullan
                    child: VerifyView(
                        viewModel: VerifyViewModel(service: Service.shared())));
              },
            );
          });
    }
  }
}

class PassengerTile extends StatelessWidget {
  final String name;
  final String route;
  final String imageUrl;

  const PassengerTile({
    Key? key,
    required this.name,
    required this.route,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(name),
      subtitle: Text(route),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        // Yolcu detayı için işlev
      },
    );
  }
}

class TimelineItem extends StatelessWidget {
  final String? time;
  final String? duration;
  final String title;
  final String subtitle;
  final String additionalInfo;

  const TimelineItem({
    Key? key,
    this.time,
    this.duration,
    required this.title,
    required this.subtitle,
    required this.additionalInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(time ?? "", style: TextStyle(fontWeight: FontWeight.bold)),
              if (duration != null)
                Text(duration ?? "", style: TextStyle(color: Colors.grey)),
            ],
          ),
          SizedBox(width: 16.0),
          Column(
            children: <Widget>[
              Container(
                width: 1.0,
                height: 20.0,
                color: Colors.grey,
              ),
              Icon(Icons.fiber_manual_record, size: 20.0),
              Container(
                width: 1.0,
                height: 20.0,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle),
                Row(
                  children: <Widget>[
                    Icon(Icons.directions_walk, size: 16.0),
                    SizedBox(width: 4.0),
                    Text(additionalInfo),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
