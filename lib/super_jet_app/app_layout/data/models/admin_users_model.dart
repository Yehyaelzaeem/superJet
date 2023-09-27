import 'package:superjet/super_jet_app/app_layout/domain/entities/users_entities.dart';

import '../../../auth/domain/entities/user_entities.dart';

class UsersTableModel extends UsersEntities {
  UsersTableModel({required super.name, required super.email, required super.phone, required super.uId, required super.city, required super.tripIdList, required super.profileImage});


  factory UsersTableModel.fromJson(Map<String, dynamic> json) {
    return UsersTableModel(
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      uId: json["uId"],
      city: json["city"],
      tripIdList:  List<TripID>.from(json['trips'].map((e)=>TripID.fromJson(e))),
      profileImage: json["profileImage"],
    );
  }
//
}