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

  factory LoginResponseModel.fromJson(Object? json) {
    var jsonConverter = json as Map<String, dynamic>;
    return LoginResponseModel(
        firstName: jsonConverter?['firstName'],
        token: jsonConverter?['token'],
        phoneNumber: jsonConverter?['phoneNumber']);
  }
}
