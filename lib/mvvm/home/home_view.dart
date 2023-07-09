import 'package:carryvibemobile/mvvm/ads/ads_view.dart';
import 'package:carryvibemobile/util/app_constants.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    AdsView(),
    Center(child: Text('Yayınlarım')),
    Center(child: Text('Yolculuklarım')),
    Center(child: Text('Gelen Kutusu')),
    Center(child: Text('Profil'))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CarryVibe'),
      ),
      body: _screens[_currentIndex],
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
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'İlanlar',
            backgroundColor: appColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Yayınla',
            backgroundColor: appColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Yolculuklarım',
            backgroundColor: appColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Gelen Kutusu',
            backgroundColor: appColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
            backgroundColor: appColor,
          ),
        ],
      ),
    );
  }
}
