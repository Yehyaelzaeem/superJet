class AddTripModel {
  final String name ;
  final String price ;
  final String time ;
  final String date ;
  final String avgTime;
  final String fromCity ;
  final String image ;
  final String isVip ;
  final String toCity ;
  final String categoryName;
   String state='waiting';

  AddTripModel({
    required this.name,
    required this.price,
    required this.time,
    required this.date,
    required this.avgTime,
    required this.fromCity,
    required this.image,
    required this.isVip,
    required this.toCity,
    required this.categoryName,
    required this.state
  });
}