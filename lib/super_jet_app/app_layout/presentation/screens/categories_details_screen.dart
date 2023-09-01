import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/categories_model.dart';

import '../widgets/home_widgets.dart';
import '../widgets/widgets.dart';

class CategoriesDetailsScreen extends StatelessWidget {
  final CategoriesModel categoriesModel;
  const CategoriesDetailsScreen({super.key, required this.categoriesModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
    body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30,),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width*0.9,
                height: MediaQuery.of(context).size.height*0.08,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.white,width: 1),
                  boxShadow: const [BoxShadow(color: Colors.black38,blurRadius: 7)]
                ),
                child:
                 Center(child:
                Text('${categoriesModel.masterCity} to ${categoriesModel.city}',
                style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Theme.of(context).primaryColor,

                ),
                ))
                ,),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 18.0,right: 18),
              child: gridViewTrips(context,true,true),
            ),
            const SizedBox(height: 30,),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width*0.9,
                height: MediaQuery.of(context).size.height*0.08,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(18)),
                    border: Border.all(color: Colors.white,width: 1),
                    boxShadow: const [BoxShadow(color: Colors.black38,blurRadius: 7)]
                ),
                child:
                Center(child:
                Text('${categoriesModel.city} to ${categoriesModel.masterCity}',
                  style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Theme.of(context).primaryColor,

                  ),
                ))
                ,),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 18.0,right: 18),
              child: gridViewTrips(context,true,false),
            ),
            const SizedBox(height: 30,),


          ],
        ),
      ),
    )
    );
  }
}
