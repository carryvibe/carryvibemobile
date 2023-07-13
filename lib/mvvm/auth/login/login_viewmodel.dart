import 'dart:async';

import 'package:carryvibemobile/mvvm/auth/login/login_model.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:flutter/widgets.dart';

mixin LoginViewModelDelegate {
  void didNextButtonTapped();
}

class LoginViewModel extends ChangeNotifier {
  LoginViewModelDelegate? delegate;
  Service service;
  LoginViewModel({required this.service});

  FutureOr<BaseResponseModel?> login(LoginRequestModel model) async {
    final responseModel = await service.request(
        ServiceConstants.api(ApiEnum.login),
        requestModel: model.toJson());
    return responseModel;
  }
}
