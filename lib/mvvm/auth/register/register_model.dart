class RegisterRequestModel {
  final String firstName, lastName, userName, email, phone, password;
  RegisterRequestModel(
      {required this.firstName,
      required this.lastName,
      required this.userName,
      required this.email,
      required this.phone,
      required this.password});

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'phone': phone,
        'password': password,
        'userName': userName,
        'email': email
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
