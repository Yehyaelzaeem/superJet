class TripEntities {
  final String name ;
  final String price ;
  final String time ;
  final String date ;
  final String avgTime;
  final String fromCity ;
  final String image ;
  final String isVip ;
  final String toCity ;
  final String tripID;
  final String categoryID;
  final String categoryName;
  final String state;

  TripEntities({
    required this.name,
    required this.price,
    required this.time,
    required this.date,
    required this.avgTime,
    required this.fromCity,
    required this.image,
    required this.isVip,
    required this.toCity,
    required this.tripID,
    required this.categoryID,
    required this.categoryName,
    required this.state
});
}