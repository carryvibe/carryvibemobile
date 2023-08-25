import 'dart:async';

import 'package:carryvibemobile/mvvm/auth/register/register_model.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/common_service.dart';
import 'package:carryvibemobile/util/enums.dart';
import 'package:flutter/widgets.dart';

mixin RegisterViewModelDelegate {
  void didNextButtonTapped();
}

class RegisterViewModel extends ChangeNotifier {
  RegisterViewModelDelegate? delegate;
  Service service;
  RegisterViewModel({required this.service});

  FutureOr<BaseResponseModel?> postRequest(RegisterRequestModel model) async {
    final responseModel = await service.request(
        ServiceConstants.api(ApiEnum.register),
        requestModel: model.toJson());
    return responseModel;
  }

  FutureOr<BaseResponseModel?> getContact(Contract contact) async {
    return CommonService(service: service).getContract(contact);
  }
}
