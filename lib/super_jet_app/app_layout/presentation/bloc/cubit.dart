import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/trip_model.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/state.dart';
import '../../domain/use_cases/trips_usecase.dart';

class SuperCubit extends Cubit<AppSuperStates> {
  final TripsUseCase tripsUseCase;
  SuperCubit(this.tripsUseCase) : super(AppSuperInitialStates());

  final ScrollController scrollController = ScrollController();
  TextEditingController controllerName= TextEditingController();
  TextEditingController controllerPhone= TextEditingController();
  static SuperCubit get(context) => BlocProvider.of(context);
  var categoriesIndex =0;
  List<TripsModel> listCartTrips=[];
  List chairsId=[];
  List chairsDoc=[];
  double suTotal=0.0;
  double total=0.0;
  double tax= 5.0;
  double discount=-10.0;
  bool isPay=false;


   addCartTrips(TripsModel tripsModel,String chairId,String chairDoc ){
    listCartTrips.add(tripsModel);
    chairsId.add(chairId);
    chairsDoc.add(chairDoc);
    suTotal +=double.parse(tripsModel.price);
    total =suTotal+tax+discount;
    emit(GetCartTrips());
  }
   deleteCartTrips(TripsModel tripsModel,String chairId,String chairDoc  ){
     listCartTrips.remove(tripsModel);
     chairsId.remove(chairId);
     chairsDoc.remove(chairDoc);
     suTotal -=double.parse(tripsModel.price);
     total =suTotal+tax+discount;
     total<0?total=0:total=total;
     emit(DeleteCartTrips());
   }
  removeCart(){
    listCartTrips.clear();
    chairsDoc.clear();
    chairsId.clear();
    suTotal=0.0;
    total=0.0;
   emit(RemoveCartTrips());
  }


  changeCategoriesIndex(int i){
    categoriesIndex =i;
    emit(ChangeCategoriesIndexState());
  }
  bool x=false;
  chickIndex(bool y){
    x=y;
    emit(ChickChangeCategoriesIndexState());
  }

  File? profileImageFile;
  File? coverImageFile;
  String profileImageFilepath ='';
  String coverImageFilepath='';













  //
  // String today = DateFormat("dd/MM/yyyy").format(DateTime.now());
  // String tomorrow = DateFormat("dd/MM/yyyy").format(DateTime.now().add(const Duration(days: 1)));
  // String nextTomorrow = DateFormat("dd/MM/yyyy").format(DateTime.now().add(const Duration(days: 2)));
  // String day1 = DateFormat("dd/MM/yyyy").format(DateTime.now().add(const Duration(days: 3)));
  // String day2 = DateFormat("dd/MM/yyyy").format(DateTime.now().add(const Duration(days: 4)));
  // String day3 = DateFormat("dd/MM/yyyy").format(DateTime.now().add(const Duration(days: 5)));
  // String day4 = DateFormat("dd/MM/yyyy").format(DateTime.now().add(const Duration(days: 6)));
  //
  // List<DropdownMenuItem<String>> get dropdownItems{
  //   List<DropdownMenuItem<String>> menuItems = [
  //     DropdownMenuItem(value: "Today", child: Text(today.toString(),
  //       style: const TextStyle(
  //           color: Colors.white,
  //           fontSize: 14,
  //           fontWeight: FontWeight.bold,
  //           shadows: [BoxShadow(color: Colors.white54,blurRadius: 1)]
  //       ),
  //     )),
  //     DropdownMenuItem(value: "Tomorrow", child: Text(tomorrow.toString(),  style: const TextStyle(
  //         color: Colors.white,
  //         fontSize: 14,
  //         fontWeight: FontWeight.bold,
  //         shadows: [BoxShadow(color: Colors.white54,blurRadius: 1)]
  //     ),)),
  //     DropdownMenuItem(value: "Next Tomorrow", child: Text(nextTomorrow.toString(),   style: const TextStyle(
  //         color: Colors.white,
  //         fontSize: 14,
  //         fontWeight: FontWeight.bold,
  //         shadows: [BoxShadow(color: Colors.white54,blurRadius: 1)]
  //     ),)),
  //     DropdownMenuItem(value: "Future day1", child: Text(day1.toString(),  style: const TextStyle(
  //         color: Colors.white,
  //         fontSize: 14,
  //         fontWeight: FontWeight.bold,
  //         shadows: [BoxShadow(color: Colors.white54,blurRadius: 1)]
  //     ),)),
  //     DropdownMenuItem(value: "Future day2", child: Text(day2.toString(),  style: const TextStyle(
  //         color: Colors.white,
  //         fontSize: 14,
  //         fontWeight: FontWeight.bold,
  //         shadows: [BoxShadow(color: Colors.white54,blurRadius: 1)]
  //     ),)),
  //     DropdownMenuItem(value: "Future day3", child: Text(day3.toString(),   style: const TextStyle(
  //   color: Colors.white,
  //   fontSize: 14,
  //   fontWeight: FontWeight.bold,
  //   shadows: [BoxShadow(color: Colors.white54,blurRadius: 1)]
  //   ),)),
  //     DropdownMenuItem(value: "Future day4", child: Text(day4.toString(),  style: const TextStyle(
  //   color: Colors.white,
  //   fontSize: 14,
  //   fontWeight: FontWeight.bold,
  //   shadows: [BoxShadow(color: Colors.white54,blurRadius: 1)]
  //   ),)),
  //   ];
  //   return menuItems;
  // }
  // String selectedValue = "Today";
  // changeDropdownValue(String value){
  //   selectedValue=value;
  //   emit(ChickChangeCategoriesIndexState());
  // }
  // String time = DateFormat("KK:mm a").format(DateTime.now());
  // String timef = DateFormat("KK:mm a").format(DateTime.now().add(Duration(hours: 2)));
 //
 //  List<String> res=[];
 // Future getAllTimeOfTrip(String fromCity,String toCity,context)async {
 //   res=['9:00 am'];
 //   emit(ChangeDropdownValueTime());
 //   List<TripsModel> list = await tripsUseCase.getTrips(fromCity, context);
 //    for(var n in list){
 //      if(n.toCity==toCity){
 //        menuItemsTime.add(
 //            DropdownMenuItem(value: n.time, child: Text(n.time.toString(),
 //                    style: const TextStyle(
 //                        color: Colors.white,
 //                        fontSize: 14,
 //                        fontWeight: FontWeight.bold,
 //                        shadows: [BoxShadow(color: Colors.white54,blurRadius: 1)]
 //                    ),
 //                  )),
 //        );
 //        res.add(n.time);
 //      }
 //    }
 //    print(res.length);
 //    print(res.toString());
 //   emit(ChangeDropdownValueTime());
 // }
 //  List<DropdownMenuItem<String>> menuItemsTime =[];
 //
 //  // List<DropdownMenuItem<String>> chick(){
 //  //
 //  //   for(var x in res){
 //  //     menuItemsTime.add(
 //  //       DropdownMenuItem(value: "TimeNow", child: Text(
 //  //         x.toString(),
 //  //         style: const TextStyle(
 //  //             color: Colors.white,
 //  //             fontSize: 14,
 //  //             fontWeight: FontWeight.bold,
 //  //             shadows: [BoxShadow(color: Colors.white54,blurRadius: 1)]
 //  //         ),
 //  //       )),);
 //  //   }
 //  //  return menuItemsTime;
 //  // }
 //
 //  List<DropdownMenuItem<String>> get dropdownItemsTime{
 //    // List<DropdownMenuItem<String>> menuItemsTime = [
 //    //   DropdownMenuItem(value: "TimeNow", child: Text(time.toString(),
 //    //     style: const TextStyle(
 //    //         color: Colors.white,
 //    //         fontSize: 14,
 //    //         fontWeight: FontWeight.bold,
 //    //         shadows: [BoxShadow(color: Colors.white54,blurRadius: 1)]
 //    //     ),
 //    //   )),
 //    //   DropdownMenuItem(value: "Tomorrow", child: Text(time.toString(),  style: const TextStyle(
 //    //       color: Colors.white,
 //    //       fontSize: 14,
 //    //       fontWeight: FontWeight.bold,
 //    //       shadows: [BoxShadow(color: Colors.white54,blurRadius: 1)]
 //    //   ),)),
 //    //   DropdownMenuItem(value: "Next Tomorrow", child: Text(time.toString(),  style: const TextStyle(
 //    //       color: Colors.white,
 //    //       fontSize: 14,
 //    //       fontWeight: FontWeight.bold,
 //    //       shadows: [BoxShadow(color: Colors.white54,blurRadius: 1)]
 //    //   ),)),
 //    //   DropdownMenuItem(value: "Future day1", child: Text(time.toString(),   style: const TextStyle(
 //    //       color: Colors.white,
 //    //       fontSize: 14,
 //    //       fontWeight: FontWeight.bold,
 //    //       shadows: [BoxShadow(color: Colors.white54,blurRadius: 1)]
 //    //   ),)),
 //    //   DropdownMenuItem(value: "Future day2", child: Text(time.toString(),  style: const TextStyle(
 //    //       color: Colors.white,
 //    //       fontSize: 14,
 //    //       fontWeight: FontWeight.bold,
 //    //       shadows: [BoxShadow(color: Colors.white54,blurRadius: 1)]
 //    //   ),)),
 //    //   DropdownMenuItem(value: "Future day3", child: Text(time.toString(),   style: const TextStyle(
 //    //       color: Colors.white,
 //    //       fontSize: 14,
 //    //       fontWeight: FontWeight.bold,
 //    //       shadows: [BoxShadow(color: Colors.white54,blurRadius: 1)]
 //    //   ),)),
 //    //   DropdownMenuItem(value: "Future day4", child: Text(timef.toString(),  style: const TextStyle(
 //    //       color: Colors.white,
 //    //       fontSize: 14,
 //    //       fontWeight: FontWeight.bold,
 //    //       shadows: [BoxShadow(color: Colors.white54,blurRadius: 1)]
 //    //   ),)),
 //    // ];
 //
 //    for(var x in res){
 //      menuItemsTime.add(
 //          DropdownMenuItem(value: '9:00 am', child: Text(
 //            x.toString(),
 //              style: const TextStyle(
 //                  color: Colors.white,
 //                  fontSize: 14,
 //                  fontWeight: FontWeight.bold,
 //                  shadows: [BoxShadow(color: Colors.white54,blurRadius: 1)]
 //              ),
 //            )),);
 //    }
 //    return menuItemsTime;
 //  }
 //
 //
 //   String selectedValueTime = '9:00 am';
 //  changeDropdownValueTime(String value){
 //    selectedValueTime=value;
 //    emit(ChangeDropdownValueTime());
 //  }
}