import 'package:flutter/material.dart';
import '../../../../data/models/admin_users_model.dart';

class RowDataSource extends DataTableSource{
  int selectedCount=0;
  RowDataSource(this.userModelList);
  List<UsersTableModel> userModelList;
  @override
  DataRow? getRow(int index) {
    assert(index >=0);
    if(index>=userModelList.length)return null;
    final UsersTableModel usersTableModel =userModelList[index];
    return DataRow.byIndex(
        index: index,
        selected: usersTableModel.selected,
        onSelectChanged: (bool? v){
          if(usersTableModel.selected != v){
            selectedCount += v! ? 1:-1;
            assert(selectedCount>=0);
            usersTableModel.selected =v;
            notifyListeners();
          }
        },
        cells:
        <DataCell>[
          DataCell(Text(usersTableModel.name)),
          DataCell(Text(usersTableModel.email)),
          DataCell(Text(usersTableModel.phone)),
          DataCell(Text(usersTableModel.uId)),
          DataCell(Text(usersTableModel.city)),
          DataCell(Text(usersTableModel.tripIdList!.length.toString())),
          DataCell(
            CircleAvatar(
              backgroundImage: NetworkImage(usersTableModel.profileImage.toString()),
            )
          ),
        ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => userModelList.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => selectedCount;

}