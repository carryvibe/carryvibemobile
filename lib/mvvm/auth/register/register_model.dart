class RegisterRequestModel {
  final String userName;
  final String password;

  RegisterRequestModel({required this.userName, required this.password});

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'password': password,
      };
}

class RegisterResponseModel {
  final String firstName;
  final String token;
  final String phoneNumber;
  RegisterResponseModel(
      {required this.firstName,
      required this.token,
      required this.phoneNumber});
}
