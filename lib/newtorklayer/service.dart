import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

enum ApiEnum { login, verifyOtp, resendOtp }

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

  static String api(ApiEnum api) {
    switch (api) {
      case ApiEnum.login:
        return "Auth/Login";
      case ApiEnum.verifyOtp:
        return "Auth/VerifyOtp";
      case ApiEnum.resendOtp:
        return "Auth/ResendOtp";
    }
  }

  static const error =
      "Beklenmeyen bir hata oluştu. Lütfen daha sonra tekrar deneyiniz.";
}

enum Status { success, fail, loading }

class BaseResponseModel {
  final bool? isStatus;
  final String? message;
  final Map<String, dynamic>? responseModel;

  const BaseResponseModel({this.isStatus, this.message, this.responseModel});

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) {
    return BaseResponseModel(
        isStatus: json['isStatus'],
        message: json['message'],
        responseModel: json['responseModel'] as Map<String, dynamic>?);
  }
}

class Service {
  var loader = false;
  static final Service _shared = Service._internal();
  factory Service.shared() {
    return _shared;
  }
  Service._internal();

  String url = ServiceConstants.localHost;

  Future<BaseResponseModel> request<U>(String? api,
      {Map<String, String>? queryItems,
      Map<String, dynamic>? requestModel}) async {
    var uri = Uri.parse(url + (api ?? ""));
    if (queryItems == null) queryItems = Map<String, String>();
    queryItems.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    //queryItems?.addAll({'apiKey': 'a0c8873b'});
    uri = uri.replace(queryParameters: queryItems);
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
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
      loader = false;
    }

    return (BaseResponseModel(
        isStatus: false, message: ServiceConstants.error, responseModel: null));
  }
}
