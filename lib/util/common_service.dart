import 'dart:async';

import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/enums.dart';

class CommonService {
  Service service;
  CommonService({required this.service});
  String contractString(Contract contact) {
    switch (contact) {
      case Contract.kvkk:
        return "kvkk";
      case Contract.uyelikSozlesmesi:
        return "uyelikSozlesmesi";
      case Contract.uyelikFaaliyetleriAydinlatmaRizaMetni:
        return "uyelikFaaliyetleriAydinlatmaRizaMetni";
      case Contract.cerez:
        return "cerez";
      case Contract.iletisimFormuAydinlatmaMetni:
        return "iletisimFormuAydinlatmaMetni";
      case Contract.illegalEsyalar:
        return "illegalEsyalar";
    }
  }

  FutureOr<BaseResponseModel?> getContract(Contract contract) async {
    final responseModel = await service.request(
        ServiceConstants.api(ApiEnum.getContract),
        queryItems: <String, String>{'name': contractString(contract)});
    return responseModel;
  }
}
