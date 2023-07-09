import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/customviews/custom_contract.dart';
import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/customviews/custom_textfield.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/auth/login/login_viewmodel.dart';
import 'package:carryvibemobile/mvvm/auth/otp/otp_view.dart';
import 'package:carryvibemobile/mvvm/auth/register/register_view.dart';
import 'package:carryvibemobile/mvvm/auth/register/register_viewmodel.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:carryvibemobile/util/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class LoginView extends StatelessWidget {
  final LoginViewModel viewModel;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  LoginView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    void login() async {
      if (email.text == "") {
        GFToast.showToast("Email Giriniz", context,
            toastPosition: GFToastPosition.BOTTOM);
      } else if (password.text == "") {
        GFToast.showToast("Şifre Giriniz", context,
            toastPosition: GFToastPosition.BOTTOM);
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OtpView()));
        /*
        var login = await viewModel.login(
            LoginRequestModel(userName: email.text, password: password.text));
        if (login?.isStatus == true) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => OtpView()));
        } else {
          GFToast.showToast(
              "Kullanıcı Adınız veya şifreniz hatalıdır tekrar deneyiniz.",
              context,
              toastPosition: GFToastPosition.BOTTOM);
        }*/
      }
    }

    return CustomView(
      children: [
        AppIcon(
          assest: IconAssest.logo,
          width: 200,
        ),
        CustomLabel(text: "GİRİŞ YAP"),
        constraint,
        CustomTextField(
          controller: email,
          labelText: "Email",
          obscureText: true,
        ),
        constraint,
        CustomTextField(
          controller: password,
          labelText: "Şifre",
          obscureText: true,
        ),
        constraint,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            LabelButton(text: "Şifrenizi mi Unuttunuz ?", onPressed: () {})
          ],
        ),
        PrimaryButton(text: "GİRİŞ YAP", onPressed: login),
        PrimaryButton(
            text: "KAYIT OL",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterView(
                            viewModel: RegisterViewModel(),
                          )));
            }),
        constraint,
        CustomContract(
            text: "Çerez metnini okudum ve",
            textButton: "onaylıyorum.",
            onPressed: () {}),
        CustomContract(
            text: "CarryVibe İletişim Formu ve Chatbot İşlevi",
            textButton: "Aydınlatma Metni",
            onPressed: () {})
      ],
    );
  }
}
