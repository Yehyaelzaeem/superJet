import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:superjet/core/global/localization/appLocale.dart';
import 'package:superjet/core/utils/enums.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import '../../../../core/services/routeing_page/routing.dart';
import '../../../auth/domain/entities/user_entities.dart';
import '../bloc/trips_bloc.dart';
import '../screens/profile/profile.dart';

Widget customPageViewCurrentTrips(TripsState state){
  return   PageView.builder(
      itemCount: state.userModel[0].tripIdList!.length,
      itemBuilder: (context,index){
        var x =state.currentTripsModelList[index];
        List<TripID> listTripID =state.userModel[0].tripIdList!;
        listTripID=listTripID.reversed.toList();
        final today = DateTime.now();
        DateTime dt = DateTime.parse("${x.date} ${x.time}");
        final res = dt.subtract(Duration(days: today.day,hours: today.hour,minutes: today.minute));

        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  currentImageTrips(state.currentTripsModelList[index].image, state.userModel[0].profileImage,context,state,false),

                 Padding(
                   padding: const EdgeInsets.only(right: 18.0,left: 18.0),
                   child: Column(
                     children: [
                       const SizedBox(height: 20,),

                       Center(child: Text("${x.fromCity} To ${x.toCity}",
                         style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                       )),
                       Center(child: Text("${getLang(context, 'deletingPart1')} ${res.day} ${getLang(context, 'deletingPart2')} ${res.hour} ${getLang(context, 'deletingPart3')}",
                         style: const TextStyle(
                             color: Colors.grey,
                             fontWeight: FontWeight.normal, fontSize: 10),
                         textAlign: TextAlign.center,
                       )),

                       const SizedBox(height: 20,),
                       customRowDataCurrentTrips(context,"${getLang(context, 'fromCity')} : ",x.fromCity,12,12),
                       const SizedBox(height: 5,),
                       customRowDataCurrentTrips(context,"${getLang(context, 'toCity')}  : ",x.toCity,12,12),
                       const SizedBox(height: 5,),
                       customRowDataCurrentTrips(context,"${getLang(context, 'price')}  : ",x.price,12,12),
                       const SizedBox(height: 5,),
                       customRowDataCurrentTrips(context,"${getLang(context, 'type')}  : ",x.isVip=='true'?"VIP":'Normal',12,12),
                       const SizedBox(height: 5,),
                       customRowDataCurrentTrips(context,"${getLang(context, 'date')}  : ",x.date,12,12),
                       const SizedBox(height: 5,),
                       customRowDataCurrentTrips(context,"${getLang(context, 'time')}  : ",x.time,12,12),
                       const SizedBox(height: 5,),
                       customRowDataCurrentTrips(context,"${getLang(context, 'arrivalTime')}  : ",x.avgTime,12,12),
                       const SizedBox(height: 5,),
                       customRowDataCurrentTrips(context,"${getLang(context, 'chairNumber')}  : ",listTripID[index].chairID.toString(),12,12),
                       const SizedBox(height: 5,),
                       customRowDataCurrentTrips(context,"${getLang(context, 'state')}  : ",x.state,12,12),
                       const SizedBox(height: 5,),
                       customRowDataCurrentTrips(context,"${getLang(context, 'ticketId')}  : ","${x.tripID}${listTripID[index].chairID}",12,12),
                       const SizedBox(height: 40,),
                       Padding(
                         padding: const EdgeInsets.only(left: 20.0, right: 20),
                         child: Container(
                           width: MediaQuery.of(context).size.width * 0.9,
                           decoration: BoxDecoration(
                               borderRadius: const BorderRadius.all(Radius
                                   .circular(10)),
                               border: Border.all(color: Colors.grey.shade400,
                                   width: 1)
                           ),
                           child:
                           TextButton(
                             onPressed: () {
                               if( res.day >= 6 ){
                                 SuperCubit.get(context).cancelBookedTrips(x, state.userModel[0],listTripID[index].chairID.toString()).then((value) {
                                   context.read<TripsBloc>().add(GetProfileEvent(context));
                                   NavigatePages.pushReplacePage(const Profile(), context);
                                 });
                                 showToast('${getLang(context, 'deleting')}', ToastStates.success, context);
                               }else{
                                 showToast("${getLang(context, 'deletingShowMessage')}", ToastStates.error, context);
                               }

                             }, child:  Text('${getLang(context, 'deleteTrip')}',
                             style: Theme.of(context).textTheme.labelLarge,
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
                             NavigatePages.pushReplacePage(const Profile(), context);
                           }, child:  Text('${getLang(context, 'cancel')}',
                             style: Theme.of(context).textTheme.labelLarge,
                           ),)
                           ,),
                       ),
                       const SizedBox(height: 15,),
                     ],
                   ),
                 )
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
                  child:  Center(
                    child: Text('${getLang(context, 'tripFinished')}',
                      style: const TextStyle(
                        color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17
                      ),

                    ),
                  ),
                ),
              ),
            ):const SizedBox()

          ],
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
                                 Text('${getLang(context, 'passengerId')}',
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
                                 Text('${getLang(context, 'passengerName')} :',
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
                                 Text('${getLang(context, 'email')} :',
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
                                 Text('${getLang(context, 'phone')} :',
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
                                 Text('${getLang(context, 'city')} :',
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
                                 Text('${getLang(context, 'totalTrips')} :',
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
                             Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${getLang(context, 'currentTrips')} :',
                                  style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                ),
                                const Expanded(
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
                             Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text('${getLang(context, 'wallet2')} :',
                                  style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                ),
                                Expanded(
                                  child: Text('${state.wallet}  ${getLang(context, 'EGP')}',
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



Widget customRowDataCurrentTrips(context,String baseText,String data ,double baseSize,double size)=>
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
            style:  Theme.of(context).textTheme.displaySmall
          ),
        ],
      ),
    );