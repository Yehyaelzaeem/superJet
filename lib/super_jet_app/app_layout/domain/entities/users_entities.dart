import '../../../auth/domain/entities/user_entities.dart';

class UsersEntities{
  final String name;
  final String email;
  final String password;
  final String phone;
  final String uId;
  final String long;
  final String lat;
  final String city;
  final String type;
  final String token;
  List<TripID>? tripIdList;
  final String profileImage;
  bool selected =false;

  UsersEntities({
    required this.name,
    required  this.email,
    required this.phone,
    required  this.uId,
    required  this.city,
    required  this.profileImage,
    required this.tripIdList,
    required this.password,
    required this.long,
    required this.lat,
    required this.type,
    required this.token,
  });
}