import 'package:carryvibemobile/manager/user_default_manager.dart';
import 'package:carryvibemobile/mvvm/home/ads/ads_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/ads_viewmodel.dart';
import 'package:carryvibemobile/mvvm/home/deliveries/deliveries_view.dart';
import 'package:carryvibemobile/mvvm/home/home_model.dart';
import 'package:carryvibemobile/mvvm/home/profil/profil_view.dart';
import 'package:carryvibemobile/mvvm/home/publish/publish_view.dart';
import 'package:carryvibemobile/mvvm/home/publish/publish_viewmodel.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class HomeView extends StatelessWidget {
  final Service service;
  const HomeView({Key? key, required this.service}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(UserDefaultManager.shared().getValue("token"));
    return HomeScreen(service: service);
  }
}

class HomeScreen extends StatefulWidget {
  final Service service;
  const HomeScreen({Key? key, required this.service}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState(service: service);
}

class _HomeScreenState extends State<HomeScreen> {
  final Service service;
  _HomeScreenState({required this.service}) {
    adsView = AdsView(viewModel: AdsViewModel(service: service));
    publishView = PublishView(
      viewModel: PublishViewModel(service: service),
    );
    //inboxView = const InboxView();
    //profilView = const ProfilView();
    model = [
      BottomBarModel(title: "İlanlar", icon: Icon(Icons.search), view: adsView),
      BottomBarModel(
          title: "Yayınla",
          icon: Icon(Icons.add_circle_outline),
          view: publishView),
      BottomBarModel(
          title: "Teslimatlar",
          icon: Icon(Icons.directions_car),
          view: DeliveriesView()),
      /*BottomBarModel(
          title: "Gelen Kutusu", icon: Icon(Icons.message), view: InboxView()),
      BottomBarModel(
          title: "Profil", icon: Icon(Icons.person), view: ProfilView()),*/
    ];
  }

  int _currentIndex = 0;
  late List<BottomBarModel> model;
  late AdsView adsView;
  late PublishView publishView;
  //late InboxView inboxView;
  //late ProfilView profilView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        /*leading: GFIconButton(
          icon: AppIcon(
            assest: IconAssest.deliveryManMarker,
          ),
          color: Colors.white,
          onPressed: () {},
          type: GFButtonType.transparent,
        ),*/
        title: Text(model[_currentIndex].title),
        actions: <Widget>[
          GFIconButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilView(service: service),
                        fullscreenDialog: true));
              });
            },
            type: GFButtonType.transparent,
          ),
        ],
      ),
      body: model[_currentIndex].view,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
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
