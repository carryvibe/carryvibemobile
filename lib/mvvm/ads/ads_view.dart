import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/customviews/custom_textfield.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/ads/ads_model.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AdsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdsScreen();
  }
}

class AdsScreen extends StatefulWidget {
  @override
  _AdsScreenState createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen>
    with SingleTickerProviderStateMixin {
  AdsStatus selected = AdsStatus.sender;

  TextEditingController startLocation = TextEditingController();
  TextEditingController finishLocation = TextEditingController();
  TextEditingController date = TextEditingController();

  @override
  void dispose() {
    startLocation.dispose();
    super.dispose();
  }

  void _openSearchScreen(
      BuildContext context, TextEditingController controller) async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SearchScreen(
          onLocationSelected: (String location) {
            Navigator.pop(context, location);
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        controller.text = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomView(
      children: [
        SizedBox(height: 8),
        SegmentedButton<AdsStatus>(
          segments: const [
            ButtonSegment<AdsStatus>(
                value: AdsStatus.sender, label: Text("Kargo")),
            ButtonSegment<AdsStatus>(
                value: AdsStatus.carrier, label: Text("Kurye"))
          ],
          selected: <AdsStatus>{selected},
          onSelectionChanged: (Set<AdsStatus> newSelection) {
            setState(() {
              selected = newSelection.first;
            });
          },
        ),
        //if (selected == AdsStatus.sender) Text("kurye") else Text("Kargo")
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTitleLineTextField(
              controller: startLocation,
              title: "Nereden",
              labelText: "Başlangıç noktasını girin",
              onTap: () => _openSearchScreen(context, startLocation),
              onChanged: (value) {
                setState(() {
                  startLocation.text = value;
                });
              },
            ),
            CustomTitleLineTextField(
              controller: finishLocation,
              title: "Nereye",
              labelText: "Varış noktasını girin",
              onTap: () => _openSearchScreen(context, finishLocation),
              onChanged: (value) {
                setState(() {
                  finishLocation.text = value;
                });
              },
            ),
            CustomTitleLineTextField(
              controller: date,
              title: "Tarih",
              labelText: "Yolculuk tarihini girin",
              onTap: () => _openSearchScreen(context, date),
              onChanged: (value) {
                setState(() {
                  date.text = value;
                });
              },
            ),
            SizedBox(height: 24),
            PrimaryButton(
              onPressed: () {},
              text: "Ara",
            ),
            SizedBox(height: 16.0),
            GFListTile(
              avatar: GFAvatar(
                child: Icon(Icons.history),
                backgroundColor: Colors.white,
              ),
              titleText: 'İstanbul, Türkiye -> Bursa, Türkiye',
              color: Colors.white,
              onTap: () => {print("asdf")},
            ),
            GFListTile(
              avatar: GFAvatar(
                child: Icon(Icons.history),
                backgroundColor: Colors.white,
              ),
              titleText: 'İstanbul, Türkiye -> Bursa, Türkiye',
              color: Colors.white,
              onTap: () => {print("asdf")},
            )
          ],
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }
}

class SearchScreen extends StatelessWidget {
  final Function(String) onLocationSelected;

  SearchScreen({required this.onLocationSelected});

  List list = [
    "Flutter",
    "React",
    "Ionic",
    "Xamarin",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GFSearchBar(
            searchList: list,
            searchQueryBuilder: (query, list) {
              return list
                  .where((item) =>
                      item.toLowerCase().contains(query.toLowerCase()))
                  .toList();
            },
            overlaySearchListItemBuilder: (item) {
              return Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 18),
                ),
              );
            },
            onItemSelected: (item) {
              print("$item");
              onLocationSelected("$item");
            },
          ),
        ],
      ),
    );
  }
}
