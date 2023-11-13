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
  final Function(Places) onLocationSelected;
  final SearchViewModel viewModel;

  SearchScreen({required this.onLocationSelected, required this.viewModel});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = "";
  List<Places> filteredPlaces = [];

  @override
  void initState() {
    super.initState();
    filteredPlaces = widget.viewModel.places; // Başlangıçta tüm yerleri listele
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery.toLowerCase();
      filteredPlaces = widget.viewModel.places
          .where((place) => place.name.toLowerCase().contains(searchQuery))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konum'),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: updateSearchQuery,
              decoration: InputDecoration(
                labelText: 'Arama',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPlaces.length,
              itemBuilder: (context, index) {
                final item = filteredPlaces[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.formattedAdres ?? ""),
                  onTap: () => widget.onLocationSelected(item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
