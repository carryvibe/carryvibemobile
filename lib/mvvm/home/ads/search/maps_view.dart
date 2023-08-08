import 'dart:async';

import 'package:carryvibemobile/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const Marker _marker = Marker(
    markerId: MarkerId('marker'),
    infoWindow: InfoWindow(title: "Google Plex"),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(40.999076, 28.7971567),
  );

  static const Marker _marker1 = Marker(
    markerId: MarkerId('marker1'),
    infoWindow: InfoWindow(title: "Google Plex1"),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(41.004984, 28.79725699999999),
  );

  static const Polyline _polyline = Polyline(
    polylineId: PolylineId("polyline"),
    points: [
      LatLng(40.999076, 28.7971567),
      LatLng(41.004984, 28.79725699999999)
    ],
    width: 5,
    color: appColor,
  );
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.999076, 28.7971567),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(40.999076, 28.7971567),
      tilt: 59.440717697143555,
      zoom: 20.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        markers: {_marker, _marker1},
        polylines: {_polyline},
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Future<void> getDirections() async {}

  Future<LatLng> getCenter() async {
    final GoogleMapController controller = await _controller.future;
    LatLngBounds visibleRegion = await controller.getVisibleRegion();
    LatLng centerLatLng = LatLng(
      (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) / 2,
      (visibleRegion.northeast.longitude + visibleRegion.southwest.longitude) /
          2,
    );

    return centerLatLng;
  }
}
