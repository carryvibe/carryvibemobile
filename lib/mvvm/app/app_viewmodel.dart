import 'package:carryvibemobile/manager/user_default_manager.dart';
import 'package:carryvibemobile/mvvm/app/app_model.dart';
import 'package:carryvibemobile/newtorklayer/newtork_connectivity.dart';
import 'package:flutter/widgets.dart';

mixin AppViewModelDelegate {
  void didNextButtonTapped();
}

class AppViewModel extends ChangeNotifier {
  NetworkConnectivity _networkConnectivity = NetworkConnectivity();
  AppViewModelDelegate? delegate;
  AppModel? _appModel;
  AppVersion appVersion = AppVersion.undefield;
  String? token;
  AppViewModel() {
    init();
  }

  void updateAppModel(String forceVersion, String suggestionVersion) {
    _appModel = AppModel(
        forceVersion: forceVersion, suggestionVersion: suggestionVersion);
  }

  void getAppModel() async {
    AppModel? appModel = AppModel(
        forceVersion: "1.0", suggestionVersion: "1.0"); // servis çağırılacak
    if (appModel.forceVersion.compareTo("1.0") > 0) {
      this.appVersion = AppVersion.forceUpdate;
    } else if (appModel.suggestionVersion.compareTo("1.0") > 0) {
      this.appVersion = AppVersion.suggestionUpdate;
    } else {
      String? token =
          await UserDefaultManager.shared().getValue(UserKeys.token) ?? "";
      if (token != null) {
        this.appVersion = AppVersion.done;
        this.token = token;
      }
    }
    this._appModel = appModel;
    notifyListeners();
  }

  void init() async {
    appVersion = AppVersion.undefield;
    if (await _networkConnectivity.checkConnectivity() == true) {
      getAppModel();
    } else {
      appVersion = AppVersion.notConnectionNetwork;
    }
  }
}

enum AppVersion {
  forceUpdate,
  suggestionUpdate,
  done,
  undefield,
  notConnectionNetwork
}
