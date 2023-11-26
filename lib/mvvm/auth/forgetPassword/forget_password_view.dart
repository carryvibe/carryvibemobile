import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/customviews/custom_textfield.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/auth/forgetPassword/forget_password_viewmodel.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:carryvibemobile/util/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ForgetPasswordView extends StatelessWidget {
  final ForgetPasswordViewModel viewModel;
  TextEditingController nameController = TextEditingController();
  ForgetPasswordView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    void register() async {
      if (nameController.text != "") {
        var response = await viewModel.postForgetPassword(nameController.text);
        GFToast.showToast(response?.message, context,
            toastPosition: GFToastPosition.BOTTOM);
        if (response?.isStatus == true) {
          Navigator.pop(context);
        }
      } else {
        GFToast.showToast("Kullanıcı Adını Giriniz.", context,
            toastPosition: GFToastPosition.BOTTOM);
        return;
      }
    }

    return Scaffold(
        appBar: AppBar(title: Text("Şifremi Unuttum")),
        body: CustomListView(
          service: viewModel.service,
          children: [
            AppIcon(
              assest: IconAssest.logo,
              width: 50,
              height: 50,
            ),
            CustomTextField(
              controller: nameController,
              labelText: "Kullanıcı Adı / Mail / Telefon",
              obscureText: true,
            ),
            constraintSmall,
            PrimaryButton(
                text: "Şifreyi Gönder",
                onPressed: () {
                  register();
                })
          ],
        ));
  }
}
