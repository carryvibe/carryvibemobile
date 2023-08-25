import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/customviews/custom_contract.dart';
import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/customviews/custom_textfield.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/auth/verifyId/verify_model.dart';
import 'package:carryvibemobile/mvvm/auth/verifyId/verify_viewmodel.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:carryvibemobile/util/app_icon.dart';
import 'package:carryvibemobile/util/enums.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class VerifyView extends StatelessWidget {
  final VerifyViewModel viewModel;
  TextEditingController tcknController = TextEditingController();
  TextEditingController dateYearController = TextEditingController();
  VerifyView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    void register() async {
      if (tcknController.text != "" && dateYearController.text != "") {
        var response = await viewModel.verifyTCKN(VerifyModel(
            tckn: tcknController.text, dateYear: dateYearController.text));
        if (response?.isStatus == true) {
          Navigator.pop(context);
        }
        GFToast.showToast(response?.message, context,
            toastPosition: GFToastPosition.BOTTOM);
      } else {
        GFToast.showToast("Lütfen Eksikleri tamamlayınız", context,
            toastPosition: GFToastPosition.BOTTOM);
        return;
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Kimlik Doğrulama"),
        ),
        body: CustomListView(
          service: viewModel.service,
          children: [
            AppIcon(
              assest: IconAssest.logo,
              width: 50,
              height: 50,
            ),
            constraintSmall,
            CustomTextField(
              controller: tcknController,
              labelText: "TC Kimlik Numarası Giriniz",
              obscureText: true,
            ),
            constraintSmall,
            CustomTextField(
              controller: dateYearController,
              labelText: "Doğum Yılı",
              obscureText: true,
            ),
            constraintSmall,
            PrimaryButton(
                text: "Doğrula",
                onPressed: () {
                  register();
                }),
          ],
        ));
  }
}
