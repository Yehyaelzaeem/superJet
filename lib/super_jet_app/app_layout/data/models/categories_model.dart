import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/categories_entities.dart';

class CategoriesModel extends CategoriesEntities{
  CategoriesModel({required super.categoryID,
    required super.image, required super.name, required super.masterCity, required super.city,
    required super.categoryName, required super.categorySecondName, required super.numberOfTrips});
  factory CategoriesModel.fromJson(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return CategoriesModel(
        categoryID: data['categoryID'],
        image:data['image'],
        name: data['name'],
        categoryName: data['categoryName'],
        categorySecondName: data['categorySecondName'],
        numberOfTrips: data['numberOfTrips'],
        masterCity: data['masterCity'],
        city: data['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "categoryID": categoryID,
      "image":  image,
      "name":  name,
      "categoryName": categoryName,
      "categorySecondName":  categorySecondName,
      "numberOfTrips":  numberOfTrips,
      "masterCity": masterCity,
      "city":  city,
    };
  }
}
class CityModel{
  final String fromCity;
  final String toCity;

  CityModel({
    required this.fromCity,required this.toCity
});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      fromCity: json["fromCity"],
      toCity: json["toCity"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fromCity": fromCity,
      "toCity": toCity,
    };
  }

//
}



