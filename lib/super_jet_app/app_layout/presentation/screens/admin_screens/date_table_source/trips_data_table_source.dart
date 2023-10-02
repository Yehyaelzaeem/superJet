import 'package:flutter/material.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/admin_trips_model.dart';

class TripsRowDataSource extends DataTableSource{
  int selectedCountTrips=0;

  TripsRowDataSource(this.tripsModelDataTableList);

  List<TripsModelDataTable> tripsModelDataTableList;
  @override
  DataRow? getRow(int index) {
    assert(index >=0);
    if(index>=tripsModelDataTableList.length)return null;
    final TripsModelDataTable tripsModelDataTable =tripsModelDataTableList[index];
    return DataRow.byIndex(
        index: index,
        selected: tripsModelDataTable.selected,
        onSelectChanged: (bool? v){
          if(tripsModelDataTable.selected != v){
            selectedCountTrips += v! ? 1:-1;
            assert(selectedCountTrips>=0);
            tripsModelDataTable.selected =v;
            notifyListeners();
          }
        },
        cells:
        <DataCell>[
          DataCell(Text(tripsModelDataTable.name)),
          DataCell(Text(tripsModelDataTable.date)),
          DataCell(Text(tripsModelDataTable.time)),
          DataCell(Text('${tripsModelDataTable.price} EG')),
          DataCell(Text(tripsModelDataTable.isVip=='true'?'VIP':'Normal')),
          DataCell(Text(tripsModelDataTable.avgTime)),
          DataCell(Text(tripsModelDataTable.fromCity)),
          DataCell(Text(tripsModelDataTable.toCity)),
          DataCell(Text(tripsModelDataTable.tripID)),
          DataCell(Text(tripsModelDataTable.categoryName)),
          DataCell(Text(tripsModelDataTable.categoryID)),
          DataCell(Text(tripsModelDataTable.state)),
          DataCell(CircleAvatar(backgroundImage: NetworkImage(tripsModelDataTable.image.toString()),)),

        ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => tripsModelDataTableList.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => selectedCountTrips;

}