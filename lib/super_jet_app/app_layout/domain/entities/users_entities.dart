import '../../../auth/domain/entities/user_entities.dart';

class UsersEntities{
  final String name;
  final String email;
  final String phone;
  final String uId;
  final String city;
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
  });
}