import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/customviews/custom_textfield.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:flutter/material.dart';

class SenderPublishView extends StatelessWidget {
  const SenderPublishView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 8),
      CustomSecondLabel(
          text: "Kargonu paylaş, Hızlı ve Güvenli teslim edilsin"),
      constraint,
      CustomTextField(
          controller: TextEditingController(), labelText: "Kargo nedir?"),
      constraint,
      CustomTextField(
          controller: TextEditingController(), labelText: "Kargo Detayları"),
      constraint,
      CustomTextField(
          controller: TextEditingController(), labelText: "Başlangıç noktası"),
      constraint,
      CustomTextField(
          controller: TextEditingController(), labelText: "Bitiş noktası"),
      constraint,
      CustomTextField(controller: TextEditingController(), labelText: "Boyut"),
      constraint,
      PrimaryButton(text: "Gönder", onPressed: () {}),
      SizedBox(height: 8),
    ]);
  }
}
