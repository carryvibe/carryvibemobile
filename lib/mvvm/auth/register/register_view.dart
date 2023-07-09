import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/customviews/custom_contract.dart';
import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/customviews/custom_textfield.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/auth/login/login_model.dart';
import 'package:carryvibemobile/mvvm/auth/register/register_viewmodel.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:carryvibemobile/util/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class RegisterView extends StatelessWidget {
  final RegisterViewModel viewModel;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  RegisterView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("KAYIT OL"),
        ),
        body: CustomView(
          children: [
            AppIcon(
              assest: IconAssest.logo,
              width: 200,
            ),
            CustomLabel(text: "KAYIT OL"),
            constraint,
            CustomTextField(
              controller: email,
              labelText: "Ad",
              obscureText: true,
            ),
            constraint,
            CustomTextField(
              controller: email,
              labelText: "Soyad",
              obscureText: true,
            ),
            constraint,
            CustomTextField(
              controller: email,
              labelText: "Email",
              obscureText: true,
            ),
            constraint,
            CustomTextField(
              controller: email,
              labelText: "Telefon",
              obscureText: true,
            ),
            constraint,
            CustomTextField(
              controller: password,
              labelText: "Şifre",
              obscureText: true,
            ),
            constraint,
            CustomTextField(
              controller: password,
              labelText: "Şifre Tekrar",
              obscureText: true,
            ),
            constraint,
            PrimaryButton(text: "KAYIT OL", onPressed: () {}),
            constraint,
            CustomContract(
                text: "Üyelik sözleşmesini okudum ve",
                textButton: "onaylıyorum.",
                onPressed: () {}),
            CustomContract(
                text:
                    "CarryVibe Gizlilik ve KVKK Bildirimi - Yurtdışı Aktarımı Açık Rıza Beyanını okudum",
                textButton: "onaylıyorum",
                onPressed: () {})
          ],
        ));
  }
}
