import 'package:carryvibemobile/manager/user_default_manager.dart';
import 'package:carryvibemobile/mvvm/app/app_viewmodel.dart';
import 'package:carryvibemobile/mvvm/auth/login/login_view.dart';
import 'package:carryvibemobile/mvvm/auth/login/login_viewmodel.dart';
import 'package:carryvibemobile/mvvm/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AppView extends StatelessWidget {
  final AppViewModel viewModel;

  const AppView({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    String title = "";
    String subTitle = "";
    final LoginViewModel _viewModel = LoginViewModel();
    if (viewModel.appVersion == AppVersion.forceUpdate) {
      title = "Güncelleme Gerekli";
      subTitle = "Devam etmek için uygulamanın son sürümünü güncelleyin.";
    } else if (viewModel.appVersion == AppVersion.suggestionUpdate) {
      title = "Güncel Versiyon Mevcut";
      subTitle =
          "Daha iyi bir deneyim için mobil uygulamanızı güncellemenizi tavsiye ederiz.";
    } else if (viewModel.appVersion == AppVersion.undefield) {
      return GFLoader();
    } else if (viewModel.appVersion == AppVersion.notConnectionNetwork) {
      return Center(child: showAlert());
    } else {
      if (UserDefaultManager.shared().getValue<String>("token") != null) {
        return HomeView();
      } else {
        return LoginView(viewModel: _viewModel);
      }
    }
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 80.0,
                ),
                const SizedBox(height: 20.0),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  subTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Uygulama mağazasına yönlendirme işlemini gerçekleştir
                  },
                  child: const Text('Güncelle'),
                ),
              ] +
              getNextButton(),
        ),
      ),
    );
  }

  List<Widget> getNextButton() {
    var result = <Widget>[];
    if (viewModel.appVersion == AppVersion.suggestionUpdate) {
      result.add(ElevatedButton(
        onPressed: () {},
        child: const Text('Devam Et'),
      ));
    }
    return result;
  }

  GFAlert showAlert() {
    return GFAlert(
      title: "Ağ Bağlantısı Yok",
      subtitle:
          "Uygulamayı kullanmak için internet bağlantınızın olması gerekmektedir. Lütfen bağlantı ayarlarınızı kontrol edip tekrar deneyiniz. ",
      type: GFAlertType.basic,
      bottomBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GFButton(
            onPressed: () {},
            shape: GFButtonShape.pills,
            child: const Text("Tamam"),
          ),
          GFButton(
            onPressed: () {},
            shape: GFButtonShape.pills,
            child: const Text("Vazgeç"),
          ),
        ],
      ),
    );
  }
}
