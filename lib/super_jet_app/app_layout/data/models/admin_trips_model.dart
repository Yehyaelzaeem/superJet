import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/trips_table_data_entities.dart';

class TripsModelDataTable extends TripEntitiesDataTable {
  TripsModelDataTable({required super.name, required super.price, required super.time, required super.date, required super.avgTime, required super.fromCity, required super.image, required super.isVip, required super.toCity, required super.tripID, required super.categoryID, required super.categoryName, required super.state});

  factory TripsModelDataTable.fromJson(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String ,dynamic>;
    return TripsModelDataTable(
      name: data['name'],
      price: data['price'],
      time: data['time'],
      date: data['date'],
      avgTime: data['avgTime'],
      fromCity: data['fromCity'],
      image: data['image'],
      isVip: data['isVip'],
      toCity: data['toCity'],
      tripID: data['tripID'],
      categoryID: data['categoryID'],
      categoryName: data['categoryName'],
      state:  data['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "price":  price,
      "time":  time,
      "date": date,
      "avgTime":  avgTime,
      "fromCity":  fromCity,
      "image": image,
      "isVip": isVip,
      "toCity":  toCity,
      "tripID":  tripID,
      "categoryID": categoryID,
      "categoryName":  categoryName,
      "state":  state,

    };
  }
}
