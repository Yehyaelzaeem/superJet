import 'package:flutter/material.dart';
import '../../data/models/trip_model.dart';

Widget bookedDateScreen(TripsModel tripsModel ,context){
  return Container(
    height: MediaQuery.of(context).size.height * 0.1,
    decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30))),
    child:
    Row(
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
  );

}