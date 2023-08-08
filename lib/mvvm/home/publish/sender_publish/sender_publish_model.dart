class SenderRequestModel {
  final String content;
  final String description;
  final String cargoSize;
  final int cargoWeight;
  final String departurePlacesId;
  final String departurePoint;
  final String departureCity;
  final String departureCountry;
  final String departureDistrict;
  final String departureAddress;
  final String destinationPlacesId;
  final String destinationPoint;
  final String destinationCity;
  final String destinationCountry;
  final String destinationDistrict;
  final String destinationAddress;
  final String photoFirst;
  final String? photoSecond;
  final String? photoThird;
  final String recipientName;
  final String recipientPhone;

  const SenderRequestModel(
      {required this.content,
      required this.description,
      required this.cargoSize,
      required this.cargoWeight,
      required this.departurePlacesId,
      required this.departurePoint,
      required this.departureCity,
      required this.departureCountry,
      required this.departureDistrict,
      required this.departureAddress,
      required this.destinationPlacesId,
      required this.destinationPoint,
      required this.destinationCity,
      required this.destinationCountry,
      required this.destinationDistrict,
      required this.destinationAddress,
      required this.photoFirst,
      required this.photoSecond,
      required this.photoThird,
      required this.recipientName,
      required this.recipientPhone});

  Map<String, dynamic> toJson() => {
        'content': content,
        'description': description,
        'cargoSize': cargoSize,
        'cargoWeight': cargoWeight,
        'departurePlacesId': departurePlacesId,
        'departurePoint': departurePoint,
        'departureCity': departureCity,
        'departureCountry': departureCountry,
        'departureDistrict': departureDistrict,
        'departureAddress': departureAddress,
        'destinationPlacesId': destinationPlacesId,
        'destinationPoint': destinationPoint,
        'destinationCity': destinationCity,
        'destinationCountry': destinationCountry,
        'destinationDistrict': destinationDistrict,
        'destinationAddress': destinationAddress,
        'photoFirst': photoFirst,
        'photoSecond': photoSecond,
        'photoThird': photoThird,
        'recipientName': recipientName,
        'recipientPhone': recipientPhone,
      };
}

class Sender {
  final int? id;
  final int? userId;
  final int? carrierId;
  final String? content;
  final String? description;
  final String? cargoSize;
  final int? cargoWeight;
  final String? departurePlacesId;
  final String? departurePoint;
  final String? departureCity;
  final String? departureCountry;
  final String? departureDistrict;
  final String? departureAddress;
  final String? destinationPlacesId;
  final String? destinationPoint;
  final String? destinationCity;
  final String? destinationCountry;
  final String? destinationDistrict;
  final String? destinationAddress;
  final String? recipientName;
  final String? recipientPhone;
  final String? amount;
  final String? photoFirst;
  final String? photoSecond;
  final String? photoThird;
  final String? approvedStatus;
  final bool? deliveryStatus;
  const Sender(
      {required this.id,
      required this.userId,
      required this.carrierId,
      required this.content,
      required this.description,
      required this.cargoSize,
      required this.cargoWeight,
      required this.departurePlacesId,
      required this.departurePoint,
      required this.departureCity,
      required this.departureCountry,
      required this.departureDistrict,
      required this.departureAddress,
      required this.destinationPlacesId,
      required this.destinationPoint,
      required this.destinationCity,
      required this.destinationCountry,
      required this.destinationDistrict,
      required this.destinationAddress,
      required this.amount,
      required this.photoFirst,
      required this.photoSecond,
      required this.photoThird,
      required this.recipientName,
      required this.recipientPhone,
      required this.approvedStatus,
      required this.deliveryStatus});

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'carrierId': carrierId,
        'content': content,
        'description': description,
        'cargoSize': cargoSize,
        'cargoWeight': cargoWeight,
        'departurePlacesId': departurePlacesId,
        'departurePoint': departurePoint,
        'departureCity': departureCity,
        'departureCountry': departureCountry,
        'departureDistrict': departureDistrict,
        'departureAddress': departureAddress,
        'destinationPlacesId': destinationPlacesId,
        'destinationPoint': destinationPoint,
        'destinationCity': destinationCity,
        'destinationCountry': destinationCountry,
        'destinationDistrict': destinationDistrict,
        'destinationAddress': destinationAddress,
        'amount': amount,
        'photoFirst': photoFirst,
        'photoSecond': photoSecond,
        'photoThird': photoThird,
        'recipientName': recipientName,
        'recipientPhone': recipientPhone,
        'approvedStatus': approvedStatus,
        'deliveryStatus': deliveryStatus
      };

  factory Sender.fromJson(Object? json) {
    var jsonConverter = json as Map<String, dynamic>;
    return Sender(
        id: jsonConverter?['id'],
        userId: jsonConverter?['userId'],
        carrierId: jsonConverter?['carrierId'],
        content: jsonConverter?['content'],
        description: jsonConverter?['description'],
        cargoSize: jsonConverter?['cargoSize'],
        cargoWeight: jsonConverter?['cargoWeight'],
        departurePlacesId: jsonConverter?['departurePlacesId'],
        departurePoint: jsonConverter?['departurePoint'],
        departureCity: jsonConverter?['departureCity'],
        departureCountry: jsonConverter?['departureCountry'],
        departureDistrict: jsonConverter?['departureDistrict'],
        departureAddress: jsonConverter?['departureAddress'],
        destinationPlacesId: jsonConverter?['destinationPlacesId'],
        destinationPoint: jsonConverter?['destinationPoint'],
        destinationCity: jsonConverter?['destinationCity'],
        destinationCountry: jsonConverter?['destinationCountry'],
        destinationDistrict: jsonConverter?['destinationDistrict'],
        destinationAddress: jsonConverter?['destinationAddress'],
        amount: jsonConverter?['amount'],
        photoFirst: jsonConverter?['photoFirst'],
        photoSecond: jsonConverter?['photoSecond'],
        photoThird: jsonConverter?['photoThird'],
        recipientName: jsonConverter?['recipientName'],
        recipientPhone: jsonConverter?['recipientPhone'],
        approvedStatus: jsonConverter?['approvedStatus'],
        deliveryStatus: jsonConverter?['deliveryStatus']);
  }
}
