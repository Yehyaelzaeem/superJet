import 'package:superjet/super_jet_app/app_layout/domain/entities/chairs_entitiies.dart';

class ChairsModel extends ChairsEntities{
  ChairsModel({required super.passengerID, required super.chairID, required super.isAvailable});
  factory ChairsModel.fromJson(Map<String, dynamic> json) {
    return ChairsModel(
        passengerID: json['passengerID'],
        chairID:  json['chairID'],
        isAvailable:  json['isAvailable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "passengerID": passengerID,
      "chairID":  chairID,
      "isAvailable":  isAvailable,
    };
  }
}