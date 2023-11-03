import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:superjet/core/image/image.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/admin_users_model.dart';
import '../../../auth/presentation/widgets/widget.dart';
import '../../data/models/admin_trips_model.dart';
import '../bloc/cubit.dart';

Widget customAdminItems(IconData iconData ,String name ,void Function()? onTap,context){
  var m =MediaQuery.of(context).size;
  return
    InkWell(
    onTap: onTap,
    child: Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            boxShadow: const [BoxShadow(color: Colors.black54,blurRadius: 3)]
        ),
        width: m.width*.9,
        height: m.height*0.1,
        child: Center(
          child: Row(
            children: [
              SizedBox(width: m.width*0.1,),
              Icon(iconData,
                color:  Colors.blue.shade900,
                size: 40,
              ),
              SizedBox(width:  m.width*0.12,),
              Expanded(
                child: Text(name,
                  style: TextStyle(
                    fontSize: 25,
                    color:  Colors.blue.shade900,
                    fontWeight: FontWeight.bold,
                  ),

                ),
              ),


            ],
          ),
        ),
      ),
    ),
  );
}

List<DataColumn> createColumnsUsersDataTable(context) {
  var c =SuperCubit.get(context);
  return [
    DataColumn(label: const Text('Name'),
        onSort: ( columIndex, x){
          c.currentSortColumn =columIndex;
          if (c.isSortAsc) {
            c.usersList.sort((a, b) => b.name.compareTo(a.name));
          } else {
            c.usersList.sort((a, b) => a.name.compareTo(b.name));
          }
          c.sortingUserDataTable();
        }
    ),
    DataColumn(label: const Text('Email'),
        onSort: ( columIndex, x){
          c.currentSortColumn =columIndex;
          if (c.isSortAsc) {
            c.usersList.sort((a, b) => b.email.compareTo(a.email));
          } else {
            c.usersList.sort((a, b) => a.email.compareTo(b.email));
          }
          c.sortingUserDataTable();
        }
    ),
    DataColumn(label: const Text('Phone'),
        onSort: ( columIndex, x){
          c.currentSortColumn =columIndex;
          if (c.isSortAsc) {
            c.usersList.sort((a, b) => b.phone.compareTo(a.phone));
          } else {
            c.usersList.sort((a, b) => a.phone.compareTo(b.phone));
          }
          c.sortingUserDataTable();
        }
    ),
    DataColumn(label: const Text('ID'),
        onSort: ( columIndex, x){
          c.currentSortColumn =columIndex;
          if (c.isSortAsc) {
            c.usersList.sort((a, b) => b.uId.compareTo(a.uId));
          } else {
            c.usersList.sort((a, b) => a.uId.compareTo(b.uId));
          }
          c.sortingUserDataTable();
        }
    ),
    DataColumn(label: const Text('City'),
        onSort: ( columIndex, x){
          c.currentSortColumn =columIndex;
          if (c.isSortAsc) {
            c.usersList.sort((a, b) => b.city.compareTo(a.city));
          } else {
            c.usersList.sort((a, b) => a.city.compareTo(b.city));
          }
          c.sortingUserDataTable();
        }
    ),
    DataColumn(label: const Text('Trips'),
        onSort: ( columIndex, x){
          c.currentSortColumn =columIndex;
          if (c.isSortAsc) {
            c.usersList.sort((a, b) => b.tripIdList!.length.compareTo(a.tripIdList!.length));
          } else {
            c.usersList.sort((a, b) => a.tripIdList!.length.compareTo(b.tripIdList!.length));
          }
          c.sortingUserDataTable();
        }
    ),
    const DataColumn(label: Text('Image'),),
  ];
}
List<DataColumn> createColumnsBranchesDataTable(context) {
  var c =SuperCubit.get(context);
  return [
    DataColumn(label: const Text('Name'),
        onSort: ( columIndex, x){
          c.currentSortColumn =columIndex;
          if (c.isSortAsc) {
            c.branchesList.sort((a, b) => b.name.compareTo(a.name));
          } else {
            c.branchesList.sort((a, b) => a.name.compareTo(b.name));
          }
          c.sortingUserDataTable();
        }
    ),
    DataColumn(label: const Text('Email'),
        onSort: ( columIndex, x){
          c.currentSortColumn =columIndex;
          if (c.isSortAsc) {
            c.branchesList.sort((a, b) => b.email.compareTo(a.email));
          } else {
            c.branchesList.sort((a, b) => a.email.compareTo(b.email));
          }
          c.sortingUserDataTable();
        }
    ),
    const DataColumn(label: Text('Password'),),
    DataColumn(label: const Text('Phone'),
        onSort: ( columIndex, x){
          c.currentSortColumn =columIndex;
          if (c.isSortAsc) {
            c.branchesList.sort((a, b) => b.phone.compareTo(a.phone));
          } else {
            c.branchesList.sort((a, b) => a.phone.compareTo(b.phone));
          }
          c.sortingUserDataTable();
        }
    ),
    DataColumn(label: const Text('ID'),
        onSort: ( columIndex, x){
          c.currentSortColumn =columIndex;
          if (c.isSortAsc) {
            c.branchesList.sort((a, b) => b.uId.compareTo(a.uId));
          } else {
            c.branchesList.sort((a, b) => a.uId.compareTo(b.uId));
          }
          c.sortingUserDataTable();
        }
    ),
    DataColumn(label: const Text('City'),
        onSort: ( columIndex, x){
          c.currentSortColumn =columIndex;
          if (c.isSortAsc) {
            c.branchesList.sort((a, b) => b.city.compareTo(a.city));
          } else {
            c.branchesList.sort((a, b) => a.city.compareTo(b.city));
          }
          c.sortingUserDataTable();
        }
    ),
    DataColumn(label: const Text('Trips'),
        onSort: ( columIndex, x){
          c.currentSortColumn =columIndex;
          if (c.isSortAsc) {
            c.branchesList.sort((a, b) => b.tripIdList!.length.compareTo(a.tripIdList!.length));
          } else {
            c.branchesList.sort((a, b) => a.tripIdList!.length.compareTo(b.tripIdList!.length));
          }
          c.sortingUserDataTable();
        }
    ),
    const DataColumn(label: Text('Image'),),
  ];
}

List<DataColumn> createColumnsTripsDataTable(context) {
  var c =SuperCubit.get(context);
  return [
    DataColumn(label: const Text('Name'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.filteredDataTrips.sort((a, b) => b.name.compareTo(a.name));
          } else {
            c.filteredDataTrips.sort((a, b) => a.name.compareTo(b.name));
          }
          c.sortingTripsDataTable();
        }
    ),
    DataColumn(label: const Text('Date'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.filteredDataTrips.sort((a, b) => b.date.compareTo(a.date));
          } else {
            c.filteredDataTrips.sort((a, b) => a.date.compareTo(b.date));
          }
          c.sortingTripsDataTable();
        }
    ),
    DataColumn(label: const Text('Time'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.filteredDataTrips.sort((a, b) => b.time.compareTo(a.time));
          } else {
            c.filteredDataTrips.sort((a, b) => a.time.compareTo(b.time));
          }
          c.sortingTripsDataTable();
        }
    ),
    DataColumn(label: const Text('Price'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.filteredDataTrips.sort((a, b) => b.price.compareTo(a.price));
          } else {
            c.filteredDataTrips.sort((a, b) => a.price.compareTo(b.price));
          }
          c.sortingTripsDataTable();
        }
    ),
    const DataColumn(label: Text('Type'),),
    DataColumn(label: const Text('Average Time'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.filteredDataTrips.sort((a, b) => b.avgTime.compareTo(a.avgTime));
          } else {
            c.filteredDataTrips.sort((a, b) => a.avgTime.compareTo(b.avgTime));
          }
          c.sortingTripsDataTable();
        }
    ),
    DataColumn(label: const Text('From City'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.filteredDataTrips.sort((a, b) => b.fromCity.compareTo(a.fromCity));
          } else {
            c.filteredDataTrips.sort((a, b) => a.fromCity.compareTo(b.fromCity));
          }
          c.sortingTripsDataTable();
        }
    ),
    DataColumn(label: const Text('To City'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.filteredDataTrips.sort((a, b) => b.toCity.compareTo(a.toCity));
          } else {
            c.filteredDataTrips.sort((a, b) => a.toCity.compareTo(b.toCity));
          }
          c.sortingTripsDataTable();
        }
    ),
    DataColumn(label: const Text('Trips ID'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.filteredDataTrips.sort((a, b) => b.tripID.compareTo(a.tripID));
          } else {
            c.filteredDataTrips.sort((a, b) => a.tripID.compareTo(b.tripID));
          }
          c.sortingTripsDataTable();
        }
    ),
    DataColumn(label: const Text('Category Name'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.filteredDataTrips.sort((a, b) => b.categoryName.compareTo(a.categoryName));
          } else {
            c.filteredDataTrips.sort((a, b) => a.categoryName.compareTo(b.categoryName));
          }
          c.sortingTripsDataTable();
        }
    ),
    DataColumn(label: const Text('Category ID'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.filteredDataTrips.sort((a, b) => b.categoryID.compareTo(a.categoryID));
          } else {
            c.filteredDataTrips.sort((a, b) => a.categoryID.compareTo(b.categoryID));
          }
          c.sortingTripsDataTable();
        }
    ),
    DataColumn(label: const Text('State'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.filteredDataTrips.sort((a, b) => b.state.compareTo(a.state));
          } else {
            c.filteredDataTrips.sort((a, b) => a.state.compareTo(b.state));
          }
          c.sortingTripsDataTable();
        }
    ),
    const DataColumn(label: Text('Image'),),
  ];
}

Future customBottomSheetCustomTrips({required String title,required bool isUpdate ,required String actionText,void Function()? onTap, context,TripsModelDataTable? tripsModelDataTable }){
  var c =SuperCubit.get(context);

  isUpdate==true? c.addDate.text = tripsModelDataTable!.date:c.addDate.text='';
  isUpdate==true? c.addTime.text = tripsModelDataTable!.time:c.addTime.text='';
  isUpdate==true? c.addPrice.text = tripsModelDataTable!.price:c.addPrice.text='';
  isUpdate==true? c.addAvgTime.text = tripsModelDataTable!.avgTime:c.addAvgTime.text='';
  isUpdate==true? (c.selectedOptionType=tripsModelDataTable!.isVip=='false'?0:1)  :c.selectedOptionType=0;
  isUpdate==true? (c.selectedOptionState=tripsModelDataTable!.state=='waiting'?2:3):c.selectedOptionState=2;
  return
    showModalBottomSheet(
      backgroundColor: Colors.white,
      elevation:5.5,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                 Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    )),
                const SizedBox(
                  height: 20,
                ),
              StatefulBuilder(builder: (context ,setState){
                  return
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        isUpdate ==false?
                        DropdownButton(
                          value: c.btn2SelectedVal,
                          hint: const Text('Choose'),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState((){
                               c.isSelectedCategory=true;
                                c.btn2SelectedVal =newValue;
                                c.addFromCity.text=c.categoriesNameList2[int.parse(newValue)].
                                city.toString().trim();
                                c.addToCity.text=c.categoriesNameList2[int.parse(newValue)].
                                masterCity.toString().trim();
                              }

                              );
                              // SuperCubit.get(context).btn2SelectedVal = newValue;
                            }
                          },
                          items: c.dropdownItems2,
                        ):
                        const Text('Category Name : '),
                        isUpdate ==false?
                        DropdownButton(
                          value:
                          c.btn2SelectedVal,
                          hint: const Text('Choose'),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState((){
                                c.isSelectedCategory=true;
                                c.btn2SelectedVal =newValue;
                                c.addFromCity.text=c.categoriesNameList[int.parse(newValue)].
                                masterCity.toString().trim();
                                c.addToCity.text=c.categoriesNameList[int.parse(newValue)].
                                city.toString().trim();
                              }

                              );
                              // SuperCubit.get(context).btn2SelectedVal = newValue;
                            }
                          },
                          items: c.dropdownItems,
                        ):
                        Text(tripsModelDataTable!.categoryName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold
                          ),),

                      ],
                    );

                }),

                const SizedBox(
                  height: 10,
                ),
                isUpdate ==false?   Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width *
                          0.45,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(30))),
                      child: customTextField(
                        isPassword: false,
                        context: context,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {}
                          return null;
                        },
                        controller: c
                            .addFromCity,
                        hintText: 'Form City',
                        iconData: Icons.bus_alert_rounded,
                        colorIcon: Colors.black54,
                        hintTextColor: Colors.black54,
                        textColor: Colors.black,
                        obscureText: false,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width *
                          0.45,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(30))),
                      child: customTextField(
                        isPassword: false,
                        context: context,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {}
                          return null;
                        },
                        controller: c
                            .addToCity,
                        hintText: 'To City',
                        iconData: Icons.directions_bus,
                        colorIcon: Colors.black54,
                        hintTextColor: Colors.black54,
                        textColor: Colors.black,
                        obscureText: false,
                      ),
                    ),
                  ],
                ):const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width *
                          0.45,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(30))),
                      child: customTextField(
                        isPassword: false,
                        context: context,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'must be is not empty';
                          }
                          return null;
                        },
                        onTap: (){
                          var date = DateTime.now();
                          var newDate = DateTime(date.year,
                              date.month + 1, date.day);
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse(
                                  newDate.toString()))
                              .then((value) => {
                            c.addDate.text =
                                DateFormat('yyyy-MM-dd').format(value!)
                          });
                        },
                        controller: c
                            .addDate,
                        hintText: 'Date',
                        iconData: Icons.calendar_month,
                        colorIcon: Colors.black54,
                        hintTextColor: Colors.black54,
                        textColor: Colors.black,
                        obscureText: false,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width *
                          0.45,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(30))),
                      child: customTextField(
                        isPassword: false,
                        context: context,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'must be is not empty';
                          }
                          return null;
                        },
                        onTap: (){
                          showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now())
                              .then((value) => {
                            c.addTime.text =
                                '${value!.hour.toString().length==1?'0${value.hour.toString()}':value.hour.toString()}:${value.minute.toString().length==1?'0${value.minute.toString()}':value.minute.toString()}:00'
                          });
                        },
                        controller: c
                            .addTime,
                        hintText: 'Time',
                        iconData: Icons.access_time,
                        colorIcon: Colors.black54,
                        hintTextColor: Colors.black54,
                        textColor: Colors.black,
                        obscureText: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width *
                          0.45,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(30))),
                      child: customTextField(
                        isPassword: false,
                        context: context,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {}
                          return null;
                        },
                        controller: c
                            .addPrice,
                        hintText: 'Price',
                        iconData: Icons.money,
                        colorIcon: Colors.black54,
                        hintTextColor: Colors.black54,
                        textColor: Colors.black,
                        obscureText: false,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width *
                          0.45,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(30))),
                      child: customTextField(
                        isPassword: false,
                        context: context,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {}
                          return null;
                        },
                        controller: c
                            .addAvgTime,
                        hintText: 'Avg Time',
                        iconData: Icons.align_vertical_bottom,
                        colorIcon: Colors.black54,
                        hintTextColor: Colors.black54,
                        textColor: Colors.black,
                        obscureText: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                  isUpdate==false?
                  Container(
                        height:
                        MediaQuery.of(context).size.width * 0.11,
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius:
                            const BorderRadius.all(
                                Radius.circular(30))),
                        child:
                        const Center(child: Text('Image'))):
                  Container(
                    height:
                    MediaQuery.of(context).size.width *
                        0.12,
                    width: MediaQuery.of(context).size.width *
                        0.45,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(30))),
                    child:
                    StatefulBuilder(
                      builder: (BuildContext context,
                          StateSetter setState) {
                        return FittedBox(
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 2,
                                    groupValue:c
                                        .selectedOptionState,
                                    onChanged: (int? value) {
                                      setState(() {
                                        c.selectedOptionState = value!;
                                      });
                                    },
                                  ),
                                  const FittedBox(child: Text('Waiting')),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: 3,
                                    groupValue:
                                    c.selectedOptionState,
                                    onChanged: (value) {
                                      setState(() {
                                      c.selectedOptionState = value!;
                                      });
                                    },
                                  ),
                                  const FittedBox(child: Text('Finished')),
                                ],
                              ),
                              const SizedBox(width: 15,)
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                    Container(
                      height:
                      MediaQuery.of(context).size.width *
                          0.12,
                      width: MediaQuery.of(context).size.width *
                          0.45,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(30))),
                      child:
                      StatefulBuilder(
                        builder: (BuildContext context,
                            StateSetter setState) {
                          return FittedBox(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Radio<int>(
                                      value: 0,
                                      groupValue:c.selectedOptionType,
                                      onChanged: (int? value) {
                                        setState(() {
                                          c.selectedOptionType = value!;

                                        }
                                        );
                                      },
                                    ),
                                    const Text('Normal'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue:
                                      c.selectedOptionType,
                                      onChanged: (value) {
                                        setState(() {
                                          c.selectedOptionType = value!;
                                        }
                                        );
                                      },
                                    ),
                                    const Text('VIP'),
                                  ],
                                ),
                                const SizedBox(width: 15,)

                              ],

                            ),

                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),


                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        height:
                        MediaQuery.of(context).size.width *
                            0.1,
                        width: MediaQuery.of(context).size.width *
                            0.35,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            boxShadow: const [BoxShadow(color: Colors.black54,blurRadius: 5)],
                            borderRadius: const BorderRadius.all(
                                Radius.circular(30))),
                        child: const Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.white,
                                  shadows:  [BoxShadow(color: Colors.black54,blurRadius: 4)],
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                    InkWell(
                      onTap:onTap,
                      child: Container(
                        height:
                        MediaQuery.of(context).size.width *
                            0.1,
                        width: MediaQuery.of(context).size.width *
                            0.35,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            boxShadow: const [BoxShadow(color: Colors.black54,blurRadius: 5)],
                            borderRadius: const BorderRadius.all(
                                Radius.circular(30))),
                        child:  Center(
                            child: Text(
                              actionText,
                              style: const TextStyle(
                                  color: Colors.white,
                                  shadows:  [BoxShadow(color: Colors.black54,blurRadius: 4)],

                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        );
      });
}

Future customBottomSheetCustomUsers({required String title,required bool isUpdate ,required bool isBranch,required String actionText,void Function()? onTap, context,UsersTableModel? usersTableModel }){
  var c =SuperCubit.get(context);

  isUpdate==true? c.userName.text = usersTableModel!.name:c.userName.text='';
  isUpdate==true? c.userPhone.text = usersTableModel!.phone:c.userPhone.text='';
  isUpdate==true? c.userCity.text = usersTableModel!.city:c.userCity.text='';
  isUpdate==true? isBranch==true?c.userEmail.text=usersTableModel!.email:null:c.userEmail.text='';
  isUpdate==true? isBranch==true?c.userPassword.text=usersTableModel!.password:null:c.userPassword.text='';
  return   showModalBottomSheet(
    backgroundColor: Colors.white,
      elevation:5.5,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: SizedBox(
            height: MediaQuery.of(context).size.height*0.7,
            child: ListView(
              children: [
                const SizedBox(
                  height: 40,
                ),
                 Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(30))),
                  child: customTextField(
                    isPassword: false,
                    context: context,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {}
                      return null;
                    },
                    controller: c.userName,
                    hintText: 'Name',
                    iconData: Icons.person,
                    colorIcon: Colors.black54,
                    hintTextColor: Colors.black54,
                    textColor: Colors.black,
                    obscureText: false,
                  ),
                ),
                 SizedBox(
                  height:  isUpdate==false?20:0,
                ),
                isBranch==false? isUpdate==false?
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(30))),
                  child: customTextField(
                    isPassword: false,
                    context: context,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {}
                      return null;
                    },
                    controller: c.userEmail,
                    hintText: 'Email',
                    iconData: Icons.email,
                    colorIcon: Colors.black54,
                    hintTextColor: Colors.black54,
                    textColor: Colors.black,
                    obscureText: false,
                  ),
                ):const SizedBox():Padding(
                  padding:  EdgeInsets.only(top: isUpdate==true?20.0:0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(30))),
                    child: customTextField(
                      isPassword: false,
                      context: context,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {}
                        return null;
                      },
                      controller: c.userEmail,
                      hintText: 'Email',
                      iconData: Icons.email,
                      colorIcon: Colors.black54,
                      hintTextColor: Colors.black54,
                      textColor: Colors.black,
                      obscureText: false,
                    ),
                  ),
                ),
                 SizedBox(
                  height: isUpdate==false?20:0,
                ),
                isBranch==false? isUpdate==false?
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(30))),
                  child: customTextField(
                    isPassword: false,
                    context: context,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {}
                      return null;
                    },
                    controller: c.userPassword,
                    hintText: 'Password',
                    iconData: Icons.security,
                    colorIcon: Colors.black54,
                    hintTextColor: Colors.black54,
                    textColor: Colors.black,
                    obscureText: false,
                  ),
                ):const SizedBox():
                Padding(
                  padding:  EdgeInsets.only(top:  isUpdate==true?20.0:0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(30))),
                    child: customTextField(
                      isPassword: false,
                      context: context,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {}
                        return null;
                      },
                      controller: c.userPassword,
                      hintText: 'Password',
                      iconData: Icons.security,
                      colorIcon: Colors.black54,
                      hintTextColor: Colors.black54,
                      textColor: Colors.black,
                      obscureText: false,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(30))),
                  child: customTextField(
                    isPassword: false,
                    context: context,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {}
                      return null;
                    },
                    controller: c.userPhone,
                    hintText: 'Phone',
                    iconData: Icons.phone,
                    colorIcon: Colors.black54,
                    hintTextColor: Colors.black54,
                    textColor: Colors.black,
                    obscureText: false,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(30))),
                  child: customTextField(
                    isPassword: false,
                    context: context,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.isEmpty) {}
                      return null;
                    },
                    controller: c.userCity,
                    hintText: 'City',
                    iconData: Icons.location_city,
                    colorIcon: Colors.black54,
                    hintTextColor: Colors.black54,
                    textColor: Colors.black,
                    obscureText: false,
                    onFieldSubmitted: (v){
                      onTap;
                    }
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        height:
                        MediaQuery.of(context).size.width *
                            0.1,
                        width: MediaQuery.of(context).size.width *
                            0.35,
                        decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                            boxShadow: const [BoxShadow(color: Colors.black54,blurRadius: 5)],
                            borderRadius: const BorderRadius.all(
                                Radius.circular(30))),
                        child: const Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.white,
                                  shadows: [BoxShadow(color: Colors.black54,blurRadius: 4)],
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                    InkWell(
                      onTap:onTap,
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.1,
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                            boxShadow: const [BoxShadow(color: Colors.black54,blurRadius: 5)],
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.all(
                                Radius.circular(30))),
                        child:  Center(
                            child: Text(
                              actionText,
                              style: const TextStyle(
                                  shadows: [BoxShadow(color: Colors.black54,blurRadius: 4)],
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 200,
                ),
              ],
            ),
          ),
        );
      });
}


