import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/search_model.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/search_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/search_viewmodel.dart';
import 'package:carryvibemobile/mvvm/home/publish/carrier_publish/carrier_publish_view.dart';
import 'package:carryvibemobile/mvvm/home/publish/publish_viewmodel.dart';
import 'package:carryvibemobile/mvvm/home/publish/sender_publish/sender_publish_view.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:carryvibemobile/util/enums.dart';
import 'package:flutter/material.dart';

class PublishView extends StatelessWidget {
  PublishViewModel viewModel;
  PublishView({required this.viewModel});
  @override
  Widget build(BuildContext context) {
    return PublishScreen(
      viewModel: viewModel,
    );
  }
}

class PublishScreen extends StatefulWidget {
  PublishViewModel viewModel;
  PublishScreen({required this.viewModel});
  @override
  _PublishScreenState createState() =>
      _PublishScreenState(viewModel: viewModel);
}

class _PublishScreenState extends State<PublishScreen>
    with SingleTickerProviderStateMixin {
  PublishViewModel viewModel;
  _PublishScreenState({required this.viewModel});

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
          onLocationSelected: (Places location) {
            Navigator.pop(context, location);
          },
          viewModel: SearchViewModel(service: Service.shared(), places: [
            Places(
                id: "id",
                formattedAdres: "formattedAdres",
                lat: 0,
                lng: 0,
                name: "name")
          ]),
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
            CarrierPublishView(viewModel: viewModel)
          else
            SenderPublishView(viewModel: viewModel)
        ],
      ),
    ]);
  }
}
