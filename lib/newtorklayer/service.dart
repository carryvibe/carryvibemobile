import 'dart:convert';
import 'package:http/http.dart' as http;

enum ApiEnum { login }

class ServiceConstants {
  static const String localHost = "https://localhost:7008/";

  static String api(ApiEnum api) {
    switch (api) {
      case ApiEnum.login:
        return "Auth/Login";
    }
  }

  static const error =
      "Beklenmeyen bir hata oluştu. Lütfen daha sonra tekrar deneyiniz.";
}

enum Status { success, fail, loading }

class BaseResponseModel<T> {
  bool? isStatus;
  String? message;
  T? responseModel;

  BaseResponseModel(this.isStatus, this.message, this.responseModel);
}

class Service {
  static final Service _shared = Service._internal();
  factory Service.shared() {
    return _shared;
  }
  Service._internal();

  static const String url = ServiceConstants.localHost;

  Future<void> request<U>(
    String? api, {
    Map<String, String>? queryItems,
    Map<String, dynamic>? requestModel,
    required Function(BaseResponseModel<U>) completion,
  }) async {
    var uri = Uri.parse(url + (api ?? ""));
    if (queryItems == null) queryItems = Map<String, String>();
    //queryItems?.addAll({'apiKey': 'a0c8873b'});
    //uri = uri.replace(queryParameters: queryItems);
    final request = http.Request(
      requestModel != null ? "POST" : "GET",
      uri,
    );

    if (requestModel != null) {
      request.body = jsonEncode(requestModel);
    }
    try {
      final response = await request.send();
      final responseJson = await response.stream.bytesToString();
      final parsedResponse = jsonDecode(responseJson);

      if (response.statusCode == 200) {
        final model = parsedResponse as BaseResponseModel<U>;
        completion(model);
        return;
      }
    } catch (e) {
      print("WEB SERVICE ERROR LOG: $e");
    }

    completion(BaseResponseModel(false, ServiceConstants.error, null));
  }
}
