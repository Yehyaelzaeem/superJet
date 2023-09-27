import 'package:flutter/material.dart';

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

List<DataColumn> createColumnsTripsDataTable(context) {
  var c =SuperCubit.get(context);
  return [
    DataColumn(label: const Text('Name'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.tripsList.sort((a, b) => b.name.compareTo(a.name));
          } else {
            c.tripsList.sort((a, b) => a.name.compareTo(b.name));
          }
          c.sortingTripsDataTable();
        }
    ),
    DataColumn(label: const Text('Date'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.tripsList.sort((a, b) => b.date.compareTo(a.date));
          } else {
            c.tripsList.sort((a, b) => a.date.compareTo(b.date));
          }
          c.sortingTripsDataTable();
        }
    ),
    DataColumn(label: const Text('Time'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.tripsList.sort((a, b) => b.time.compareTo(a.time));
          } else {
            c.tripsList.sort((a, b) => a.time.compareTo(b.time));
          }
          c.sortingTripsDataTable();
        }
    ),
    DataColumn(label: const Text('Price'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.tripsList.sort((a, b) => b.price.compareTo(a.price));
          } else {
            c.tripsList.sort((a, b) => a.price.compareTo(b.price));
          }
          c.sortingTripsDataTable();
        }
    ),
    const DataColumn(label: Text('Type'),),
    DataColumn(label: const Text('Average Time'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.tripsList.sort((a, b) => b.avgTime.compareTo(a.avgTime));
          } else {
            c.tripsList.sort((a, b) => a.avgTime.compareTo(b.avgTime));
          }
          c.sortingTripsDataTable();
        }
    ),
    DataColumn(label: const Text('From City'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.tripsList.sort((a, b) => b.fromCity.compareTo(a.fromCity));
          } else {
            c.tripsList.sort((a, b) => a.fromCity.compareTo(b.fromCity));
          }
          c.sortingTripsDataTable();
        }
    ),
    DataColumn(label: const Text('To City'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.tripsList.sort((a, b) => b.toCity.compareTo(a.toCity));
          } else {
            c.tripsList.sort((a, b) => a.toCity.compareTo(b.toCity));
          }
          c.sortingTripsDataTable();
        }
    ),
    DataColumn(label: const Text('Trips ID'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.tripsList.sort((a, b) => b.tripID.compareTo(a.tripID));
          } else {
            c.tripsList.sort((a, b) => a.tripID.compareTo(b.tripID));
          }
          c.sortingTripsDataTable();
        }
    ),
    DataColumn(label: const Text('Category Name'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.tripsList.sort((a, b) => b.categoryName.compareTo(a.categoryName));
          } else {
            c.tripsList.sort((a, b) => a.categoryName.compareTo(b.categoryName));
          }
          c.sortingTripsDataTable();
        }
    ),
    DataColumn(label: const Text('Category ID'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.tripsList.sort((a, b) => b.categoryID.compareTo(a.categoryID));
          } else {
            c.tripsList.sort((a, b) => a.categoryID.compareTo(b.categoryID));
          }
          c.sortingTripsDataTable();
        }
    ),
    DataColumn(label: const Text('State'),
        onSort: ( columIndex, x){
          c.currentSortColumnTrips =columIndex;
          if (c.isSortAscTrips) {
            c.tripsList.sort((a, b) => b.state.compareTo(a.state));
          } else {
            c.tripsList.sort((a, b) => a.state.compareTo(b.state));
          }
          c.sortingTripsDataTable();
        }
    ),
    const DataColumn(label: Text('Image'),),
  ];
}
