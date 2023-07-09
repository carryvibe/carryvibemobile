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
  final String firstName;
  final String token;
  final String phoneNumber;
  LoginResponseModel(
      {required this.firstName,
      required this.token,
      required this.phoneNumber});
}
