import 'package:superjet/super_jet_app/app_layout/domain/entities/users_entities.dart';

import '../../../auth/domain/entities/user_entities.dart';

class UsersTableModel extends UsersEntities {
  UsersTableModel({required super.name, required super.email, required super.phone, required super.uId, required super.city, required super.tripIdList, required super.profileImage, required super.password, required super.long, required super.lat, required super.type, required super.token, required super.wallet});


  factory UsersTableModel.fromJson(Map<String, dynamic> json) {
    return UsersTableModel(
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      uId: json["uId"],
      city: json["city"],
      tripIdList:  List<TripID>.from(json['trips'].map((e)=>TripID.fromJson(e))) ,
      profileImage: json["profileImage"],
      password: json["password"],
      long:json["long"],
      lat: json["lat"],
      type: json["type"],
      token: json["token"],
      wallet: json["wallet"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name':name,
      'email':email,
      'password':password,
      'phone':phone,
      'uId':uId,
      'city':city,
      'profileImage':profileImage,
      'long':long,
      'lat':lat,
      'tripIdList':tripIdList,
      'type':type,
      'token':token,
      'wallet':wallet,
    };
  }
}