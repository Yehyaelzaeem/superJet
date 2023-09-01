part of 'trips_bloc.dart';

abstract class TripsEvent {}
//Categories
class GetCategoriesTripsEvent extends TripsEvent{}

//Trips
class GetTripsEvent extends TripsEvent{
  final String city;
  BuildContext context ;
  GetTripsEvent(this.city,this.context);
}

//CustomTrips
class GetCustomToTripsEvent extends TripsEvent{
  final String name;
  BuildContext context ;
  GetCustomToTripsEvent(this.name,this.context);
}
class GetTestTripsEvent extends TripsEvent{}
class GetCustomFromTripsEvent extends TripsEvent{
  final String name;
  BuildContext context ;
  GetCustomFromTripsEvent(this.name,this.context);
}
class GetCurrentTripsEvent extends TripsEvent{
  List<TripID> tripId;
  BuildContext context ;
  GetCurrentTripsEvent(this.tripId,this.context);
}

//Profile
class GetProfileEvent extends TripsEvent{
  BuildContext context ;
  GetProfileEvent(this.context);
}


//SignOut
class SignOutEvent extends TripsEvent{
  BuildContext context;
  SignOutEvent(this.context);
}


//Image && Profile
class EditProfileImageEvent extends TripsEvent{
  BuildContext context;
  EditProfileImageEvent(this.context);
}
class EditCoverImageEvent extends TripsEvent{
  BuildContext context;
  EditCoverImageEvent(this.context);
}
class UpdateProfileEvent extends TripsEvent{
  final String name;
  final String subName;

  final String phone;
  final String subPhone;
  final String coverImage;
  final String subCoverImage;
  final String profileImage;
  final String subProfileImage;
  BuildContext context;

  UpdateProfileEvent(
      this.name,
      this.subName,
      this.phone,
      this.subPhone,
      this.coverImage,
      this.subCoverImage,
      this.profileImage,
      this.subProfileImage,
      this.context);
}
class IsUpdatingEvent extends TripsEvent{
bool x ;
IsUpdatingEvent(this.x);
}

