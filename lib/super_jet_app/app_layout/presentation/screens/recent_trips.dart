import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/trips_bloc.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/enums.dart';
import '../../../auth/domain/entities/user_entities.dart';
import '../widgets/current_trips.dart';

class RecentTrips extends StatelessWidget {
 final List<TripID> tripIdLis;
  const RecentTrips({super.key,required this.tripIdLis});

  @override
  Widget build(BuildContext context) {
    return
        BlocProvider(create: (context)=> TripsBloc(sl())..add(GetProfileEvent(context))
          ..add(GetCurrentTripsEvent(tripIdLis, context)), child:
            BlocConsumer<TripsBloc, TripsState>(
            builder: (context, state) {
              if (state.currentTripsModelList.isNotEmpty)
              {
                switch (state.currentTripsState) {
                  case RequestState.loading:
                    return const Center(child: CircularProgressIndicator(),);
                  case RequestState.loaded:
                    if(tripIdLis.length==state.currentTripsModelList.length){
                      return
                        customPageViewCurrentTrips(state);
                    }
                    else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  case RequestState.error:
                    return const SizedBox(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ));
                }
              } else {
                return Container(
                    color: Colors.white,
                    child: const Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 15,),
                        Text('Loading...',
                        style: TextStyle(
                          color: Colors.blue
                        ),
                        )
                      ],
                    ),));
              }
            },
            listener: (context,state){},

          ),
        );

  }
}
