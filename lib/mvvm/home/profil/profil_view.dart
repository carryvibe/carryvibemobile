import 'package:carryvibemobile/customviews/custom_label.dart';
import 'package:carryvibemobile/customviews/custom_menu.dart';
import 'package:carryvibemobile/customviews/custom_profile.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/app/app_view.dart';
import 'package:carryvibemobile/mvvm/app/app_viewmodel.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:carryvibemobile/util/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ProfilView extends StatelessWidget {
  const ProfilView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProfilScreen();
  }
}

class ProfilScreen extends StatefulWidget {
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  AppViewModel _viewModel = AppViewModel();
  @override
  Widget build(BuildContext context) {
    return CustomListView(
        service: Service.shared(),
        constraint: false,
        children: [
          constraint,
          CustomProfile(name: "Yunus Emre Coşkun"),
          constraint,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(),
              CustomSecondLabel(text: "45\nTaşıma"),
              Spacer(),
              CustomSecondLabel(text: "45\nGönderme"),
              Spacer(),
              CustomSecondLabel(text: "45\nKazanç"),
              Spacer(),
            ],
          ),
          constraint,
          CustomMenu(icon: Icon(Icons.settings), title: "Ayarlar"),
          CustomMenu(icon: Icon(Icons.settings), title: "Kampanya Kodları"),
          CustomMenu(icon: Icon(Icons.settings), title: "Bize Ulaşın"),
          CustomMenu(icon: Icon(Icons.settings), title: "Profilini Doğrula"),
          CustomMenu(icon: Icon(Icons.settings), title: "Uygulamaya Puan Ver"),
          CustomMenu(icon: Icon(Icons.settings), title: "Şart ve Koşullar"),
          CustomMenu(
            icon: Icon(Icons.settings),
            title: "Çıkış Yap",
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => AppView(viewModel: _viewModel)),
              )
            },
          ),
        ]);
  }
}
