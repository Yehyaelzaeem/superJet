import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/domain/entities/user_entities.dart';
import '../bloc/trips_bloc.dart';

Widget customPageViewCurrentTrips(TripsState state){
  return   PageView.builder(
      itemCount: state.userModel[0].tripIdList!.length,
      itemBuilder: (context,index){
        var x =state.currentTripsModelList[index];
        List<TripID> listTripID =state.userModel[0].tripIdList!;
        listTripID=listTripID.reversed.toList();
        return Scaffold(
          body:
          Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    currentImageTrips(state.currentTripsModelList[index].image, state.userModel[0].profileImage,context,state,false),

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
                    customRowDataCurrentTrips("Chair Number : ",listTripID[index].chairID.toString(),12,12),
                    const SizedBox(height: 5,),
                    customRowDataCurrentTrips("State : ",x.state,12,12),
                    const SizedBox(height: 5,),
                    customRowDataCurrentTrips("Ticket Id : ","${x.tripID}${listTripID[index].chairID}",12,12),
                    const SizedBox(height: 40,),
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
                          context.read<TripsBloc>().add(GetCurrentTripsEvent(state.userModel[0].tripIdList!, context));

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
          ),
        );
      });
}


Widget currentImageTrips(String? coverImage,String? profileImage,context,TripsState tripsState,bool isCart){
  var state =tripsState.userModel[0];
  return
    SizedBox(
      width: double.infinity,
      height: 300,
      child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: Container(
                width: double.infinity,
                height: 300,
                decoration:  BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
                  image: DecorationImage(
                    image: NetworkImage(coverImage!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Container(
                      height: 200,
                      width: 170,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [BoxShadow(color: Colors.black87,blurRadius: 3)]
                      ),
                      child:
                      Padding(
                        padding:  const EdgeInsets.only(left: 8.0,right: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Passenger ID :',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                ),
                                Expanded(
                                  child: Text(state.uId,
                                    style: const TextStyle(
                                      fontSize: 6,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],),
                            const SizedBox(height: 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Passenger name :',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                ),
                                Expanded(
                                  child: Text(state.name,
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],),
                            const SizedBox(height: 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Email :',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                ),
                                Expanded(
                                  child: Text(state.email,
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],),
                            const SizedBox(height: 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Phone :',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                ),
                                Expanded(
                                  child: Text(state.phone,
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],),
                            const SizedBox(height: 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('your City :',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                ),
                                Expanded(
                                  child: Text(state.city,
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],),
                            const SizedBox(height: 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Total Trips :',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                ),
                                Expanded(
                                  child: Text(state.tripIdList!.length.toString(),
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],),
                            const SizedBox(height: 5,),
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Current Trips :',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                ),
                                Expanded(
                                  child: Text('1',
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],),
                            const SizedBox(height: 5,),
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Wallet :',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                ),
                                Expanded(
                                  child: Text('850 EG',
                                    style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],),
                            const SizedBox(height: 5,),


                          ],
                        ),
                      ),
                    ),

                  ),
                  Positioned(
                    left: 34,
                    top: 12,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius:45,
                        backgroundImage:
                       isCart==false? NetworkImage(profileImage!): NetworkImage(state.profileImage!),

                      ),),
                  ),
                ],
              ),
            ),
          ]
      ),
    );
}



Widget customRowDataCurrentTrips(String baseText,String data ,double baseSize,double size)=>
    Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child:
      Row(
        children: [
           Text(baseText,
            style:  TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: baseSize
            ),
          ),
          Text(data,
            style:  TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: size
            ),
          ),
        ],
      ),
    );