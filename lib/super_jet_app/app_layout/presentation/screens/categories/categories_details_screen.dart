import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/categories_model.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/trips_bloc.dart';
import '../../widgets/widgets.dart';

class CategoriesDetailsScreen extends StatelessWidget {
  final CategoriesModel categoriesModel;
  const CategoriesDetailsScreen({super.key, required this.categoriesModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
    body: SafeArea(
      child:
           BlocBuilder<TripsBloc,TripsState>(
            builder: (context,state){
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 30,),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        height: MediaQuery.of(context).size.height*0.08,
                        decoration: BoxDecoration(
                            color: Theme.of(context).unselectedWidgetColor,
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: Colors.white,width: 1),
                            boxShadow:  [BoxShadow(color: Theme.of(context).shadowColor,blurRadius: 7)]
                        ),
                        child:
                        Center(child:
                        Text('${categoriesModel.masterCity} to ${categoriesModel.city}',
                          style:   Theme.of(context).textTheme.titleMedium
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
                            color: Theme.of(context).unselectedWidgetColor,
                            borderRadius: const BorderRadius.all(Radius.circular(18)),
                            border: Border.all(color: Colors.white,width: 1),
                            boxShadow: const [BoxShadow(color: Colors.black38,blurRadius: 7)]
                        ),
                        child:
                        Center(child:
                        Text('${categoriesModel.city} to ${categoriesModel.masterCity}',
                          style:  Theme.of(context).textTheme.titleMedium
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
              );

            },
          ),
     ),
    );
  }
}
