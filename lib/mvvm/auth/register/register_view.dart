import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/customviews/custom_contract.dart';
import 'package:carryvibemobile/customviews/custom_textfield.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/auth/register/register_model.dart';
import 'package:carryvibemobile/mvvm/auth/register/register_viewmodel.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:carryvibemobile/util/app_icon.dart';
import 'package:carryvibemobile/util/enums.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class RegisterView extends StatelessWidget {
  final RegisterViewModel viewModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordSendController = TextEditingController();
  RegisterView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    void register() async {
      if (nameController.text != "" &&
          surnameController.text != "" &&
          emailController.text != "" &&
          phoneController.text != "" &&
          passwordController.text != "" &&
          passwordSendController.text != "") {
        if (passwordController.text.length < 6) {
          GFToast.showToast("Şifreniz en az 6 haneli olmalıdır.", context,
              toastPosition: GFToastPosition.BOTTOM);
          return;
        }
        if (passwordController.text != passwordSendController.text) {
          GFToast.showToast("Şifreler Aynı Değil", context,
              toastPosition: GFToastPosition.BOTTOM);
          return;
        }
        var response = await viewModel.postRequest(RegisterRequestModel(
            firstName: nameController.text,
            lastName: surnameController.text,
            userName: userNameController.text,
            email: emailController.text,
            phone: phoneController.text,
            password: passwordController.text));
        GFToast.showToast(response?.message, context,
            toastPosition: GFToastPosition.BOTTOM);
        if (response?.isStatus == true) {
          Navigator.pop(context);
        }
      } else {
        GFToast.showToast("Lütfen Eksikleri tamamlayınız", context,
            toastPosition: GFToastPosition.BOTTOM);
        return;
      }
    }

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
              controller: nameController,
              labelText: "Ad",
              obscureText: true,
            ),
            constraintSmall,
            CustomTextField(
              controller: surnameController,
              labelText: "Soyad",
              obscureText: true,
            ),
            constraintSmall,
            CustomTextField(
              controller: userNameController,
              labelText: "Kullanıcı Adı",
              obscureText: true,
            ),
            constraintSmall,
            CustomTextField(
              controller: emailController,
              labelText: "Mail Adresi",
              obscureText: true,
            ),
            constraintSmall,
            CustomTextField(
              controller: phoneController,
              labelText: "Telefon",
              obscureText: true,
            ),
            constraintSmall,
            CustomTextField(
              controller: passwordController,
              labelText: "Şifre",
              obscureText: true,
            ),
            constraintSmall,
            CustomTextField(
              controller: passwordSendController,
              labelText: "Şifre Tekrar",
              obscureText: true,
            ),
            constraintSmall,
            PrimaryButton(
                text: "KAYIT OL",
                onPressed: () {
                  register();
                }),
            constraintSmall,
            CustomContract(
                text: "Üyelik sözleşmesini okudum ve",
                textButton: "onaylıyorum.",
                contract: Contract.uyelikSozlesmesi,
                service: viewModel.service),
            CustomContract(
                text:
                    "CarryVibe Gizlilik ve KVKK Bildirimi - Yurtdışı Aktarımı Açık Rıza Beyanını okudum",
                textButton: "onaylıyorum",
                contract: Contract.kvkk,
                service: viewModel.service)
          ],
        ));
  }
}
