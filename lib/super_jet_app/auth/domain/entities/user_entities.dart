class UserEntities{
  final String name;
  final String email;
  final String password;
  final String phone;
  final String uId;
  final String lat;
  final String long;
  final String city;
  final String type;
  final String wallet;
  final String token;
  final String? profileImage;
  final String? coverImage;
  List<TripID>? tripIdList;

  UserEntities(
  {
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.uId,
    required this.lat,
    required this.long,
    required this.city,
    required this.type,
    required this.wallet,
    required this.token,
     this.profileImage,
     this.coverImage,
     this.tripIdList,
});

}
class TripID{
  final String tripID;
  final int chairID;
  TripID({
    required this.tripID,
    required this.chairID
});

  factory TripID.fromJson(Map<String, dynamic> json) {
    return TripID(
      tripID: json["tripID"],
      chairID: json["chairID"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "tripID": tripID,
      "chairID": chairID,
    };
  }
}
