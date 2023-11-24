import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../widgets/admin.dart';
import 'date_table_source/branch_table_source.dart';
import 'date_table_source/users_data_table_source.dart';

class BranchesDateTableScreen extends StatelessWidget {
  const BranchesDateTableScreen({super.key});

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
                condition: SuperCubit.get(context).branchesList.isNotEmpty,
                builder: (BuildContext context){
                  return SingleChildScrollView(
                      child: Column(
                        children: [
                           Padding(
                            padding:
                            const EdgeInsets.only(top: 20.0, bottom: 5, left: 0),
                            child: Text(
                              'Branches Data',
                              style: Theme.of(context).textTheme.titleMedium
                            ),
                          ),
                          c.isSearchingBranches == true
                              ?   Padding(
                            padding: const EdgeInsets.only(left: 20.0,right: 20,top: 35),
                            child: TextField(
                              controller: c.searchBranchController,
                              decoration: const InputDecoration(
                                  hintText: 'Search...',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.search)
                              ),
                              onChanged: c.onSearchBranchesTextChanged,
                            ),
                          ):const SizedBox(),
                          PaginatedDataTable(
                            sortColumnIndex: c.currentSortColumn,
                            sortAscending: c.isSortAsc,
                            rowsPerPage: c.rowPer,
                            availableRowsPerPage: const <int>[5,10,15,20],
                            onRowsPerPageChanged: (int? v){
                              c.rowPerPage(v!);
                            },
                            columns: createColumnsBranchesDataTable(context),
                            source: BranchesRowDataSource(SuperCubit.get(context).filteredDataBranches),
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
                label: 'Add Branch',
                backgroundColor: Colors.blue,
                onTap: () {
                  customBottomSheetCustomUsers(
                      title: 'Add Branch', isUpdate: false, actionText: 'Save',
                      onTap: (){
                        c.addBranch(context);
                      },
                      context: context, isBranch: true
                  );
                }),
            SpeedDialChild(
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                label: 'Delete Branches',
                backgroundColor: Colors.red.shade400,
                onTap: () {
                  c.deleteBranch(context);
                }),
            SpeedDialChild(
                child: const Icon(Icons.edit,color: Colors.white,),
                label: 'Update Branch',
                backgroundColor: Colors.green.shade300,
                onTap: () {
                  c.updateBranch(context);
                }),
            SpeedDialChild(
                child: const Icon(Icons.search),
                label: 'Search Branch',
                backgroundColor: Colors.grey.shade200,
                onTap: () {
                  c.changeSearchBranches();
                }),

          ],
        ),
      ),
    );
  }
}
