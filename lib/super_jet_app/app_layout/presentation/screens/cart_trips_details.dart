import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/services_locator.dart';
import '../../data/models/trip_model.dart';
import '../bloc/trips_bloc.dart';
import '../widgets/current_trips.dart';

class DisplayCartTripsDetails extends StatelessWidget {
  const DisplayCartTripsDetails({super.key, required this.tripsState, required this.tripsModel, required this.chairId});
  final TripsState tripsState ;
  final TripsModel tripsModel;
  final String chairId;
  @override
  Widget build(BuildContext context) {
    var x =tripsModel;
    return Scaffold(
        body: BlocProvider(
          create: (context)=>TripsBloc(sl())..add(GetProfileEvent(context)),
          child: BlocBuilder<TripsBloc,TripsState>(builder: (context,state){
            return  Center(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        currentImageTrips(tripsModel.image,tripsModel.image,context,tripsState,true),

                        const SizedBox(height: 20,),

                        Center(child: Text("${x.fromCity} To ${x.toCity}",
                          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                        )),

                        const SizedBox(height: 20,),
                        customRowDataCurrentTrips("From City : ",x.fromCity,12,12),
                        const SizedBox(height: 5,),
                        customRowDataCurrentTrips("To City : ",x.toCity,12,12),
                        const SizedBox(height: 5,),
                        customRowDataCurrentTrips("Price : ",x.price,12,12),
                        const SizedBox(height: 5,),
                        customRowDataCurrentTrips("Type : ",x.isVip=='true'?"VIP":'Normal',12,12),
                        const SizedBox(height: 5,),
                        customRowDataCurrentTrips("Date : ",x.date,12,12),
                        const SizedBox(height: 5,),
                        customRowDataCurrentTrips("Time : ",x.time,12,12),
                        const SizedBox(height: 5,),
                        customRowDataCurrentTrips("Arrival Time : ",x.avgTime,12,12),
                        const SizedBox(height: 5,),
                        customRowDataCurrentTrips("Chair Number : ",chairId.toString(),12,12),
                        const SizedBox(height: 5,),
                        customRowDataCurrentTrips("State : ",x.state,12,12),
                        const SizedBox(height: 5,),
                        customRowDataCurrentTrips("Ticket Id : ","${x.tripID}$chairId",12,12),
                        SizedBox(height: MediaQuery.of(context).size.height*0.17,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.9,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius
                                    .circular(10)),
                                border: Border.all(color: Colors.grey.shade400,
                                    width: 1)
                            ),
                            child:
                            TextButton(onPressed: () {}, child: const Text(
                              'Edite Trip',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),)
                            ,),
                        ),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.9,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius
                                    .circular(10)),
                                border: Border.all(color: Colors.grey.shade400,
                                    width: 1)
                            ),
                            child:
                            TextButton(onPressed: () {
                              // context.read<TripsBloc>().add(GetCurrentTripsEvent(state.userModel!.tripIdList!, context));

                            }, child: const Text('Cancel',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),)
                            ,),
                        ),
                        const SizedBox(height: 15,),
                      ],
                    ),
                  ),

                  x.state=='finished'? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey.withOpacity(0.7),
                  ):const SizedBox(),
                  x.state=='finished'?  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.6,
                        height: 60,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                        child: const Center(
                          child: Text('This Trip was Finished',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),

                          ),
                        ),
                      ),
                    ),
                  ):const SizedBox()

                ],
              ));
          },
          ),
        )

    );
  }
}
