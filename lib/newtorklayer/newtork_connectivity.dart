import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivity {
  Future<bool> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> reconnect() async {
    await checkConnectivity();
  }
}
