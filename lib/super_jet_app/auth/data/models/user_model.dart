import 'package:superjet/super_jet_app/auth/domain/entities/user_entities.dart';

class UserModel extends UserEntities{
  UserModel({
    required super.name, required super.email, required super.password,
    required super.phone, required super.uId, required super.lat,
    required super.long, required super.city, required super.type,
    required super.tripIdList, required super.profileImage, required super.coverImage});

  factory UserModel.fromJson(Map<String,dynamic> data) {
    // Map data=doc.data() as Map<String,dynamic>;
    return UserModel(
        name: data['name'],
        email:data['email'],
        password:data['password'],
        phone: data['phone'],
        uId: data['uId'],
        lat: data['lat'],
        long: data['long'],
        city:data['city'],
        type: data['type'],
        profileImage: data['profileImage'],
        coverImage:data['coverImage'],
        tripIdList: List<TripID>.from(data['trips'].map((e)=>TripID.fromJson(e))),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name':name,
      'email':email,
      'password':password,
      'phone':phone,
      'uId':uId,
      'lat':lat,
      'long':long,
      'city':city,
      'type':type,
      'profileImage':profileImage,
      'coverImage':coverImage,
      'trips':tripIdList,
    };
  }
}