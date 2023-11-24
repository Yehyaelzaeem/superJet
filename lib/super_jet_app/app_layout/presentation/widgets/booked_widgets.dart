import 'package:flutter/material.dart';
import '../../data/models/trip_model.dart';

Widget bookedDateScreen(TripsModel tripsModel ,context){
  return Container(
    height: MediaQuery.of(context).size.height * 0.11,
    decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
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
                    style:Theme.of(context).textTheme.titleSmall
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
                    style:Theme.of(context).textTheme.titleSmall
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
                    style: Theme.of(context).textTheme.titleSmall
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
                    style: Theme.of(context).textTheme.titleSmall
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
             Row(
              children: [
                const Text('Available chair',
                  style: TextStyle(
                      fontSize: 10
                  ),
                ),
                const SizedBox(width: 5,),
                SizedBox(
                  width: 8,
                  height: 8,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).hoverColor,
                    radius: 50,
                  ),
                )
              ],
            ),
             Row(
              children: [
                const Text('Unavailable chair',
                  style: TextStyle(
                      fontSize: 10
                  ),
                ),
                const SizedBox(width: 5,),
                SizedBox(
                  width: 8,
                  height: 8,
                  child: CircleAvatar(
                    backgroundColor:  Theme.of(context).disabledColor,
                    radius: 50,
                  ),
                )
              ],
            ),
            const SizedBox(height: 5,),

            Text(
              'Date of Trip ',
              style: Theme.of(context).textTheme.titleSmall
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
             Row(
              children: [
                const Text('Waiting in Cart',
                  style: TextStyle(
                      fontSize: 10
                  ),
                ),
                const SizedBox(width: 5,),
                SizedBox(
                  width: 8,
                  height: 8,
                  child: CircleAvatar(
                    backgroundColor:Theme.of(context).focusColor,
                    radius: 50,
                  ),
                )
              ],
            ),
             Row(
              children: [
                const Text('Damaged chair',
                  style: TextStyle(
                      fontSize: 10
                  ),
                ),
                const SizedBox(width: 5,),
                SizedBox(
                  width: 8,
                  height: 8,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).splashColor,
                    radius: 50,
                  ),
                )
              ],
            ),
            const SizedBox(height: 5,),
            Text(
              'Time of Trip',
              style: Theme.of(context).textTheme.titleSmall,),
            const SizedBox(height: 1,),
            Text(
              '     ${tripsModel.time.substring(0,5)}',
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
          ],
        ),
      ],
    ),
  );

}