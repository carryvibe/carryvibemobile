import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/customviews/custom_contract.dart';
import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/customviews/custom_textfield.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/auth/login/login_model.dart';
import 'package:carryvibemobile/mvvm/auth/register/register_viewmodel.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
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
        body: CustomListView(
          service: viewModel.service,
          children: [
            AppIcon(
              assest: IconAssest.logo,
              width: 50,
              height: 50,
            ),
            CustomTextField(
              controller: email,
              labelText: "Ad",
              obscureText: true,
            ),
            constraintSmall,
            CustomTextField(
              controller: email,
              labelText: "Soyad",
              obscureText: true,
            ),
            constraintSmall,
            CustomTextField(
              controller: email,
              labelText: "Email",
              obscureText: true,
            ),
            constraintSmall,
            CustomTextField(
              controller: email,
              labelText: "Telefon",
              obscureText: true,
            ),
            constraintSmall,
            CustomTextField(
              controller: password,
              labelText: "Şifre",
              obscureText: true,
            ),
            constraintSmall,
            CustomTextField(
              controller: password,
              labelText: "Şifre Tekrar",
              obscureText: true,
            ),
            constraintSmall,
            PrimaryButton(text: "KAYIT OL", onPressed: () {}),
            constraintSmall,
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
