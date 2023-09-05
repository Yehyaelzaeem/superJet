import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:superjet/core/widgets/widgets.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/constants.dart';
import '../../data/models/trip_model.dart';

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
                          Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 15,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'From city : ',
                                            style: TextStyle(
                                                color: Colors.grey.shade600),
                                          ),
                                          Text(
                                            tripsModel.fromCity,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                shadows: [
                                                  BoxShadow(
                                                      color: Colors.white54,
                                                      blurRadius: 1)
                                                ]),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'To city      : ',
                                            style: TextStyle(
                                                color: Colors.grey.shade600),
                                          ),
                                          Text(
                                            tripsModel.toCity,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                shadows: [
                                                  BoxShadow(
                                                      color: Colors.white54,
                                                      blurRadius: 1)
                                                ]),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Type         : ',
                                            style: TextStyle(
                                                color: Colors.grey.shade600),
                                          ),
                                          Text(
                                            tripsModel.isVip == "true"
                                                ? 'VIP'
                                                : "Normal",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                shadows: [
                                                  BoxShadow(
                                                      color: Colors.white54,
                                                      blurRadius: 1)
                                                ]),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Price        : ',
                                            style: TextStyle(
                                                color: Colors.grey.shade600),
                                          ),
                                          Text(
                                            tripsModel.price,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                shadows: [
                                                  BoxShadow(
                                                      color: Colors.white54,
                                                      blurRadius: 1)
                                                ]),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 8,),
                                    const Row(
                                      children: [
                                        Text('Available chair',
                                        style: TextStyle(
                                          fontSize: 10
                                        ),
                                        ),
                                      SizedBox(width: 5,),
                                      SizedBox(
                                        width: 8,
                                        height: 8,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.blue,
                                          radius: 50,
                                        ),
                                      )
                                      ],
                                    ),
                                    const Row(
                                      children: [
                                        Text('Unavailable chair',
                                        style: TextStyle(
                                          fontSize: 10
                                        ),
                                        ),
                                      SizedBox(width: 5,),
                                      SizedBox(
                                        width: 8,
                                        height: 8,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          radius: 50,
                                        ),
                                      )
                                      ],
                                    ),
                                    const SizedBox(height: 5,),

                                    Text(
                                      'Date of Trip ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade600),
                                    ),
                                    const SizedBox(height: 1,),
                                    Text(tripsModel.date,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              BoxShadow(
                                                  color: Colors.white54,
                                                  blurRadius: 1)
                                            ])),
                                    // BlocConsumer<SuperCubit,AppSuperStates>(
                                    //     builder: (context,state){
                                    //       var c = SuperCubit.get(context);
                                    //       return    DropdownButton(
                                    //         dropdownColor: Theme.of(context).primaryColor,
                                    //         value: c.selectedValue,
                                    //         items: c.dropdownItems,
                                    //         onChanged: (String? value) {
                                    //           c.changeDropdownValue(value!);
                                    //         },
                                    //       );
                                    //     },
                                    //     listener: (context,state){})
                                  ],
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 8,),
                                    const Row(
                                      children: [
                                        Text('Waiting in Cart',
                                          style: TextStyle(
                                              fontSize: 10
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                        SizedBox(
                                          width: 8,
                                          height: 8,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.red,
                                            radius: 50,
                                          ),
                                        )
                                      ],
                                    ),
                                    const Row(
                                      children: [
                                        Text('Damaged chair',
                                          style: TextStyle(
                                              fontSize: 10
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                        SizedBox(
                                          width: 8,
                                          height: 8,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.black54,
                                            radius: 50,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 5,),
                                    Text(
                                      'Time of Trip',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade600),
                                    ),
                                    const SizedBox(height: 1,),

                                    Text(
                                      tripsModel.time,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            BoxShadow(
                                                color: Colors.white54,
                                                blurRadius: 1)
                                          ]),
                                    ),

                                    // BlocConsumer<SuperCubit,AppSuperStates>(
                                    //     builder: (context,state){
                                    //       var c = SuperCubit.get(context);
                                    //       return    DropdownButton(
                                    //         dropdownColor: Theme.of(context).primaryColor,
                                    //         value: c.selectedValueTime,
                                    //         items: c.dropdownItemsTime,
                                    //         onChanged: (String? value) {
                                    //           c.changeDropdownValueTime(value!);
                                    //         },);
                                    //
                                    //     },
                                    //     listener: (context,state){}),
                                  ],
                                ),
                              ],
                            ),
                          ),
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

                                    if (snapshot.data!.docs[index]['isAvailable'] == 'true') {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:  Text('Booked Chair :  ${snapshot.data!.docs[index]['chairID'].toString()}'),
                                            content:  Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('Are You sure ? \nYou want to Book this chair ',),
                                                const SizedBox(height: 2,),
                                                Text('Trip name : ${tripsModel.name}',),
                                                const SizedBox(height: 2,),
                                                Text('From City : ${tripsModel.fromCity}',),
                                                const SizedBox(height: 2,),
                                                Text('To City      : ${tripsModel.toCity}',),
                                                const SizedBox(height: 2,),
                                                Text('Price         : ${tripsModel.price}',),
                                                const SizedBox(height: 2,),
                                                Text('Date          : ${tripsModel.date}',),
                                                const SizedBox(height: 2,),
                                                Text('Time         : ${tripsModel.time}',),
                                              ],
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  textStyle: Theme.of(context).textTheme.labelLarge,
                                                ),
                                                child: const Text('Cancel'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  textStyle: Theme.of(context).textTheme.labelLarge,
                                                ),
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  collectionReference.doc(snapshot.data!.docs[index].id).update({'isAvailable': 'false','passengerID':userID});
                                                  cubit.addCartTrips(tripsModel,  snapshot.data!.docs[index]['chairID'].toString(),snapshot.data!.docs[index].id);
                                                  showToast('To Complete Booking Trip Go To Payment Page for 2 minutes', ToastStates.warning, context);
                                                  Navigator.of(context).pop();
                                                  Future.delayed(const Duration(minutes: 2)).then((value) {
                                                    if(snapshot.data!.docs[index]['isPaid'] =='false'){
                                                      collectionReference.doc(snapshot.data!.docs[index ].id).update({'isAvailable': 'true','passengerID':'null'});
                                                      cubit.removeCart();
                                                    }

                                                  });
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );

                                    } else if(snapshot.data!.docs[index]['isPaid'] == 'false') {
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
                                        App.availableChair:App.waitingCart
                                        ) : App.unAvailableChair,
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
                                                color: Theme.of(context)
                                                    .primaryColor,
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
                                left: 20, bottom: 20, top: 10),
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
                                                title:  Text('Booked Chair :  ${snapshot.data!.docs[index+52]['chairID'].toString()}'),
                                                content:  Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text('Are You sure ? \nYou want to Book this chair ',),
                                                    const SizedBox(height: 2,),
                                                    Text('Trip name : ${tripsModel.name}',),
                                                    const SizedBox(height: 2,),
                                                    Text('From City : ${tripsModel.fromCity}',),
                                                    const SizedBox(height: 2,),
                                                    Text('To City      : ${tripsModel.toCity}',),
                                                    const SizedBox(height: 2,),
                                                    Text('Price         : ${tripsModel.price}',),
                                                    const SizedBox(height: 2,),
                                                    Text('Date          : ${tripsModel.date}',),
                                                    const SizedBox(height: 2,),
                                                    Text('Time         : ${tripsModel.time}',),
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      textStyle: Theme.of(context).textTheme.labelLarge,
                                                    ),
                                                    child: const Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      textStyle: Theme.of(context).textTheme.labelLarge,
                                                    ),
                                                    child: const Text('OK'),
                                                    onPressed: () {
                                                      collectionReference.doc(snapshot.data!.docs[index + 52].id).update({'isAvailable': 'false','passengerID':userID});
                                                      SuperCubit.get(context).addCartTrips(tripsModel,  snapshot.data!.docs[index+52]['chairID'].toString(),snapshot.data!.docs[index+52].id);
                                                      showToast('To Complete Booking Trip Go To Payment Page To Pay Total', ToastStates.success, context);
                                                      Navigator.of(context).pop();
                                                      Future.delayed(const Duration(minutes: 2)).then((value) {
                                                        if(snapshot.data!.docs[index + 52]['isPaid'] =='false'){
                                                          collectionReference.doc(snapshot.data!.docs[index + 52].id).update({'isAvailable': 'true','passengerID':'null'});
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
                                            App.availableChair:App.waitingCart
                                            ) : App.unAvailableChair,
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
                                                    color: Theme.of(context)
                                                        .primaryColor,
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
                  } else if (snapshot.connectionState ==
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
