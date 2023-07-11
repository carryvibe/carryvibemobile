import 'dart:async';

import 'package:carryvibemobile/mvvm/auth/login/login_model.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:flutter/widgets.dart';

mixin LoginViewModelDelegate {
  void didNextButtonTapped();
}

class LoginViewModel extends ChangeNotifier {
  LoginViewModelDelegate? delegate;
  LoginViewModel() {
    init();
  }

  void init() {}

  FutureOr<BaseResponseModel?> login(LoginRequestModel model) async {
    final responseModel = await Service.shared().request(
        ServiceConstants.api(ApiEnum.login),
        requestModel: model.toJson());
    return responseModel;
  }
}
