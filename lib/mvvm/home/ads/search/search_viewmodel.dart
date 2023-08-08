import 'dart:async';
import 'package:carryvibemobile/mvvm/home/ads/search/search_model.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:flutter/widgets.dart';
/*
mixin LoginViewModelDelegate {
  void didNextButtonTapped();
}*/

class SearchViewModel extends ChangeNotifier {
  Service service;
  List<Places> places;
  SearchViewModel({required this.service, required this.places}) {}

  FutureOr<BaseResponseModel?> senderPublish(Places model) async {
    final responseModel =
        await service.request(ServiceConstants.api(ApiEnum.places));
    return responseModel;
  }

  List<String> getPlaces() {
    return places.map((e) => e.name).toList();
  }

  String getPlacesId(String name) {
    return places.where((element) => element.name == name).first.id;
  }
}
