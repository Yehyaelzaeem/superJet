import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/core/global/localization/appLocale.dart';
import '../../data/models/trip_model.dart';
import '../bloc/cubit.dart';
import '../bloc/state.dart';

Widget bookedDateScreen(TripsModel tripsModel ,context){

  return
   BlocConsumer<SuperCubit,AppSuperStates>(
       builder: (context,state){
         return  Container(
           height:
           SuperCubit.get(context).localeLanguage==const Locale('en')?
           MediaQuery.of(context).size.height * 0.11:MediaQuery.of(context).size.height * 0.15,
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
                 child: SingleChildScrollView(
                   child: Column(
                     crossAxisAlignment:
                     CrossAxisAlignment.start,
                     children: [
                       Row(
                         children: [
                           Text(
                               '${getLang(context, 'fromCity')} : ',
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
                               '${getLang(context, 'toCity')} : ',
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
                               '${getLang(context, 'type')}  : ',
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
                               '${getLang(context, 'price')}  : ',
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
               ),
               SizedBox(
                 width:
                 MediaQuery.of(context).size.width * 0.05,
               ),
               SingleChildScrollView(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const SizedBox(height: 8,),
                     Row(
                       children: [
                         Text('${getLang(context, 'availableChair')}',
                           style: const TextStyle(
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
                         Text('${getLang(context, 'unavailableChair')}',
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
                         '${getLang(context, 'bookedDate')} ',
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
                     const SizedBox(height: 2,)

                   ],
                 ),
               ),
               SizedBox(
                 width:
                 MediaQuery.of(context).size.width * 0.05,
               ),
               SingleChildScrollView(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const SizedBox(height: 8,),
                     Row(
                       children: [
                         Text('${getLang(context, 'waitingCart')}',
                           style: const TextStyle(
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
                         Text('${getLang(context, 'damagedChair')}',
                           style: const TextStyle(
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
                       '${getLang(context, 'timeTrip')}',
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
                     const SizedBox(height: 2,)
                   ],
                 ),
               ),
             ],
           ),
         );
       },
       listener: (context,state){});

}