import 'dart:async';

import 'package:carryvibemobile/util/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectMaps {
  final String Point;
  final String City;
  final String Country;
  final String District;
  final String Address;
  const SelectMaps(
      {required this.Point,
      required this.City,
      required this.Country,
      required this.District,
      required this.Address});
}

class MapSelectLastView extends StatefulWidget {
  final double lat;
  final double long;
  final Function(SelectMaps) selectMaps;
  const MapSelectLastView(
      {required this.lat, required this.long, required this.selectMaps});
  @override
  State<MapSelectLastView> createState() =>
      MapSelectLastState(lat: lat, long: long, selectMaps: selectMaps);
}

class MapSelectLastState extends State<MapSelectLastView> {
  final double lat; //searchlat
  final double long; //searchlong
  String postalCode = ""; //searchpostalcode
  bool isSelected = true;

  double latSelect = 0, longSelect = 0;
  Placemark? place;
  final Function(SelectMaps) selectMaps;
  late CameraPosition _kGooglePlex;
  MapSelectLastState(
      {required this.lat, required this.long, required this.selectMaps});

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const Marker _marker = Marker(
    markerId: MarkerId('marker'),
    infoWindow: InfoWindow(title: "Google Plex"),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(40.999076, 28.7971567),
  );

  @override
  void initState() {
    super.initState();
    getStartedPostalCode();
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 19,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Maps'),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              markers: {_marker},
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              //onLongPress: (argument) => {print("1")},
              //onTap: (argument) => {print("2")},
              onCameraIdle: () => getSelectedAddressFromLatLng(),
              //onCameraMove: (position) => {_getAddressFromLatLng()},
              //onCameraMoveStarted: () => {print("5")},
            ),
            AppIcon(assest: IconAssest.marker, width: 40),
          ],
        ),
        floatingActionButton: Row(children: [
          SizedBox(width: 24),
          FloatingActionButton.extended(
            onPressed: pressed,
            label: Text(isSelected ? 'Konumu Seç' : 'Başlangıç noktasına dön'),
            icon: const Icon(Icons.map),
          ),
          Spacer(),
        ]));
  }

  void pressed() {
    if (isSelected) {
      getCenter();
    } else {
      startPoint();
    }
  }

  void startPoint() async {
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 19,
    );
    final GoogleMapController controller = await _controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  void getSelectedAddressFromLatLng() async {
    final GoogleMapController controller = await _controller.future;
    LatLngBounds visibleRegion = await controller.getVisibleRegion();
    latSelect =
        (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) /
            2;
    longSelect = (visibleRegion.northeast.longitude +
            visibleRegion.southwest.longitude) /
        2;
    await placemarkFromCoordinates(latSelect, longSelect)
        .then((List<Placemark> placemarks) {
      place = placemarks[0];
      setState(() {
        if (place?.postalCode == null) {
          print("boş");
          return;
        }
        isSelected = (place?.postalCode == postalCode);
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> getStartedPostalCode() async {
    await placemarkFromCoordinates(lat, long)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      postalCode = place.postalCode ?? "";
      return place;
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> getCenter() async {
    if (place == null) return;
    selectMaps(SelectMaps(
        Point: latSelect.toString() + "," + longSelect.toString(),
        City: place?.administrativeArea ?? "",
        Country: place?.subAdministrativeArea ?? "",
        District: place?.subLocality ?? "",
        Address: (place?.street ?? "") +
            ", " +
            (place?.locality ?? "") +
            ", " +
            (place?.subLocality ?? "") +
            ", " +
            (place?.administrativeArea ?? "") +
            ", " +
            (place?.subAdministrativeArea ?? "")));
  }
}
