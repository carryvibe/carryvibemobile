import 'package:geocoding/geocoding.dart';

class MapsManager {
  final double latitude;
  final double longitude;
  MapsManager({
    required this.latitude,
    required this.longitude,
  });

  Future<String?> getPostalCode() async {
    await placemarkFromCoordinates(latitude, longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      return place.postalCode;
    }).catchError((e) {
      print(e);
    });
  }

  Future<Placemark?> getAddressFromLatLng() async {
    await placemarkFromCoordinates(latitude, longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      return place;
    }).catchError((e) {
      print(e);
    });
  }
}
