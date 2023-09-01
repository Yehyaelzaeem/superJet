import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/trip_model.dart';

class  PaymentScreen extends StatelessWidget {
  final TripsModel tripsModel;
  final String chairID;
  final int chairNumber;
  const  PaymentScreen({super.key, required this.tripsModel, required this.chairID, required this.chairNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          const SizedBox(height: 100,),
          Center(child: Text(tripsModel.categoryID),),
          Center(child: Text(tripsModel.tripID),),
          Center(child: Text(tripsModel.name),),
          Center(child: Text(tripsModel.fromCity),),
          Center(child: Text(tripsModel.toCity),),
          Center(child: Text(tripsModel.price),),
          Center(child: Text(tripsModel.date),),
          Center(child: Text(tripsModel.time),),
          Center(child: Text(chairID),),
          Center(child: Text(chairNumber.toString()),),
        ],
      )
    );
  }
}
