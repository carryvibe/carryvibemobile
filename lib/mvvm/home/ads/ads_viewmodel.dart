import 'dart:async';
import 'package:carryvibemobile/mvvm/home/ads/ads_model.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/search_model.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:flutter/widgets.dart';

class AdsViewModel extends ChangeNotifier {
  Service service;
  AdsViewModel({required this.service});

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

  FutureOr<BaseResponseModel> getSearchSenderAds(
      String startId, String finishId) async {
    Map<String, String> requestHeaders = {
      'startId': startId,
      'finishId': finishId,
    };
    final responseModel = await service.request(
        ServiceConstants.api(ApiEnum.searchSenderAds),
        queryItems: requestHeaders);
    return responseModel;
  }

  FutureOr<BaseResponseModel> getSearchCarrierAds(
      String startId, String finishId) async {
    Map<String, String> requestHeaders = {
      'startId': startId,
      'finishId': finishId,
    };
    final responseModel = await service.request(
        ServiceConstants.api(ApiEnum.carrierSenderAds),
        queryItems: requestHeaders);
    return responseModel;
  }
}
