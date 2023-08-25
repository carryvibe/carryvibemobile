import 'dart:async';

import 'package:carryvibemobile/mvvm/auth/register/register_model.dart';
import 'package:carryvibemobile/mvvm/auth/verifyId/verify_model.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/common_service.dart';
import 'package:carryvibemobile/util/enums.dart';
import 'package:flutter/widgets.dart';

class VerifyViewModel extends ChangeNotifier {
  Service service;
  VerifyViewModel({required this.service});

  FutureOr<BaseResponseModel?> verifyTCKN(VerifyModel model) async {
    final responseModel = await service.request(
        ServiceConstants.api(ApiEnum.verifyTCKN),
        requestModel: model.toJson());
    return responseModel;
  }
}
