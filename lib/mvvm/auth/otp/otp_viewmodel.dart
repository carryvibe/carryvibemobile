import 'dart:async';

import 'package:carryvibemobile/manager/user_default_manager.dart';
import 'package:carryvibemobile/mvvm/auth/login/login_model.dart';
import 'package:carryvibemobile/mvvm/auth/otp/otp_model.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin OtpViewModelDelegate {
  void didNextButtonTapped();
}

class OtpViewModel extends ChangeNotifier {
  LoginResponseModel model;
  OtpViewModelDelegate? delegate;
  Service service;
  OtpViewModel({required this.model, required this.service});
  String phoneNumber() {
    return model.phoneNumber ?? "";
  }

  Future<BaseResponseModel> verifyOtp(String otp) async {
    final responseModel = await service.request(
        ServiceConstants.api(ApiEnum.verifyOtp),
        requestModel:
            OtpRequestModel(otp: otp, token: model.token ?? "").toJson());
    if (responseModel.isStatus ?? false) {
      UserDefaultManager.shared().setValue(UserKeys.token, model.token);
      UserDefaultManager.shared().setValue(UserKeys.firstName, model.firstName);
      UserDefaultManager.shared().setValue(UserKeys.lastName, model.lastName);
      UserDefaultManager.shared()
          .setValue(UserKeys.isVerifyId, model.isVerifyId);
      UserDefaultManager.shared().setValue(UserKeys.avatar, model.profileImage);
    }
    return responseModel;
  }

  Future<BaseResponseModel> resendOtp() async {
    final responseModel = await service.request(
        ServiceConstants.api(ApiEnum.resendOtp),
        requestModel: <String, dynamic>{"token": model.token});
    if (responseModel.isStatus ?? false) {
      model = LoginResponseModel.fromJson(responseModel.responseModel);
    }
    return responseModel;
  }
}
