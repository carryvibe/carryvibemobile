import 'package:carryvibemobile/customviews/custom_history.dart';
import 'package:carryvibemobile/customviews/custom_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/maps_select_last_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/maps_view.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/search_model.dart';
import 'package:carryvibemobile/mvvm/home/ads/search/search_viewmodel.dart';
import 'package:carryvibemobile/newtorklayer/service.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class SearchView extends StatelessWidget {
  @override
  final Function(Places) onLocationSelected;
  final SearchViewModel viewModel;
  SearchView({required this.onLocationSelected, required this.viewModel});
  Widget build(BuildContext context) {
    return SearchScreen(
      onLocationSelected: onLocationSelected,
      viewModel: viewModel,
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  final Function(Places) onLocationSelected;
  final SearchViewModel viewModel;
  SearchScreen({required this.onLocationSelected, required this.viewModel});
  _SearchScreenState createState() => _SearchScreenState(
      onLocationSelected: onLocationSelected, viewModel: viewModel);
}

class _SearchScreenState extends State<SearchScreen> {
  final Function(Places) onLocationSelected;
  final SearchViewModel viewModel;

  _SearchScreenState(
      {required this.onLocationSelected, required this.viewModel});
  @override
  Widget build(BuildContext context) {
    final places = viewModel.places;
    return Scaffold(
        appBar: AppBar(
          title: Text('Konum'),
        ),
        body: CustomListView(
          service: viewModel.service,
          children: [
            GFSearchBar(
              searchList: places,
              searchQueryBuilder: (query, list) async {
                // You can perform any asynchronous filtering here if needed
                return await list
                    .where((item) =>
                        item.name.toLowerCase().contains(query.toLowerCase()))
                    .toList();
              },
              overlaySearchListItemBuilder: (Places? item) {
                // Change the parameter type to String?
                return Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        item?.name ?? "",
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        item?.formattedAdres ?? "",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                );
              },
              onItemSelected: (Places? item) {
                // Change the parameter type to String?
                if (item != null) {
                  onLocationSelected(item);
                }
              },
            ),

            /*
            HistoryView(
                text: 'İstanbul, Türkiye -> Bursa, Türkiye',
                onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MapSelectLastView(
                                    lat: 40.999096,
                                    long: 28.7971599,
                                  ),
                              fullscreenDialog: true))
                    })*/
          ],
        ));
  }
}
