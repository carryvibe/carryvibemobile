class RegisterRequestModel {
  final String firstName, lastName, userName, phone, password;
  RegisterRequestModel(
      {required this.firstName,
      required this.lastName,
      required this.userName,
      required this.phone,
      required this.password});

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'password': password,
        'userName': userName,
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
