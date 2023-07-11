class OtpRequestModel {
  final String token;
  final String otp;

  OtpRequestModel({required this.token, required this.otp});

  Map<String, dynamic> toJson() => {
        'token': token,
        'otp': otp,
      };
}
