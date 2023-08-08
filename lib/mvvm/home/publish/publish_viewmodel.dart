import 'dart:async';

import 'package:carryvibemobile/mvvm/home/ads/search/search_model.dart';
import 'package:carryvibemobile/mvvm/home/publish/sender_publish/sender_publish_model.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/enums.dart';
import 'package:flutter/widgets.dart';
import 'package:carryvibemobile/mvvm/home/publish/carrier_publish/carrier_publish_model.dart';

class PublishViewModel extends ChangeNotifier {
  Service service;
  PublishViewModel({required this.service});

  FutureOr<BaseResponseModel?> senderPublish(SenderRequestModel model) async {
    final responseModel = await service.request(
        ServiceConstants.api(ApiEnum.login),
        requestModel: model.toJson());
    return responseModel;
  }

  FutureOr<List<Places>?> getAllPlaces() async {
    final responseModel =
        await service.request(ServiceConstants.api(ApiEnum.places));
    if (responseModel.isStatus == true) {
      var response = responseModel.responseModel as List<dynamic>;
      return response.map((data) => Places.fromJson(data)).toList();
    } else {
      return null;
    }
  }

  List<String> getCargoSizes() {
    var result = <String>["Alabileceğiniz maksimum kargo boyutu"];
    CargoSize.values.forEach((element) {
      result.add(cargoSize(element));
    });
    return result;
  }

  String cargoSize(CargoSize size) {
    switch (size) {
      case CargoSize.big:
        return "Büyük";
      case CargoSize.medium:
        return "Orta";
      case CargoSize.small:
        return "Küçük";
    }
  }

  List<String> getTravelTypes() {
    var result = <String>["Seyahat Türü Seçiniz"];
    Travel.values.forEach((element) {
      result.add(travel(element));
    });
    return result;
  }

  String travel(Travel size) {
    switch (size) {
      case Travel.car:
        return "Araba";
      case Travel.bus:
        return "Otobüs";
      case Travel.train:
        return "Tren";
      case Travel.ship:
        return "Gemi";
      case Travel.motorcycle:
        return "Motosiklet";
      case Travel.bicycle:
        return "Bisiklet";
      case Travel.plane:
        return "Uçak";
    }
  }

  FutureOr<BaseResponseModel> postCarrier(
      CarrierRequestModel requestModel) async {
    final responseModel = await service.request(
        ServiceConstants.api(ApiEnum.postCarrier),
        requestModel: requestModel.toJson());

    return responseModel;
  }

  FutureOr<BaseResponseModel> postSender(
      SenderRequestModel requestModel) async {
    final responseModel = await service.request(
        ServiceConstants.api(ApiEnum.postSender),
        requestModel: requestModel.toJson());

    return responseModel;
  }
}
