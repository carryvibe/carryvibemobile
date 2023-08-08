import 'package:carryvibemobile/mvvm/home/publish/sender_publish/sender_publish_model.dart';

class SenderAdsModel {
  final String? userName;
  final String? userAvatar;
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

  const SenderAdsModel(
      {required this.userName,
      required this.userAvatar,
      required this.id,
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

  factory SenderAdsModel.fromJson(Object? json) {
    var jsonConverter = json as Map<String, dynamic>;
    return SenderAdsModel(
        userName: jsonConverter?['userName'],
        userAvatar: jsonConverter?['formattedAdres'],
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

class CarrierAdsModel {
  final String? userName;
  final String? userAvatar;
  final int? id;
  final int? userId;
  final int? senderId;
  final String? description;
  final String? cargoSize;
  final String? travelType;
  final int? cargoWeight;
  final String? departurePlacesId;
  final String? departurePoint;
  final String? departureCity;
  final String? departureCountry;
  final String? departureDistrict;
  final String? departureAddress;
  final String? departureTime;
  final String? destinationPlacesId;
  final String? destinationPoint;
  final String? destinationCity;
  final String? destinationCountry;
  final String? destinationDistrict;
  final String? destinationAddress;
  final String? destinationTime;
  final String? photoFirst;
  final String? photoSecond;
  final String? photoThird;
  final String? approvedStatus;
  final bool? deliveryStatus;

  const CarrierAdsModel(
      {required this.userName,
      required this.userAvatar,
      required this.id,
      required this.userId,
      required this.senderId,
      required this.description,
      required this.cargoSize,
      required this.travelType,
      required this.cargoWeight,
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
      required this.destinationTime,
      required this.photoFirst,
      required this.photoSecond,
      required this.photoThird,
      required this.approvedStatus,
      required this.deliveryStatus});

  factory CarrierAdsModel.fromJson(Object? json) {
    var jsonConverter = json as Map<String, dynamic>;
    return CarrierAdsModel(
        userName: jsonConverter?['userName'],
        userAvatar: jsonConverter?['formattedAdres'],
        id: jsonConverter?['id'],
        userId: jsonConverter?['userId'],
        senderId: jsonConverter?['senderId'],
        description: jsonConverter?['description'],
        cargoSize: jsonConverter?['cargoSize'],
        travelType: jsonConverter?['travelType'],
        cargoWeight: jsonConverter?['cargoWeight'],
        departurePlacesId: jsonConverter?['departurePlacesId'],
        departurePoint: jsonConverter?['departurePoint'],
        departureCity: jsonConverter?['departureCity'],
        departureCountry: jsonConverter?['departureCountry'],
        departureDistrict: jsonConverter?['departureDistrict'],
        departureAddress: jsonConverter?['departureAddress'],
        departureTime: jsonConverter?['departureTime'],
        destinationPlacesId: jsonConverter?['destinationPlacesId'],
        destinationPoint: jsonConverter?['destinationPoint'],
        destinationCity: jsonConverter?['destinationCity'],
        destinationCountry: jsonConverter?['destinationCountry'],
        destinationDistrict: jsonConverter?['destinationDistrict'],
        destinationAddress: jsonConverter?['destinationAddress'],
        destinationTime: jsonConverter?['destinationTime'],
        photoFirst: jsonConverter?['photoFirst'],
        photoSecond: jsonConverter?['photoSecond'],
        photoThird: jsonConverter?['photoThird'],
        approvedStatus: jsonConverter?['approvedStatus'],
        deliveryStatus: jsonConverter?['deliveryStatus']);
  }
}
