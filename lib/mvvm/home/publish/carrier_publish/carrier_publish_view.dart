import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/customviews/custom_textfield.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:flutter/material.dart';

class CarrierPublishView extends StatelessWidget {
  const CarrierPublishView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomSecondLabel(text: "Rotanı paylaş, Kargo teslim et"),
      constraint,
      CustomTextField(
          controller: TextEditingController(), labelText: "Başlangıç noktası"),
      constraint,
      CustomTextField(
          controller: TextEditingController(), labelText: "Bitiş noktası"),
      constraint,
      CustomTextField(controller: TextEditingController(), labelText: "Tarih"),
      constraint,
      CustomTextField(controller: TextEditingController(), labelText: "Saat"),
      constraint,
      PrimaryButton(text: "Gönder", onPressed: () {})
    ]);
  }
}
