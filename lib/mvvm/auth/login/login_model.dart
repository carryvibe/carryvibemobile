import 'package:carryvibemobile/newtorklayer/service.dart';

class LoginRequestModel {
  final String userName;
  final String password;

  LoginRequestModel({required this.userName, required this.password});

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'password': password,
      };
}

class LoginResponseModel {
  final String? firstName;
  final String? token;
  final String? phoneNumber;
  LoginResponseModel({this.firstName, this.token, this.phoneNumber});

  factory LoginResponseModel.fromJson(Map<String, dynamic>? json) {
    return LoginResponseModel(
        firstName: json?['firstName'],
        token: json?['token'],
        phoneNumber: json?['phoneNumber']);
  }
}
