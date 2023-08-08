class Places {
  String id;
  String formattedAdres;
  double lat;
  double lng;
  String name;
  Places(
      {required this.id,
      required this.formattedAdres,
      required this.lat,
      required this.lng,
      required this.name});

  Map<String, dynamic> toJson() => {
        'id': id,
        'formattedAdres': formattedAdres,
        'lat': lat,
        'lng': lng,
        'name': name,
      };

  factory Places.fromJson(Object? json) {
    var jsonConverter = json as Map<String, dynamic>;
    return Places(
        id: jsonConverter?['id'],
        formattedAdres: jsonConverter?['formattedAdres'],
        lat: jsonConverter?['lat'],
        lng: jsonConverter?['lng'],
        name: jsonConverter?['name']);
  }
}
