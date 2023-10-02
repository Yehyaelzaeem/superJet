import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/state.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/enums.dart';
import '../../../auth/presentation/widgets/login_widget.dart';
import '../bloc/trips_bloc.dart';
import '../widgets/home_widgets.dart';
import '../widgets/widgets.dart';
class Home extends StatelessWidget {
  const Home({super.key, required this.city,});
  final String city;
  @override
  Widget build(BuildContext context) {
    var cubit =SuperCubit.get(context);
    cubit.getType();
    return
      Scaffold(
            backgroundColor: Colors.white,
            body:
        BlocProvider(create: (context) => TripsBloc(sl())..add(GetCategoriesTripsEvent())..add(GetTripsEvent(city, context)),
        child: BlocBuilder<TripsBloc, TripsState>(
            builder: (context, state) {
              return
              ConditionalBuilder(
                          condition: cubit.type.isNotEmpty,
                          builder: (context){
                            return
                            BlocConsumer<SuperCubit,AppSuperStates>(builder: (context,state){
                              return  SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    carouselSlider(context),
                                    const SizedBox(height: 8,),
                                    cubit.type !='branch'? listOfCityWidget():const SizedBox(),
                                    cubit.type !='branch'? rowTitleHome('Categories'):const SizedBox(),
                                    cubit.type !='branch'?  categoriesWidget(context):const SizedBox(),
                                    rowTitleHome('Trips'),
                                    SizedBox(height: cubit.type !='branch'? 0:15,),
                                    customLinearProgressIndicatorHome(),
                                    const SizedBox(height: 8,),
                                    gridViewTrips(context,false,false),
                                  ],
                                ),
                              );
                            }, listener: (context,state){});
                          },
                          fallback: (context)=>const Center(child: CircularProgressIndicator(),));
            },
           ),
          ),
        );
  }
}
