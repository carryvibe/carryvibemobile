class CarrierRequestModel {
  final String description;
  final String cargoSize;
  final String travelType;
  final String departurePlacesId;
  final String departurePoint;
  final String departureCity;
  final String departureCountry;
  final String departureDistrict;
  final String departureAddress;
  final String departureTime;
  final String destinationPlacesId;
  final String destinationPoint;
  final String destinationCity;
  final String destinationCountry;
  final String destinationDistrict;
  final String destinationAddress;
  final String destinationTime;

  const CarrierRequestModel(
      {required this.description,
      required this.cargoSize,
      required this.travelType,
      required this.departurePlacesId,
      required this.departurePoint,
      required this.departureCity,
      required this.departureCountry,
      required this.departureDistrict,
      required this.departureAddress,
      required this.departureTime,
      required this.destinationPlacesId,
      required this.destinationPoint,
      required this.destinationCity,
      required this.destinationCountry,
      required this.destinationDistrict,
      required this.destinationAddress,
      required this.destinationTime});

  Map<String, dynamic> toJson() => {
        'description': description,
        'cargoSize': cargoSize,
        'travelType': travelType,
        'departurePlacesId': departurePlacesId,
        'departurePoint': departurePoint,
        'departureCity': departureCity,
        'departureCountry': departureCountry,
        'departureDistrict': departureDistrict,
        'departureAddress': departureAddress,
        'departureTime': departureTime,
        'destinationPlacesId': destinationPlacesId,
        'destinationPoint': destinationPoint,
        'destinationCity': destinationCity,
        'destinationCountry': destinationCountry,
        'destinationDistrict': destinationDistrict,
        'destinationAddress': destinationAddress,
        'destinationTime': destinationTime,
      };
}
