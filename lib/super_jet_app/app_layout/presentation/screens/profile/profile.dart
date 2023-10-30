import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/core/utils/enums.dart';
import '../../../../../core/services/services_locator.dart';
import '../../bloc/cubit.dart';
import '../../bloc/trips_bloc.dart';
import '../../widgets/profile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    SuperCubit.get(context).removeNotificationListOfChats();
    return SafeArea(
      child: Scaffold(
          body:
          BlocProvider(
            create: (context)=>TripsBloc(sl())..add(GetProfileEvent(context)),
            child:  BlocConsumer<TripsBloc,TripsState>(
                builder: (context,state){
                  return ConditionalBuilder(
                      condition: state.userModel.isNotEmpty,
                      builder: (context){
                        return customProfileDesign(state,context);
                      },
                      fallback: (context)=>const Center(child: CircularProgressIndicator(),));
                },
                listener: (context ,state){}),

          )
      ),
    );
  }
}
