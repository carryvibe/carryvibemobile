import 'dart:ffi';

import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/customviews/custom_dropdown.dart';
import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/customviews/custom_textfield.dart';
import 'package:carryvibemobile/mvvm/home/ads/ads_model.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/maps_select_last_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/search_model.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/search_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/search_viewmodel.dart';
import 'package:carryvibemobile/mvvm/home/publish/carrier_publish/carrier_publish_model.dart';
import 'package:carryvibemobile/mvvm/home/publish/publish_viewmodel.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

class CarrierPublishView extends StatelessWidget {
  final PublishViewModel viewModel;
  final SenderAdsModel? senderAdsModel;
  final Function()? onConfirm;
  CarrierPublishView(
      {required this.viewModel, this.senderAdsModel, this.onConfirm});
  @override
  Widget build(BuildContext context) {
    return CarrierPublishScreen(
        viewModel: viewModel,
        senderAdsModel: senderAdsModel,
        onConfirm: onConfirm);
  }
}

class CarrierPublishScreen extends StatefulWidget {
  final PublishViewModel viewModel;
  final SenderAdsModel? senderAdsModel;
  final Function()? onConfirm;
  CarrierPublishScreen(
      {required this.viewModel, required this.senderAdsModel, this.onConfirm});
  @override
  _CarrierPublishState createState() => _CarrierPublishState(
      viewModel: viewModel,
      senderAdsModel: senderAdsModel,
      onConfirm: onConfirm);
}

class _CarrierPublishState extends State<CarrierPublishScreen> {
  final Function()? onConfirm;
  final PublishViewModel viewModel;
  final SenderAdsModel? senderAdsModel;
  TextEditingController startLocationController = TextEditingController();
  TextEditingController startDateTimeController = TextEditingController();
  TextEditingController finishLocationController = TextEditingController();
  TextEditingController finishDateTimeController = TextEditingController();
  FocusNode startFocus = FocusNode(), startDateTimeFocus = FocusNode();
  FocusNode finishFocus = FocusNode(), finishDateTimeFocus = FocusNode();
  Places? startPlace, finishPlace;
  SelectMaps? startMaps, finishMaps;
  TextEditingController cargoDescription = TextEditingController();
  _CarrierPublishState(
      {required this.viewModel, required this.senderAdsModel, this.onConfirm});
  String travel = "", cargoSize = "";

  @override
  void initState() {
    super.initState();
    travel = viewModel.getTravelTypes().first;
    cargoSize = viewModel.getCargoSizes().first;
    startLocationController.text = senderAdsModel?.departureAddress ?? "";
    finishLocationController.text = senderAdsModel?.destinationAddress ?? "";
  }

  Future<void> _selectDateTime(
      BuildContext context, TextEditingController textEditingController) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        locale: Locale('tr', 'TR'));
    if (pickedDate != null && pickedDate != selectedDate) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.dial,
      );

      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
        textEditingController.text =
            DateFormat('dd-MM-yyyy HH:mm').format(selectedDate);
      }
    }
    textEditingController == startDateTimeController
        ? startDateTimeFocus.unfocus()
        : finishDateTimeFocus.unfocus();
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
        final resultMap = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MapSelectLastView(
                      selectMaps: (SelectMaps maps) {
                        Navigator.pop(context, maps);
                      },
                      lat: resultPlace.lat,
                      long: resultPlace.lng,
                    )));

        if (resultMap != null) {
          if (controller == startLocationController) {
            startPlace = resultPlace;
            startMaps = resultMap;
          } else {
            finishPlace = resultPlace;
            finishMaps = resultMap;
          }
          setState(() {
            controller.text = resultPlace.formattedAdres;
          });
        }
      }
    }
  }

  void postCarrier() async {
    BaseResponseModel response = await viewModel.postCarrier(
        CarrierRequestModel(
            description: cargoDescription.text,
            cargoSize: cargoSize,
            travelType: travel,
            departurePlacesId:
                startPlace?.id ?? senderAdsModel?.departurePlacesId ?? "",
            departurePoint:
                startMaps?.Point ?? senderAdsModel?.departurePoint ?? "",
            departureCity:
                startMaps?.City ?? senderAdsModel?.departureCity ?? "",
            departureCountry:
                startMaps?.Country ?? senderAdsModel?.departureCountry ?? "",
            departureDistrict:
                startMaps?.District ?? senderAdsModel?.departureDistrict ?? "",
            departureAddress:
                startMaps?.Address ?? senderAdsModel?.departureAddress ?? "",
            departureTime: startDateTimeController.text,
            destinationPlacesId:
                finishPlace?.id ?? senderAdsModel?.destinationPlacesId ?? "",
            destinationPoint:
                finishMaps?.Point ?? senderAdsModel?.destinationPoint ?? "",
            destinationCity:
                finishMaps?.City ?? senderAdsModel?.destinationCity ?? "",
            destinationCountry:
                finishMaps?.Country ?? senderAdsModel?.destinationCountry ?? "",
            destinationDistrict: finishMaps?.District ??
                senderAdsModel?.destinationDistrict ??
                "",
            destinationAddress:
                finishMaps?.Address ?? senderAdsModel?.destinationAddress ?? "",
            destinationTime: finishDateTimeController.text));
    if (response.isStatus == true) {
      GFToast.showToast("İlan Başarılı ile yayınlanmıştır.", context,
          toastPosition: GFToastPosition.BOTTOM);
      if (onConfirm != null) {
        onConfirm!();
      }
      setState(() {
        cargoDescription.text = "";
        startDateTimeController.text = "";
        startLocationController.text = "";
        finishDateTimeController.text = "";
        finishLocationController.text = "";
        cargoSize = viewModel.getCargoSizes().first;
        travel = viewModel.getTravelTypes().first;
      });
    } else {
      GFToast.showToast(
          "Beklenmeyen bir hata oluştu, Tekrar deneyiniz.", context,
          toastPosition: GFToastPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomSecondLabel(text: "Rotanı paylaş, Kargo teslim et"),
      constraint,
      CustomLocationTextField(
        controller: startLocationController,
        labelText: "Kalkış noktası",
        onTap: () => _openSearchScreen(context, startLocationController),
        focusNode: startFocus,
      ),
      constraint,
      CustomLocationTextField(
        controller: startDateTimeController,
        labelText: "Kalkış Tarihi",
        onTap: () => _selectDateTime(context, startDateTimeController),
        focusNode: startDateTimeFocus,
      ),
      constraint,
      CustomLocationTextField(
        controller: finishLocationController,
        labelText: "Varış noktası",
        onTap: () => _openSearchScreen(context, finishLocationController),
        focusNode: finishFocus,
      ),
      constraint,
      CustomLocationTextField(
        controller: finishDateTimeController,
        labelText: "Varış Tarihi",
        onTap: () => _selectDateTime(context, finishDateTimeController),
        focusNode: finishDateTimeFocus,
      ),
      constraint,
      CustomDropdown(
          dropdown: cargoSize,
          onChanged: (newValue) => setState(() {
                cargoSize = newValue as String;
              }),
          items: viewModel.getCargoSizes()),
      constraint,
      CustomDropdown(
          dropdown: travel,
          onChanged: (newValue) => setState(() {
                travel = newValue as String;
              }),
          items: viewModel.getTravelTypes()),
      constraint,
      CustomTextField(
        controller: cargoDescription,
        labelText: "Eklemek istediğiniz bir şey var mı?",
      ),
      constraint,
      PrimaryButton(
          text: "Yayınla",
          onPressed: () {
            if (startLocationController.text != "" &&
                startDateTimeController.text != "" &&
                finishLocationController.text != "" &&
                finishDateTimeController.text != "" &&
                cargoSize != viewModel.getCargoSizes().first &&
                travel != viewModel.getTravelTypes().first) {
              postCarrier();
            } else {
              var text = "Lütfen eksikleri tamamlayınız.";
              GFToast.showToast(text, context,
                  toastPosition: GFToastPosition.BOTTOM);
            }
          })
    ]);
  }
}
