import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:superjet/super_jet_app/app_layout/domain/entities/trip_entities.dart';

class TripsModel extends TripEntities{
  TripsModel({required super.name, required super.price, required super.time, required super.date, required super.avgTime, required super.fromCity, required super.image, required super.isVip, required super.toCity, required super.tripID, required super.categoryID, required super.categoryName, required super.state});

  factory TripsModel.fromJson(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String ,dynamic>;
    return TripsModel(
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

}