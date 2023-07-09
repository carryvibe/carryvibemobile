import 'package:carryvibemobile/util/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFCard(
      boxFit: BoxFit.cover,
      content: Text("Kampanya"),
      buttonBar: GFButtonBar(
        children: <Widget>[AppIcon(assest: IconAssest.logo, width: 30)],
      ),
    );
  }
}
