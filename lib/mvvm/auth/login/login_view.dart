import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/customviews/custom_contract.dart';
import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/customviews/custom_textfield.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/auth/forgetPassword/forget_password_view.dart';
import 'package:carryvibemobile/mvvm/auth/forgetPassword/forget_password_viewmodel.dart';
import 'package:carryvibemobile/mvvm/auth/login/login_model.dart';
import 'package:carryvibemobile/mvvm/auth/login/login_viewmodel.dart';
import 'package:carryvibemobile/mvvm/auth/otp/otp_view.dart';
import 'package:carryvibemobile/mvvm/auth/otp/otp_viewmodel.dart';
import 'package:carryvibemobile/mvvm/auth/register/register_view.dart';
import 'package:carryvibemobile/mvvm/auth/register/register_viewmodel.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:carryvibemobile/util/app_icon.dart';
import 'package:carryvibemobile/util/enums.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class LoginView extends StatefulWidget {
  final LoginViewModel viewModel;
  const LoginView({required this.viewModel});
  @override
  LoginViewState createState() => LoginViewState(viewModel: viewModel);
}

class LoginViewState extends State<LoginView> {
  final LoginViewModel viewModel;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  LoginViewState({required this.viewModel});

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
        var login = await viewModel.login(
            LoginRequestModel(userName: email.text, password: password.text));
        if (login?.isStatus == true &&
            login != null &&
            login.responseModel != null) {
          final viewModel = OtpViewModel(
              model: LoginResponseModel.fromJson(login!.responseModel!),
              service: this.viewModel.service);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpView(viewModel: viewModel)));
        }
        GFToast.showToast(login?.message ?? ServiceConstants.error, context,
            toastPosition: GFToastPosition.BOTTOM);
      }
    }

    return Scaffold(
        body: CustomListView(
      service: viewModel.service,
      children: [
        AppIcon(
          assest: IconAssest.logo,
          width: 200,
        ),
        CustomLabel(text: "GİRİŞ YAP"),
        constraint,
        CustomTextField(
          controller: email,
          labelText: "Kullanıcı Adı / Mail / Telefon",
          obscureText: true,
        ),
        constraint,
        CustomTextField(
          controller: password,
          labelText: "Şifre",
          obscureText: true,
        ),
        constraint,
        /*Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            LabelButton(text: "Şifrenizi mi Unuttunuz ?", onPressed: () {})
          ],
        ),*/
        PrimaryButton(text: "GİRİŞ YAP", onPressed: login),
        PrimaryButton(
            text: "KAYIT OL",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterView(
                            viewModel: RegisterViewModel(
                                service: this.viewModel.service),
                          )));
            }),
        constraint,
        LabelButton(
            text: "Şifremi Unuttum",
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) => ForgetPasswordView(
                      viewModel:
                          ForgetPasswordViewModel(service: Service.shared())));
            }),
        CustomContract(
            text: "Çerez metnini okudum ve",
            textButton: "onaylıyorum.",
            contract: Contract.cerez,
            service: viewModel.service),
        CustomContract(
            text: "CarryVibe İletişim Formu ve Chatbot İşlevi",
            textButton: "Aydınlatma Metni",
            contract: Contract.iletisimFormuAydinlatmaMetni,
            service: viewModel.service)
      ],
    ));
  }
}
