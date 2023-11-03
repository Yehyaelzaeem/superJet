import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/trips_bloc.dart';
import '../../widgets/home_widgets.dart';
import '../../widgets/widgets.dart';
class Home extends StatelessWidget {
  const Home({super.key, required this.city,});
  final String city;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body:
            BlocConsumer<TripsBloc,TripsState>(
                builder: (context,state){
                  return ConditionalBuilder(
                        condition:state.categoriesModelList.isNotEmpty,
                        builder: (context){
                          return SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                carouselSlider(context),
                                const SizedBox(height: 8,),
                                listOfCityWidget(),
                                rowTitleHome('Categories',context),
                                categoriesWidget(context),
                                rowTitleHome('Trips',context),
                                customLinearProgressIndicatorHome(),
                                const SizedBox(height: 8,),
                                gridViewTrips(context,false,false),
                              ],
                            ),
                          );
                        },
                        fallback: (context)=>const Center(child: CircularProgressIndicator(),));
                }, listener: (context,state){})
        );
  }
}
