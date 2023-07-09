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

  Future<BaseResponseModel<LoginResponseModel>?> login(
      LoginRequestModel model) async {
    await Service.shared().request<LoginResponseModel>(
        ServiceConstants.api(ApiEnum.login),
        requestModel: model.toJson(), completion: (response) {
      return response;
    });
  }
}
