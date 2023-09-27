import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/state.dart';
import '../../widgets/admin.dart';
import 'date_table_source/users_data_table_source.dart';

class UserTableScreen extends StatelessWidget{
   const UserTableScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var c =SuperCubit.get(context);
    return SafeArea(
      child: Scaffold(
        body:
        BlocConsumer<SuperCubit,AppSuperStates>(
          builder: (context,state){
            return ConditionalBuilder(
                condition: SuperCubit.get(context).usersList.isNotEmpty,
                builder: (BuildContext context){
                  return SingleChildScrollView(
                      child: PaginatedDataTable(
                        header: const Padding(
                          padding: EdgeInsets.only(top: 20.0,bottom: 10,left: 0),
                          child: Text('Users Data',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),),
                        ),
                        sortColumnIndex: c.currentSortColumn,
                        sortAscending: c.isSortAsc,
                        rowsPerPage: c.rowPer,
                        availableRowsPerPage: const <int>[5,10,15,20],
                        onRowsPerPageChanged: (int? v){
                          c.rowPerPage(v!);
                        },
                        columns: createColumnsUsersDataTable(context),
                        source: RowDataSource(SuperCubit.get(context).usersList),
                      )
                  );
                },
                fallback: (context)=>const Center(child: CircularProgressIndicator(),));
          },
          listener: (context,state){},
        )
      ),
    );
  }
}
