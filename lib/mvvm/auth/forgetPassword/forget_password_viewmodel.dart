import 'dart:async';

import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/common_service.dart';
import 'package:carryvibemobile/util/enums.dart';
import 'package:flutter/widgets.dart';

mixin ForgetPasswordViewModelDelegate {
  void didNextButtonTapped();
}

class ForgetPasswordViewModel extends ChangeNotifier {
  ForgetPasswordViewModelDelegate? delegate;
  Service service;
  ForgetPasswordViewModel({required this.service});

  FutureOr<BaseResponseModel?> postForgetPassword(String userName) async {
    final responseModel = await service.request(
        ServiceConstants.api(ApiEnum.forgetPassword),
        requestModel: {"userName": userName});
    return responseModel;
  }

  FutureOr<BaseResponseModel?> getContact(Contract contact) async {
    return CommonService(service: service).getContract(contact);
  }
}
