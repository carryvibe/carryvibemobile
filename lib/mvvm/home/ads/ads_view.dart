import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/customviews/custom_history.dart';
import 'package:carryvibemobile/customviews/custom_textfield.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/ads_model.dart';
import 'package:carryvibemobile/mvvm/home/ads/ads_viewmodel.dart';
import 'package:carryvibemobile/mvvm/home/ads/carrier_ads/carrier_ads_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/search_model.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/search_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/search_viewmodel.dart';
import 'package:carryvibemobile/mvvm/home/ads/sender_ads/sender_ads_view.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:carryvibemobile/util/enums.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AdsView extends StatelessWidget {
  AdsViewModel viewModel;
  AdsView({required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return AdsScreen(viewModel: viewModel);
  }
}

class AdsScreen extends StatefulWidget {
  AdsViewModel viewModel;
  AdsScreen({required this.viewModel});
  @override
  _AdsScreenState createState() => _AdsScreenState(viewModel: viewModel);
}

class _AdsScreenState extends State<AdsScreen>
    with SingleTickerProviderStateMixin {
  AdsViewModel viewModel;
  _AdsScreenState({required this.viewModel});
  AdsStatus selected = AdsStatus.sender;

  TextEditingController startLocationController = TextEditingController();
  TextEditingController finishLocationController = TextEditingController();
  String startLocationId = "", finishLocationId = "";
  FocusNode startFocus = FocusNode();
  FocusNode finishFocus = FocusNode();

  @override
  void dispose() {
    startLocationController.dispose();
    finishLocationController.dispose();
    super.dispose();
  }

  void _openSearchScreen(
      BuildContext context, TextEditingController controller) async {
    var places = await viewModel.getAllPlaces();
    if (places != null) {
      controller == startLocationController
          ? startFocus.unfocus()
          : finishFocus.unfocus();
      final result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SearchView(
                    onLocationSelected: (Places location) {
                      Navigator.pop(context, location);
                    },
                    viewModel: SearchViewModel(
                        service: viewModel.service, places: places),
                  ),
              fullscreenDialog: true));

      if (result != null) {
        var resultPlace = result as Places;
        controller == startLocationController
            ? startLocationId = resultPlace.id
            : finishLocationId = resultPlace.id;
        setState(() {
          controller.text = resultPlace.formattedAdres;
        });
      }
    }
  }

  void getSearchSenderAds() async {
    var model =
        await viewModel.getSearchSenderAds(startLocationId, finishLocationId);
    if (model.isStatus == true && model.responseModel != null) {
      var response = model.responseModel as List<dynamic>;
      var senderAdsModel =
          response.map((data) => SenderAdsModel.fromJson(data)).toList();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SenderAdsView(senderAdsModel: senderAdsModel),
              fullscreenDialog: true));
    } else {
      GFToast.showToast(model.message, context,
          toastPosition: GFToastPosition.BOTTOM);
    }
  }

  void getSearchCarrierAds() async {
    var model =
        await viewModel.getSearchCarrierAds(startLocationId, finishLocationId);
    if (model.isStatus == true && model.responseModel != null) {
      var response = model.responseModel as List<dynamic>;
      var carrierAdsModel =
          response.map((data) => CarrierAdsModel.fromJson(data)).toList();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CarrierAdsView(carrierAdsModel: carrierAdsModel),
              fullscreenDialog: true));
    } else {
      GFToast.showToast(model.message, context,
          toastPosition: GFToastPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomListView(service: Service.shared(), children: [
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
      ),
      //if (selected == AdsStatus.sender) Text("kurye") else Text("Kargo")
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          constraint,
          CustomTitleLineTextField(
            controller: startLocationController,
            title: "Nereden",
            labelText: "Başlangıç noktasını girin",
            onTap: () => _openSearchScreen(context, startLocationController),
            focusNode: startFocus,
          ),
          constraint,
          CustomTitleLineTextField(
            controller: finishLocationController,
            title: "Nereye",
            labelText: "Varış noktasını girin",
            onTap: () => _openSearchScreen(context, finishLocationController),
            focusNode: finishFocus,
          ),
          constraint,
          PrimaryButton(
            onPressed: () {
              selected == AdsStatus.sender
                  ? getSearchSenderAds()
                  : getSearchCarrierAds();
            },
            text: "Ara",
          ),
          constraint,
          HistoryView(
              text: 'İstanbul, Türkiye -> Bursa, Türkiye', onPressed: () => {})
        ],
      ),
    ]);
  }
}
