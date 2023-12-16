import 'dart:async';
import 'dart:convert';
import 'package:carryvibemobile/manager/user_default_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

enum ApiEnum {
  login,
  verifyOtp,
  resendOtp,
  register,
  forgetPassword,
  places,
  postSender,
  postCarrier,
  searchSenderAds,
  carrierSenderAds,
  allSender,
  allCarrier,
  getContract,
  verifyTCKN,
  bySender,
  byCarrier
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class ServiceConstants {
  static const String localHost = "https://localhost:7008/";
  static const String test =
      "http://ec2-52-57-91-104.eu-central-1.compute.amazonaws.com/";
  static String api(ApiEnum api) {
    switch (api) {
      case ApiEnum.login:
        return "Auth/Login";
      case ApiEnum.verifyOtp:
        return "Auth/VerifyOtp";
      case ApiEnum.resendOtp:
        return "Auth/ResendOtp";
      case ApiEnum.register:
        return "Auth/Register";
      case ApiEnum.forgetPassword:
        return "Auth/ForgetPassword";
      case ApiEnum.places:
        return "Common/GetAllPlaces";
      case ApiEnum.postSender:
        return "Ads/PostSender";
      case ApiEnum.postCarrier:
        return "Ads/PostCarrier";
      case ApiEnum.searchSenderAds:
        return "Ads/GetSearchSender";
      case ApiEnum.carrierSenderAds:
        return "Ads/GetCarrierSender";
      case ApiEnum.getContract:
        return "Common/GetContract";
      case ApiEnum.verifyTCKN:
        return "Common/GetTCKNVerify";
      case ApiEnum.allCarrier:
        return "Ads/GetAllCarrier";
      case ApiEnum.allSender:
        return "Ads/GetAllSender";
      case ApiEnum.bySender:
        return "Ads/GetBySender";
      case ApiEnum.byCarrier:
        return "Ads/GetByCarrier";
    }
  }

  static const error =
      "Beklenmeyen bir hata oluştu. Lütfen daha sonra tekrar deneyiniz.";
}

enum Status { success, fail, loading }

class BaseResponseModel {
  final bool? isStatus;
  final String? message;
  final Object? responseModel;

  const BaseResponseModel({this.isStatus, this.message, this.responseModel});

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) {
    return BaseResponseModel(
        isStatus: json['isStatus'],
        message: json['message'],
        responseModel: json['responseModel'] as Object?);
  }
}

class Service {
  var loader = false;
  static final Service _shared = Service._internal();
  factory Service.shared() {
    return _shared;
  }
  Service._internal();

  String url = ServiceConstants.test;

  Future<BaseResponseModel> request<U>(String? api,
      {Map<String, String>? queryItems,
      Map<String, dynamic>? requestModel}) async {
    var uri = Uri.parse(url + (api ?? ""));
    if (queryItems == null) queryItems = Map<String, String>();
    uri = uri.replace(queryParameters: queryItems);
    String? token = await UserDefaultManager.shared().getValue(UserKeys.token);
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      if (token != null) 'token': token
    };

    try {
      loader = true;
      final response = (requestModel != null)
          ? await http.post(
              uri,
              headers: requestHeaders,
              body: jsonEncode(requestModel),
            )
          : await http.get(
              uri,
              headers: requestHeaders,
            );
      final parsedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var model = BaseResponseModel.fromJson(parsedResponse);
        if (model.isStatus == null) {
          model = BaseResponseModel.fromJson(parsedResponse["result"]);
        }

        loader = false;
        return model;
      }
    } catch (e) {
      print("WEB SERVICE ERROR LOG: $e");
    }

    loader = false;
    return (BaseResponseModel(
        isStatus: false, message: ServiceConstants.error, responseModel: null));
  }
}
