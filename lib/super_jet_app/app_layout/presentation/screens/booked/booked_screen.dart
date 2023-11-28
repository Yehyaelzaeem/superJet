import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:superjet/core/global/localization/appLocale.dart';
import 'package:superjet/core/widgets/widgets.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/widgets/booked_widgets.dart';
import '../../../../../core/utils/constants.dart';
import '../../../data/models/trip_model.dart';

class BookedScreen extends StatelessWidget {
  final TripsModel tripsModel;
  final String userID;

  const BookedScreen({super.key, required this.tripsModel, required this.userID});

  @override
  Widget build(BuildContext context) {
    var collectionReference = FirebaseFirestore.instance
        .collection('Trips')
        .doc(tripsModel.categoryID.trim())
        .collection(tripsModel.categoryName.trim())
        .doc(tripsModel.tripID.trim())
        .collection('Chairs');
        var cubit = SuperCubit.get(context);
    return Scaffold(
        body: SafeArea(
            child:
            StreamBuilder(
                stream: collectionReference.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          bookedDateScreen(tripsModel, context),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 5),
                            child: GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 4,
                              crossAxisSpacing: 0.5,
                              mainAxisSpacing: 10,
                              childAspectRatio: 5 / 3,
                              children: List.generate(52, (index) {
                                return InkWell(
                                  onTap: () {
                                    final isDarkMode = Theme.of(context).brightness;

                                    if (snapshot.data!.docs[index]['isAvailable'] == 'true') {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title:  Text('${getLang(context, 'bookedChair')} :  ${snapshot.data!.docs[index]['chairID'].toString()}',
                                            style: const TextStyle(
                                              fontSize: 25
                                            ),
                                            ),
                                            content:  Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                 Text('${getLang(context, 'bookedPart1')} ',style: Theme.of(context).textTheme.titleLarge,),
                                                const SizedBox(height: 2,),
                                                Text('${getLang(context, 'tripName')} : ${tripsModel.name}',
                                                style: Theme.of(context).textTheme.titleLarge,
                                                ),
                                                const SizedBox(height: 2,),
                                                Text('${getLang(context, 'fromCity')} : ${tripsModel.fromCity}' , style: Theme.of(context).textTheme.titleLarge,),
                                                const SizedBox(height: 2,),
                                                Text('${getLang(context, 'toCity')}  : ${tripsModel.toCity}',  style: Theme.of(context).textTheme.titleLarge,),
                                                const SizedBox(height: 2,),
                                                Text('${getLang(context, 'price')}  : ${tripsModel.price}',  style: Theme.of(context).textTheme.titleLarge,),
                                                const SizedBox(height: 2,),
                                                Text('${getLang(context, 'date')}   : ${tripsModel.date}',  style: Theme.of(context).textTheme.titleLarge,),
                                                const SizedBox(height: 2,),
                                                Text('${getLang(context, 'time')}  : ${tripsModel.time}',  style: Theme.of(context).textTheme.titleLarge,),
                                              ],
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child:  Text('${getLang(context, 'cancel')}',
                                                  style:const TextStyle(
                                                      color:  Colors.black
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child:   Text('${getLang(context, 'ok')}',
                                                style:const TextStyle(
                                                  color:  Colors.black
                                                ),
                                                ),
                                                onPressed: () {
                                                  var x =snapshot.data!.docs[index]['isPaid'];
                                                  collectionReference.doc(snapshot.data!.docs[index].id).update({'isAvailable': 'false','passengerID':userID});
                                                  cubit.addCartTrips(tripsModel,  snapshot.data!.docs[index]['chairID'].toString(),snapshot.data!.docs[index].id);
                                                  showToast('${getLang(context, 'messageBooked')}', ToastStates.warning, context);
                                                  Navigator.of(context).pop();
                                                  Future.delayed(const Duration(minutes: 2)).then((value) async{
                                                    var res =await collectionReference.doc(snapshot.data!.docs[index].id).get();
                                                    if(res.data()!['isPaid']=='false'){
                                                      collectionReference.doc(snapshot.data!.docs[index].id).update({'isAvailable': 'true','passengerID': 'null'});
                                                      cubit.removeCart();
                                                    }else{
                                                      cubit.removeCart();
                                                    }
                                                  });
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );

                                    }
                                    else if(snapshot.data!.docs[index]['isPaid'] == 'false') {
                                      showToast(
                                          'This chair is now reserved',
                                          ToastStates.warning,
                                          context);
                                    }
                                    else{
                                      showToast(
                                          'This chair has already been reserved',
                                          ToastStates.error,
                                          context);
                                    }
                                  },
                                  child: Stack(
                                    children: [
                                      Center(
                                          child: Icon(
                                        Icons.chair_rounded,
                                        color:    snapshot.data!.docs[index]['isPaid'] == 'false' ?
                                        (snapshot.data!.docs[index]['isAvailable'] == 'true' ?
                                       Theme.of(context).hoverColor:Theme.of(context).focusColor
                                        ) : Theme.of(context).disabledColor,
                                        size: 59,
                                      )),
                                      Positioned(
                                        left: 20,
                                        right: 20,
                                        bottom: 28,
                                        top: 10,
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.white,
                                          // Theme.of(context).primaryColor,
                                          child: Text(
                                            "${snapshot.data!.docs[index]['chairID']}",
                                            style: TextStyle(
                                                color: Theme.of(context).primaryColorDark,
                                                // Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 20, bottom: 20, top: 10,right: 20),
                            height: 80,
                            child: Center(
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 6,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        if (snapshot.data!.docs[index + 52]['isAvailable'] == 'true') {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: Colors.white,
                                                title:  Text('Booked Chair :  ${snapshot.data!.docs[index+52]['chairID'].toString()}',style: Theme.of(context).textTheme.titleLarge,),
                                                content:  Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                     Text('Are You sure ? \nYou want to Book this chair ',style: Theme.of(context).textTheme.titleLarge,),
                                                    const SizedBox(height: 2,),
                                                    Text('Trip name : ${tripsModel.name}',style: Theme.of(context).textTheme.titleLarge,),
                                                    const SizedBox(height: 2,),
                                                    Text('From City : ${tripsModel.fromCity}',style: Theme.of(context).textTheme.titleLarge,),
                                                    const SizedBox(height: 2,),
                                                    Text('To City      : ${tripsModel.toCity}',style: Theme.of(context).textTheme.titleLarge,),
                                                    const SizedBox(height: 2,),
                                                    Text('Price         : ${tripsModel.price}',style: Theme.of(context).textTheme.titleLarge,),
                                                    const SizedBox(height: 2,),
                                                    Text('Date          : ${tripsModel.date}',style: Theme.of(context).textTheme.titleLarge,),
                                                    const SizedBox(height: 2,),
                                                    Text('Time         : ${tripsModel.time}',style: Theme.of(context).textTheme.titleLarge,),
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      textStyle: Theme.of(context).textTheme.labelLarge,
                                                    ),
                                                    child: const Text('Cancel',
                                                      style:TextStyle(
                                                          color:  Colors.black
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      textStyle: Theme.of(context).textTheme.labelLarge,
                                                    ),
                                                    child: const Text('OK',
                                                      style:TextStyle(
                                                          color:  Colors.black
                                                          ),),
                                                    onPressed: () {
                                                      collectionReference.doc(snapshot.data!.docs[index + 52].id).update({'isAvailable': 'false','passengerID':userID});
                                                      SuperCubit.get(context).addCartTrips(tripsModel,  snapshot.data!.docs[index+52]['chairID'].toString(),snapshot.data!.docs[index+52].id);
                                                      showToast('To Complete Booking Trip Go To Payment Page To Pay Total', ToastStates.success, context);
                                                      Navigator.of(context).pop();
                                                      Future.delayed(const Duration(minutes: 2)).then((value) {
                                                        if(snapshot.data!.docs[index + 52]['isPaid'] =='false'){
                                                          collectionReference.doc(snapshot.data!.docs[index + 52].id).update({'isAvailable': 'true','passengerID':'null'});
                                                          cubit.removeCart();
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else if(snapshot.data!.docs[index+52]['isPaid'] == 'false') {
                                          showToast(
                                              'This chair is now reserved',
                                              ToastStates.warning,
                                              context);
                                        }
                                        else{
                                          showToast(
                                              'This chair has already been reserved',
                                              ToastStates.error,
                                              context);
                                        }
                                      },
                                      child: Stack(
                                        children: [
                                          Center(
                                              child: Icon(
                                            Icons.chair_rounded,
                                            color:
                                            snapshot.data!.docs[index+52]['isPaid'] == 'false' ?
                                            (snapshot.data!.docs[index+52]['isAvailable'] == 'true' ?
                                            Theme.of(context).hoverColor:Theme.of(context).focusColor
                                            ) : Theme.of(context).disabledColor,
                                            size: 59,
                                          )),
                                          Positioned(
                                            left: 20,
                                            right: 20,
                                            bottom: 17,
                                            top: 5,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              // Theme.of(context).primaryColor,
                                              maxRadius: 10,
                                              child: Text(
                                                "${snapshot.data!.docs[index + 52]['chairID']}",
                                                style: TextStyle(
                                                    color: Theme.of(context).primaryColorDark,
                                                    // Colors.white,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    showToast('Waiting', ToastStates.warning, context);
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    showToast('Error', ToastStates.error, context);
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })));
  }
}
