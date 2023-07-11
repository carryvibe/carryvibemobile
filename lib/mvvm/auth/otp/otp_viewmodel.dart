import 'dart:async';

import 'package:carryvibemobile/manager/user_default_manager.dart';
import 'package:carryvibemobile/mvvm/auth/login/login_model.dart';
import 'package:carryvibemobile/mvvm/auth/otp/otp_model.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:flutter/widgets.dart';

mixin OtpViewModelDelegate {
  void didNextButtonTapped();
}

class OtpViewModel extends ChangeNotifier {
  LoginResponseModel model;
  OtpViewModelDelegate? delegate;
  OtpViewModel({required this.model});

  String phoneNumber() {
    return model.phoneNumber ?? "";
  }

  Future<BaseResponseModel> verifyOtp(String otp) async {
    final responseModel = await Service.shared().request(
        ServiceConstants.api(ApiEnum.verifyOtp),
        requestModel:
            OtpRequestModel(otp: otp, token: model.token ?? "").toJson());
    if (responseModel.isStatus ?? false) {
      UserDefaultManager.shared().setValue("token", model.token);
    }
    return responseModel;
  }
}
