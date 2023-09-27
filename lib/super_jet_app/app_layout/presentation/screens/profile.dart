import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/core/utils/enums.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/trips_bloc.dart';
import '../../../../core/services/services_locator.dart';
import '../widgets/profile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    SuperCubit.get(context).getType();
    return Scaffold(body:
    SafeArea(child:
      BlocProvider(create: (context) => TripsBloc(sl())..add(GetProfileEvent(context)), child:
        BlocBuilder<TripsBloc, TripsState>(
          builder: (context, state) {
            if (state.userModel != null) {
              switch (state.userModelState) {
                case RequestState.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case RequestState.loaded:
                 return customProfileDesign(state,context);
                case RequestState.error:
                  return const SizedBox(
                      child: Center(
                    child: CircularProgressIndicator(),
                  ));
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    ));
  }
}
