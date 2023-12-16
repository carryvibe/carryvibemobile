import 'dart:ffi';

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
  final String? lastName;
  final String? token;
  final String? phoneNumber;
  final bool? isVerifyId;
  final String? profileImage;
  LoginResponseModel(
      {this.firstName,
      this.lastName,
      this.token,
      this.phoneNumber,
      this.isVerifyId,
      this.profileImage});

  factory LoginResponseModel.fromJson(Object? json) {
    var jsonConverter = json as Map<String, dynamic>;
    return LoginResponseModel(
        firstName: jsonConverter?['firstName'],
        lastName: jsonConverter?['lastName'],
        token: jsonConverter?['token'],
        phoneNumber: jsonConverter?['phoneNumber'],
        isVerifyId: jsonConverter?['isVerifyId'],
        profileImage: jsonConverter?['profileImage']);
  }
}
