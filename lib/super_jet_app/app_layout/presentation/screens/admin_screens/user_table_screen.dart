import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/state.dart';
import '../../widgets/admin.dart';
import 'date_table_source/users_data_table_source.dart';

class UserTableScreen extends StatelessWidget{
   const UserTableScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var c =SuperCubit.get(context);
    final isDarkMode = Theme.of(context).brightness;

    return SafeArea(
      child: Scaffold(
        body:
        BlocConsumer<SuperCubit,AppSuperStates>(
          builder: (context,state){
            return ConditionalBuilder(
                condition: SuperCubit.get(context).usersList.isNotEmpty,
                builder: (BuildContext context){
                  return SingleChildScrollView(
                      child: Column(
                        children: [
                           Padding(
                            padding:
                            const EdgeInsets.only(top: 20.0, bottom: 5, left: 0),
                            child: Text(
                              'Users Data',
                              style: Theme.of(context).textTheme.titleMedium
                            ),
                          ),
                          c.isSearchingUser == true
                              ?   Padding(
                          padding: const EdgeInsets.only(left: 20.0,right: 20,top: 35),
                          child: TextField(
                            controller: c.searchUsersController,
                            decoration: const InputDecoration(
                                hintText: 'Search...',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.search)
                            ),
                            onChanged: c.onSearchUsersTextChanged,
                          ),
                        ):const SizedBox(),
                          PaginatedDataTable(
                            showCheckboxColumn:true,
                            sortColumnIndex: c.currentSortColumn,
                            sortAscending: c.isSortAsc,
                            rowsPerPage: c.rowPer,
                            availableRowsPerPage: const <int>[5,10,15,20],
                            onRowsPerPageChanged: (int? v){
                              c.rowPerPage(v!);
                            },
                            columns: createColumnsUsersDataTable(context),
                            source: RowDataSource(SuperCubit.get(context).filteredDataUsers),
                          ),
                        ],
                      )
                  );
                },
                fallback: (context)=>const Center(child: CircularProgressIndicator(),));
          },
          listener: (context,state){},
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
                  label: 'Add User',
                  backgroundColor: Colors.blue,
                  onTap: () {
                    customBottomSheetCustomUsers(
                        title: 'Add User', isUpdate: false, actionText: 'Save',
                        onTap: (){
                          c.addUser(context);
                        },
                        context: context, isBranch: false
                    );
                  }),
              SpeedDialChild(
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  label: 'Delete Users',
                  backgroundColor: Colors.red.shade400,
                  onTap: () {
                     c.deleteUser(context);
                  }),
              SpeedDialChild(
                  child: const Icon(Icons.edit,color: Colors.white,),
                  label: 'Update User',
                  backgroundColor: Colors.green.shade300,
                  onTap: () {
                     c.updateUser(context);
                  }),
              SpeedDialChild(
                  child: const Icon(Icons.notifications_active,color: Colors.white,),
                  label: 'Send Notification',
                  backgroundColor: Colors.pink.shade300,
                  onTap: () {
                     c.sendNotificationToUsersScreen(context);
                  }),
              SpeedDialChild(
                  child: const Icon(Icons.chat,color: Colors.white,),
                  label: 'Chat User',
                  backgroundColor: Colors.blue.shade300,
                  onTap: () {
                    c.chatToUsers(context);
                  }),
              SpeedDialChild(
                  child: const Icon(Icons.search),
                  label: 'Search User',
                  backgroundColor: Colors.grey.shade200,
                  onTap: () {
                    c.changeSearchUser();
                  }),

            ],
          ),
      ),
    );
  }
}
