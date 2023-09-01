import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/trips_bloc.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/enums.dart';
import '../widgets/current_trips.dart';

class CurrentTrips extends StatelessWidget {
  const CurrentTrips({super.key});

  @override
  Widget build(BuildContext context) {
    var newState =context.read<TripsBloc>().state;
    context.read<TripsBloc>().add(GetProfileEvent(context));
    context.read<TripsBloc>().add(GetCurrentTripsEvent(newState.userModel!.tripIdList!, context));
    return
        BlocProvider(create: (context)=> TripsBloc(sl())
          ..add(GetProfileEvent(context))
          ..add(GetCurrentTripsEvent(newState.userModel!.tripIdList!, context)), child:
            BlocConsumer<TripsBloc, TripsState>(
            builder: (context, state) {
              if (state.currentTripsModelList.isNotEmpty) {
                switch (state.currentTripsState) {
                  case RequestState.loading:
                    return const Center(child: CircularProgressIndicator(),);
                  case RequestState.loaded:
                    if(state.userModel!.tripIdList!.length==state.currentTripsModelList.length){
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
                return const Center(child: CircularProgressIndicator(),);
              }
            },
            listener: (context,state){},

          ),
        );

  }
}
