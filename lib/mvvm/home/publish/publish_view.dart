import 'package:carryvibemobile/customviews/custom_button.dart';
import 'package:carryvibemobile/customviews/custom_textfield.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/ads_model.dart';
import 'package:carryvibemobile/mvvm/home/publish/carrier_publish/carrier_publish_view.dart';
import 'package:carryvibemobile/mvvm/home/publish/sender_publish/sender_publish_view.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class PublishView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PublishScreen();
  }
}

class PublishScreen extends StatefulWidget {
  @override
  _PublishScreenState createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen>
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
    return CustomListView(service: Service.shared(), children: [
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
          if (selected == AdsStatus.carrier)
            CarrierPublishView()
          else
            SenderPublishView()
        ],
      ),
    ]);
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
