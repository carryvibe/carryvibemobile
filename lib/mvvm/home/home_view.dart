import 'package:carryvibemobile/manager/user_default_manager.dart';
import 'package:carryvibemobile/mvvm/home/ads/ads_view.dart';
import 'package:carryvibemobile/mvvm/home/deliveries/deliveries_view.dart';
import 'package:carryvibemobile/mvvm/home/home_model.dart';
import 'package:carryvibemobile/mvvm/home/inbox/inbox_view.dart';
import 'package:carryvibemobile/mvvm/home/profil/profil_view.dart';
import 'package:carryvibemobile/mvvm/home/publish/publish_view.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:carryvibemobile/util/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(UserDefaultManager.shared().getValue("token"));
    return HomeScreen();
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<BottomBarModel> model = [
    BottomBarModel(title: "İlanlar", icon: Icon(Icons.search), view: AdsView()),
    BottomBarModel(
        title: "Yayınla",
        icon: Icon(Icons.add_circle_outline),
        view: PublishScreen()),
    BottomBarModel(
        title: "Teslimatlar",
        icon: Icon(Icons.directions_car),
        view: DeliveriesView()),
    BottomBarModel(
        title: "Gelen Kutusu", icon: Icon(Icons.message), view: InboxView()),
    BottomBarModel(
        title: "Profil", icon: Icon(Icons.person), view: ProfilView()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        leading: GFIconButton(
          icon: AppIcon(
            assest: IconAssest.deliveryManMarker,
          ),
          color: Colors.white,
          onPressed: () {},
          type: GFButtonType.transparent,
        ),
        title: Text(model[_currentIndex].title),
        actions: <Widget>[
          GFIconButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {},
            type: GFButtonType.transparent,
          ),
        ],
      ),
      body: model[_currentIndex].view,
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        backgroundColor: appColor,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          for (int i = 0; i < model.length; i++)
            BottomNavigationBarItem(
              icon: model[i].icon,
              label: model[i].title,
              backgroundColor: appColor,
            ),
        ],
      ),
    );
  }
}
