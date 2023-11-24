import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/trip_model.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/admin_screens/date_table_source/trips_data_table_source.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../auth/presentation/widgets/widget.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../widgets/admin.dart';

class TripsDateTableScreen extends StatelessWidget {
  const TripsDateTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var c = SuperCubit.get(context);
    final isDarkMode = Theme.of(context).brightness;
    return SafeArea(
      child: Scaffold(
          body: BlocConsumer<SuperCubit, AppSuperStates>(
            builder: (context, state) {
              return ConditionalBuilder(
                condition: SuperCubit.get(context).tripsList.isNotEmpty,
                builder: (BuildContext context) {
                  return WillPopScope(
                    onWillPop: (){
                      for (var a in c.tripsList) {
                        a.selected = false;
                      }
                      Navigator.pop(context);
                      return Future.value(false);
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                           Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 5, left: 0),
                            child: Text(
                              'Trips Data',
                              style: Theme.of(context).textTheme.titleMedium
                            ),
                          ),
                          c.isSearching == true
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20,
                                      top: 15,
                                      bottom: 5),
                                  child: TextField(
                                    controller: c.searchTripsController,
                                    decoration: const InputDecoration(
                                        hintText: 'Search...',
                                        border: OutlineInputBorder(),
                                        suffixIcon: Icon(Icons.search)),
                                    onChanged: c.onSearchTripsTextChanged,
                                  ),
                                )
                              : const SizedBox(
                                  height: 20,
                                ),
                          PaginatedDataTable(
                            sortColumnIndex: c.currentSortColumnTrips,
                            sortAscending: c.isSortAscTrips,
                            rowsPerPage: c.rowPer,
                            availableRowsPerPage: const <int>[5, 10, 15, 20],
                            onRowsPerPageChanged: (int? v) {
                              c.rowPerPage(v!);
                            },
                            showCheckboxColumn: true,
                            columns: createColumnsTripsDataTable(context),
                            source: TripsRowDataSource(
                                SuperCubit.get(context).filteredDataTrips),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                fallback: (BuildContext context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            listener: (context, state) {},
          ),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme: IconThemeData(
              color: isDarkMode==Brightness.light?Colors.white:Colors.black,
            ),
            backgroundColor:isDarkMode==Brightness.light?Colors.black:Colors.white,
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            spacing: 4,
            spaceBetweenChildren: 4,
            children: [
              SpeedDialChild(
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  label: 'Add Trip',
                  backgroundColor: Colors.blue,
                  onTap: () {
                    customBottomSheetCustomTrips(
                        title: 'Add Trips', isUpdate: false, actionText: 'Save',
                      onTap: (){
                        c.addTrips(context);
                      },
                      context: context
                    );
                  }),
              SpeedDialChild(
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  label: 'Delete Trip',
                  backgroundColor: Colors.red.shade400,
                  onTap: () {
                    c.deleteTrip(context);
                  }),
              SpeedDialChild(
                  child: const Icon(Icons.edit,color: Colors.white,),
                  label: 'Edite Trip',
                  backgroundColor: Colors.green.shade300,
                  onTap: () {
                    c.updateTrip(context);
                  }),
              SpeedDialChild(
                  child: const Icon(Icons.recycling,color: Colors.white,),
                  label: 'Recycling Trip',
                  backgroundColor: Colors.blue.shade300,
                  onTap: () {
                     c.recyclingTrip(context);
                  }),
              SpeedDialChild(
                  child: const Icon(Icons.chair_sharp,color: Colors.white,),
                  label: 'Recycling Chairs',
                  backgroundColor: Colors.red.shade300,
                  onTap: () {
                    c.recyclingChairsOfTrip(context);
                  }),
              SpeedDialChild(
                  child: const Icon(Icons.control_point_duplicate,color: Colors.white,),
                  label: 'Add Category',
                  backgroundColor: Colors.brown.shade300,
                  onTap: () {

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title:  const Center(
                            child: Text('Add Category',
                              style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),
                            ),
                          ),
                          content:
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration:  BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(30))),
                                child: customTextField(
                                  isPassword: false,
                                  context: context,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value!.isEmpty) {}
                                    return null;
                                  },
                                  controller: c.categoryFromControl,
                                  hintText: 'Form City',
                                  iconData: Icons.bus_alert,
                                  colorIcon:Colors.black45,
                                  hintTextColor:Colors.black45,
                                  textColor: Colors.black,
                                  obscureText: false,
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration:  BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(30))),
                                child: customTextField(
                                  isPassword: false,
                                  context: context,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value!.isEmpty) {}
                                    return null;
                                  },
                                  controller: c.categoryToControl,
                                  hintText: 'To City',
                                  iconData: Icons.directions_bus_sharp,
                                  colorIcon:Colors.black45,
                                  hintTextColor:Colors.black45,
                                  textColor: Colors.black,
                                  obscureText: false,
                                ),
                              ),
                              const SizedBox(height: 25,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: MediaQuery.of(context).size.width * 0.09,
                                      width: MediaQuery.of(context).size.width * 0.28,
                                      decoration: const BoxDecoration(
                                          color: Colors.black45,
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(30))),
                                      child: const Center(child: Text('Cancel',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),)),

                                    ),
                                  ),
                                  const SizedBox(width: 20,),
                                  InkWell(onTap: ()async{
                                    c.addCategory(context);
                                  },
                                    child: Container(
                                      height: MediaQuery.of(context).size.width * 0.09,
                                      width: MediaQuery.of(context).size.width * 0.28,
                                      decoration: const BoxDecoration(
                                          color: Colors.black45,
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(30))),
                                      child: const Center(child: Text('Add',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      )),
                                    ),
                                  ),
                                ],
                              )


                            ],
                          ),

                        );
                      },
                    );
                  }),
              SpeedDialChild(
                  child: const Icon(Icons.search),
                  label: 'Search Trips',
                  backgroundColor: Colors.grey.shade200,
                  onTap: () {
                    c.changeSearch();
                  }),

            ],
          )),
    );
  }
}
