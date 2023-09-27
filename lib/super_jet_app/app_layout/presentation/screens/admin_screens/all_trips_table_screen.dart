import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/admin_screens/date_table_source/trips_data_table_source.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../widgets/admin.dart';

class TripsDateTableScreen extends StatelessWidget {
  const TripsDateTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var c =SuperCubit.get(context);
    return SafeArea(
      child: Scaffold(
          body:
          BlocConsumer<SuperCubit,AppSuperStates>(
            builder: (context,state){
              return ConditionalBuilder(
                condition: SuperCubit.get(context).tripsList.isNotEmpty,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: PaginatedDataTable(
                      header: const Padding(
                        padding: EdgeInsets.only(top: 20.0,bottom: 10,left: 0),
                        child: Text('Trips Data',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),
                      ),
                      sortColumnIndex: c.currentSortColumnTrips,
                      sortAscending: c.isSortAscTrips,
                      rowsPerPage: c.rowPer,
                      availableRowsPerPage: const <int>[5,10,15,20],
                      onRowsPerPageChanged: (int? v){
                        c.rowPerPage(v!);
                      },
                      columns: createColumnsTripsDataTable(context),
                      source: TripsRowDataSource(SuperCubit.get(context).tripsList),
                    )
                );
                },
                fallback: (BuildContext context) =>const Center(child: CircularProgressIndicator(),),

              );
            },
            listener: (context,state){},
          )
      ),
    );

  }
}
