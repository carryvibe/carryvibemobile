import 'package:carryvibemobile/customviews/custom_menu.dart';
import 'package:carryvibemobile/customviews/custom_profile.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/manager/user_default_manager.dart';
import 'package:carryvibemobile/mvvm/auth/login/login_view.dart';
import 'package:carryvibemobile/mvvm/auth/login/login_viewmodel.dart';
import 'package:carryvibemobile/mvvm/auth/verifyId/verify_view.dart';
import 'package:carryvibemobile/mvvm/auth/verifyId/verify_viewmodel.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ProfilView extends StatelessWidget {
  final Service service;
  const ProfilView({required this.service, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProfilScreen(service: service);
  }
}

class ProfilScreen extends StatefulWidget {
  final Service service;
  ProfilScreen({required this.service});
  @override
  _ProfilScreenState createState() => _ProfilScreenState(service: service);
}

class _ProfilScreenState extends State<ProfilScreen> {
  final Service service;
  _ProfilScreenState({required this.service});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(title: Text("Profil")),
      body: CustomListView(
          service: Service.shared(),
          constraint: false,
          children: [
            constraint,
            CustomProfile(),
            constraint,
            /*
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
            */
            constraint,
            //CustomMenu(icon: Icon(Icons.settings), title: "Ayarlar"),
            //CustomMenu(icon: Icon(Icons.settings), title: "Kampanya Kodları"),
            CustomMenu(icon: Icon(Icons.settings), title: "Bize Ulaşın"),
            CustomMenu(
              icon: Icon(Icons.settings),
              title: "Kimliğini Doğrula",
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VerifyView(
                            viewModel: VerifyViewModel(service: this.service)),
                        fullscreenDialog: true))
              },
            ),
            CustomMenu(
                icon: Icon(Icons.settings), title: "Uygulamaya Puan Ver"),
            //CustomMenu(icon: Icon(Icons.settings), title: "Şart ve Koşullar"),
            CustomMenu(
              icon: Icon(Icons.settings),
              title: "Çıkış Yap",
              onTap: () => {logout()},
            ),
          ]),
    );
  }

  void logout() async {
    await UserDefaultManager.shared().removeValue(UserKeys.token);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              LoginView(viewModel: LoginViewModel(service: service))),
    );
  }
}
