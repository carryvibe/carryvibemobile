import 'dart:async';
import 'package:carryvibemobile/mvvm/home/ads/ads_model.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/search_model.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:flutter/widgets.dart';

class DeliveriesViewModel extends ChangeNotifier {
  Service service;
  DeliveriesViewModel({required this.service});

  FutureOr<List<SenderAdsModel>?> getBySender() async {
    final responseModel =
        await service.request(ServiceConstants.api(ApiEnum.bySender));
    if (responseModel != null && responseModel.isStatus == true) {
      var response = responseModel.responseModel as List<dynamic>;
      var senderAdsModel =
          response.map((data) => SenderAdsModel.fromJson(data)).toList();
      return senderAdsModel;
    }
    return null;
  }

  FutureOr<List<CarrierAdsModel>?> getByCarrier() async {
    final responseModel =
        await service.request(ServiceConstants.api(ApiEnum.byCarrier));
    if (responseModel != null && responseModel.isStatus == true) {
      var response = responseModel.responseModel as List<dynamic>;
      var carrier =
          response.map((data) => CarrierAdsModel.fromJson(data)).toList();
      return carrier;
    }
    return null;
  }
}
