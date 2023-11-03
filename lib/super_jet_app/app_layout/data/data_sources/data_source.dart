import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:superjet/core/image/image.dart';
import 'package:superjet/core/widgets/widgets.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/admin_trips_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/admin_users_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/trip_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/update_user_date_model.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/auth/domain/entities/user_entities.dart';
import '../../../../core/shared_preference/shared_preference.dart';
import '../../../auth/data/models/user_model.dart';
import '../models/add_trip_model.dart';
import '../models/categories_model.dart';
import '../models/chairs_model.dart';
import '../models/message_model.dart';

abstract class BaseSuperJetDataSource {
  //Categories
  Future<List<CategoriesModel>> getCategories();
  Future addCategory(CategoriesModel categoriesModel, context);



  //Trips
  Future<List<TripsModel>> getTrips(String city,context);
  Future<List<TripsModelDataTable>> getAllTrips();
  Future<List<TripsModel>> getCustomTrips(String name,context);
  Future addTrips(AddTripModel addTripModel ,context);
  Future deleteTrips(TripsModelDataTable tripsModelDataTable,  context);
  Future updateTrips(TripsModelDataTable tripsModelDataTable, context);


// Cancel trips
  Future cancelTrips(TripsModel tripsModel ,UserModel userModel,String chairID);


//Recycling Trips
  Future recyclingTrip(TripsModelDataTable tripsModelDataTable);
  Future recyclingChairsOfTrip(TripsModelDataTable tripsModelDataTable);

//Change Email
  Future changeEmail(String email ,String id ,String type,context);
  Future changePassword(String password ,String id ,String type,context);


// Admin
  Future<List<UsersTableModel>> getAdmin(context);




//Users
  Future<List<UserModel>> getProfile();
  Future<UpdateUserDataModel?>  upDateProfile(UpdateUserDataModel updateUserDataModel,context);
  Future<List<UsersTableModel>> getUsers();
  Future addUser(UsersTableModel usersTableModel, context);
  Future deleteUser(UsersTableModel usersTableModel, context);
  Future updateUser(UsersTableModel usersTableModel,context);
  void uploadImage(File image, bool isProfile,context);




//Branches
  Future<List<UsersTableModel>> getBranches(context);
  Future addBranch(UsersTableModel usersTableModel, context);
  Future deleteBranch(UsersTableModel usersTableModel, context);
  Future updateBranch(UsersTableModel usersTableModel,context);



//Chairs
  Future<List<ChairsModel>> getChairs(String categoriesID ,String tripsID);


//Chats
  Future<List<MessageModel>> getMessages(UserModel userModelSender ,UsersTableModel userModelReceiver,);
  Future<MessageModel> sendMessages(UserModel userModelSender ,UsersTableModel userModelReceiver,String messageText);

}

class SuperJetDataSource implements BaseSuperJetDataSource {
  final CollectionReference tripsCollection = FirebaseFirestore.instance
      .collection('Trips');


//Categories ****************************************
  @override
  Future<List<CategoriesModel>> getCategories() async {
    QuerySnapshot querySnapshot = await tripsCollection.get();
    List<CategoriesModel> categories = querySnapshot.docs.map((doc) =>
        CategoriesModel.fromJson(doc)).toList();
    return categories;
  }

  @override
  Future addCategory(CategoriesModel categoriesModel, context) async {
    try {
      TripsModel tripsModel = TripsModel(
        name: 'Test Category ${categoriesModel.masterCity} To ${categoriesModel
            .city}',
        price: 'price',
        time: 'time',
        date: 'date',
        avgTime: 'avgTime',
        fromCity: 'fromCity',
        image: 'https://firebasestorage.googleapis.com/v0/b/superjet-52b56.appspot.com/o/a4.jpg?alt=media&token=5e56f739-94f9-4430-90f1-16da294f0696',
        isVip: 'isVip',
        toCity: 'toCity',
        tripID: 'tripID',
        categoryID: 'categoryID',
        categoryName: '${categoriesModel.masterCity.trim()}To${categoriesModel
            .city.trim()}',
        state: 'waiting',
      );
      bool isFound = false;
      var x = FirebaseFirestore.instance.collection('Trips');
      var res = await x.get();
      for (var s in res.docs) {
        if (categoriesModel.categoryName == s.data()['categoryName'] ||
            categoriesModel.categoryName == s.data()['categorySecondName']) {
          isFound = true;
          x.doc(s.id).collection(categoriesModel.categoryName.trim()).add(
              tripsModel.toJson()).then((value) {
            x.doc(s.id).collection(categoriesModel.categoryName.trim()).doc(
                value.id).update(
                {
                  'categoryID': s.id,
                  'tripID': value.id,
                });
          });
          showToast(
              'Successful Add  old Category  ', ToastStates.success, context);
        }
      }
      if (isFound == false) {
        x.add(categoriesModel.toJson()).then((value) =>
        {
          x.doc(value.id).update({
            'categoryID': value.id,
          })
        });
      }
      showToast('Successful Add  new Category', ToastStates.success, context);
    } catch (e) {
      showToast(e.toString(), ToastStates.error, context);
    }
  }


//Trips *********************************************
  @override
  Future<List<TripsModel>> getTrips(String city, context) async {
    List<TripsModel> list = [];
    List<TripsModel> trips = [];
    if (city == 'All') {
      var res = await FirebaseFirestore.instance.collection('Trips').get();
      for (var s in res.docs) {
        var x = await FirebaseFirestore.instance.collection('Trips')
            .doc(s.id)
            .collection(s.data()["categoryName"])
            .get();
        for (var e in x.docs) {
          list.add(TripsModel.fromMapTest(e.data()));
        }
        var x2 = await FirebaseFirestore.instance.collection('Trips')
            .doc(s.id)
            .collection(s.data()["categorySecondName"])
            .get();
        for (var e in x2.docs) {
          list.add(TripsModel.fromMapTest(e.data()));
        }
        // QuerySnapshot querySnapshot = await tripsCollection.doc(s.id)
        //     .collection(s.data()["categoryName"])
        //     .get();
        // trips = querySnapshot.docs.map((e) => TripsModel.fromJson(e)).toList();
        // for (var a in trips) {
        //   list.add(a);
        // }
        // QuerySnapshot querySnapshot2 = await tripsCollection.doc(s.id)
        //     .collection(s.data()["categorySecondName"])
        //     .get();
        // trips = querySnapshot2.docs.map((e) => TripsModel.fromJson(e)).toList();
        // for (var a in trips) {
        //   list.add(a);
        // }
      }
    }
    else {
      var res = await FirebaseFirestore.instance.collection('Trips').get();
      for (var s in res.docs) {
        if (city == s.data()["masterCity"]) {
          QuerySnapshot querySnapshot = await tripsCollection.doc(s.id)
              .collection(s.data()["categoryName"])
              .get();
          trips =
              querySnapshot.docs.map((e) => TripsModel.fromJson(e)).toList();
          for (var a in trips) {
            list.add(a);
          }
        }
        if (city == s.data()["city"]) {
          QuerySnapshot querySnapshot = await tripsCollection.doc(s.id)
              .collection(s.data()["categorySecondName"])
              .get();
          trips =
              querySnapshot.docs.map((e) => TripsModel.fromJson(e)).toList();
          for (var a in trips) {
            list.add(a);
          }
        }
      }
    }
    if (list.isEmpty) {
      showToast('Not Found Trips Now', ToastStates.error, context);
    }
    return list;
  }

  @override
  Future<List<TripsModel>> getCustomTrips(String name, context) async {
    var x = await tripsCollection.get();
    List<TripsModel> list = [];
    List<TripsModel> trips = [];
    for (var n in x.docs) {
      QuerySnapshot querySnapshot = await tripsCollection.doc(n.id).collection(
          name.trim()).get();
      trips = querySnapshot.docs.map((e) => TripsModel.fromJson(e)).toList();
      for (var s in trips) {
        list.add(s);
      }
    }
    if (list.isEmpty) {
      showToast('Not Found Trips Now', ToastStates.error, context);
    }
    return list;
  }

  @override
  Future addTrips(AddTripModel addTripModel, context) async {
    var x = FirebaseFirestore.instance.collection('Trips');
    var res = await x.get();
    try {
      for (var s in res.docs) {
        if (addTripModel.categoryName == s.data()['categoryName'] ||
            addTripModel.categoryName == s.data()['categorySecondName']) {
          TripsModel tripsModel = TripsModel(
            name: addTripModel.name,
            price: addTripModel.price,
            time: addTripModel.time,
            date: addTripModel.date,
            avgTime: '${addTripModel.avgTime} h',
            fromCity: addTripModel.fromCity,
            image: 'https://firebasestorage.googleapis.com/v0/b/superjet-52b56.appspot.com/o/a4.jpg?alt=media&token=5e56f739-94f9-4430-90f1-16da294f0696',
            isVip: addTripModel.isVip,
            toCity: addTripModel.toCity,
            tripID: 'tripID',
            categoryID: s.id,
            categoryName: addTripModel.categoryName.trim(),
            state: 'waiting',
          );
          x.doc(s.id.trim()).collection(addTripModel.categoryName.trim()).add(
            tripsModel.toJson(),
          ).then((value) {
            getChairsData(
                addTripModel.categoryName.trim(), s.id.trim(), value.id.trim());
            x.doc(s.id).collection(addTripModel.categoryName.trim()).doc(
                value.id.trim()).update(
                {
                  'tripID': value.id
                });
          });
          showToast('Successful Add Trips', ToastStates.success, context);
        }
      }
    } catch (e) {
      showToast(e.toString(), ToastStates.error, context);
    }
  }

  @override
  Future deleteTrips(TripsModelDataTable tripsModelDataTable, context) async {
    var x = FirebaseFirestore.instance.collection('Trips');
    var res = await x.get();
    try {
      for (var s in res.docs) {
        if (tripsModelDataTable.categoryName == s.data()['categoryName'] ||
            tripsModelDataTable.categoryName ==
                s.data()['categorySecondName']) {
          DocumentReference documentReference = x.doc(s.id.trim()).collection(
              tripsModelDataTable.categoryName.trim()).doc(
              tripsModelDataTable.tripID.trim());
          x.doc(s.id.trim()).collection(tripsModelDataTable.categoryName.trim())
              .doc(tripsModelDataTable.tripID.trim()).collection('Chairs').get()
              .then((value) {
            for (var s in value.docs) {
              s.reference.delete();
            }
          });
          FirebaseFirestore.instance.runTransaction((transaction) async =>
              transaction.delete(documentReference),
          );

          showToast('Successful Delete Trips ', ToastStates.success, context);
        }
      }
    } catch (e) {
      showToast(e.toString(), ToastStates.error, context);
    }
  }

  @override
  Future updateTrips(TripsModelDataTable tripsModelDataTable, context) async {
    var x = FirebaseFirestore.instance.collection('Trips');
    var res = await x.get();
    try {
      for (var s in res.docs) {
        if (tripsModelDataTable.categoryName == s.data()['categoryName'] ||
            tripsModelDataTable.categoryName ==
                s.data()['categorySecondName']) {
          x.doc(s.id.trim()).collection(tripsModelDataTable.categoryName.trim())
              .doc(tripsModelDataTable.tripID.trim())
              .update(tripsModelDataTable.toJson(),);
          showToast('Successful Update Trips ', ToastStates.success, context);
        }
      }
    } catch (e) {
      showToast(e.toString(), ToastStates.error, context);
    }
  }

  @override
  Future<List<TripsModelDataTable>> getAllTrips() async {
    List<TripsModelDataTable> list = [];
    List<TripsModelDataTable> trips = [];
    var res = await FirebaseFirestore.instance.collection('Trips').get();
    for (var s in res.docs) {
      QuerySnapshot querySnapshot = await tripsCollection.doc(s.id)
          .collection(s.data()["categoryName"])
          .get();
      trips = querySnapshot.docs.map((e) => TripsModelDataTable.fromJson(e))
          .toList();
      for (var a in trips) {
        list.add(a);
      }
      QuerySnapshot querySnapshot2 = await tripsCollection.doc(s.id)
          .collection(s.data()["categorySecondName"])
          .get();
      trips = querySnapshot2.docs.map((e) => TripsModelDataTable.fromJson(e))
          .toList();
      for (var a in trips) {
        list.add(a);
      }
    }
    return list;
  }


//Profile *******************************************
  @override
  Future<List<UserModel>> getProfile() async {
    var uId = await CacheHelper.getDate(key: 'uId');
    var type = await CacheHelper.getDate(key: 'type');
    List<UserModel> listOfData=[];
    var res = await FirebaseFirestore.instance.collection('Accounts')
        .doc('1')
        .collection(type)
        .get();
    for (var e in res.docs) {
      if (e.id == uId) {
        listOfData.add(UserModel.fromJson(e.data()));
        break;
      }
    }
    print('date ============: ${listOfData.toList()}');
    return listOfData;
  }

  @override
  Future<UpdateUserDataModel?> upDateProfile(
      UpdateUserDataModel updateUserDataModel, context) async {
    var uId = await CacheHelper.getDate(key: 'uId');
    var type = await CacheHelper.getDate(key: 'type');
    var res = FirebaseFirestore.instance.collection('Accounts')
        .doc('1').collection(type).doc(uId);
    res.update(updateUserDataModel.toJson());
    return updateUserDataModel;
  }

  @override
  void uploadImage(File image, bool isProfile, context) {
    var cubit = SuperCubit.get(context);
    firebase_storage.FirebaseStorage.instance.ref()
        .child('user/${Uri
        .file(image.path)
        .pathSegments
        .last}')
        .putFile(image).then((value) {
      value.ref.getDownloadURL().then((value) {
        if (isProfile == true) {
          cubit.profileImageFilepath = value;
        } else {
          cubit.coverImageFilepath = value;
        }
      });
    });
  }


//Chairs *************************************************
  @override
  Future<List<ChairsModel>> getChairs(String categoriesID,
      String tripsID) async {
    var res = await FirebaseFirestore.instance.collection('Trips')
        .doc(categoriesID).collection('Trips').doc(tripsID)
        .collection('Chairs')
        .get();
    List<ChairsModel> list = res.docs.map((e) => ChairsModel.fromJson(e.data()))
        .toList();
    return list;
  }


  getChairsData(String categoryName, String categoryID, String tripID) {
    var res = FirebaseFirestore.instance.collection('Trips').doc(categoryID)
        .collection(categoryName)
        .doc(tripID).collection('Chairs');
    res.doc('a1').set(<String, dynamic>{
      'chairID': 1,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",
    });
    res.doc('a2').set(<String, dynamic>{
      'chairID': 2,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('a3').set(<String, dynamic>{
      'chairID': 3,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('a4').set(<String, dynamic>{
      'chairID': 4,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('a5').set(<String, dynamic>{
      'chairID': 5,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('a6').set(<String, dynamic>{
      'chairID': 6,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('a7').set(<String, dynamic>{
      'chairID': 7,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('a8').set(<String, dynamic>{
      'chairID': 8,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('a9').set(<String, dynamic>{
      'chairID': 9,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('b0').set(<String, dynamic>{
      'chairID': 10,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('b1').set(<String, dynamic>{
      'chairID': 11,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('b2').set(<String, dynamic>{
      'chairID': 12,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('b3').set(<String, dynamic>{
      'chairID': 13,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('b4').set(<String, dynamic>{
      'chairID': 14,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('b5').set(<String, dynamic>{
      'chairID': 15,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('b6').set(<String, dynamic>{
      'chairID': 16,
      'passengerID': 'null',
      'isPaid': "false",

      'isAvailable': "true",
    });
    res.doc('b7').set(<String, dynamic>{
      'chairID': 17,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('b8').set(<String, dynamic>{
      'chairID': 18,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('b9').set(<String, dynamic>{
      'chairID': 19,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('c0').set(<String, dynamic>{
      'chairID': 20,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('c1').set(<String, dynamic>{
      'chairID': 21,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('c2').set(<String, dynamic>{
      'chairID': 22,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('c3').set(<String, dynamic>{
      'chairID': 23,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('c4').set(<String, dynamic>{
      'chairID': 24,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('c5').set(<String, dynamic>{
      'chairID': 25,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('c6').set(<String, dynamic>{
      'chairID': 26,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('c7').set(<String, dynamic>{
      'chairID': 27,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('c8').set(<String, dynamic>{
      'chairID': 28,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('c9').set(<String, dynamic>{
      'chairID': 29,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('d0').set(<String, dynamic>{
      'chairID': 30,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('d1').set(<String, dynamic>{
      'chairID': 31,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('d2').set(<String, dynamic>{
      'chairID': 32,
      'passengerID': 'null',
      'isPaid': "false",

      'isAvailable': "true",
    });
    res.doc('d3').set(<String, dynamic>{
      'chairID': 33,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('d4').set(<String, dynamic>{
      'chairID': 34,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('d5').set(<String, dynamic>{
      'chairID': 35,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('d6').set(<String, dynamic>{
      'chairID': 36,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('d7').set(<String, dynamic>{
      'chairID': 37,
      'passengerID': 'null',
      'isPaid': "false",

      'isAvailable': "true",
    });
    res.doc('d8').set(<String, dynamic>{
      'chairID': 38,
      'passengerID': 'null',
      'isPaid': "false",

      'isAvailable': "true",
    });
    res.doc('d9').set(<String, dynamic>{
      'chairID': 39,
      'passengerID': 'null',
      'isPaid': "false",

      'isAvailable': "true",
    });
    /////////////////////////////
    res.doc('e0').set(<String, dynamic>{
      'chairID': 40,
      'passengerID': 'null',
      'isPaid': "false",

      'isAvailable': "true",
    });
    res.doc('e1').set(<String, dynamic>{
      'chairID': 41,
      'passengerID': 'null',
      'isPaid': "false",

      'isAvailable': "true",
    });
    res.doc('e2').set(<String, dynamic>{
      'chairID': 42,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('e3').set(<String, dynamic>{
      'chairID': 43,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('e4').set(<String, dynamic>{
      'chairID': 44,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('e5').set(<String, dynamic>{
      'chairID': 45,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('e6').set(<String, dynamic>{
      'chairID': 46,
      'passengerID': 'null',
      'isPaid': "false",

      'isAvailable': "true",
    });
    res.doc('e7').set(<String, dynamic>{
      'chairID': 47,
      'passengerID': 'null',
      'isPaid': "false",

      'isAvailable': "true",
    });
    res.doc('e8').set(<String, dynamic>{
      'chairID': 48,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('e9').set(<String, dynamic>{
      'chairID': 49,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('f0').set(<String, dynamic>{
      'chairID': 50,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('f1').set(<String, dynamic>{
      'chairID': 51,
      'passengerID': 'null',
      'isPaid': "false",

      'isAvailable': "true",
    });
    res.doc('f2').set(<String, dynamic>{
      'chairID': 52,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",


    });
    res.doc('f3').set(<String, dynamic>{
      'chairID': 53,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",


    });
    res.doc('f4').set(<String, dynamic>{
      'chairID': 54,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('f5').set(<String, dynamic>{
      'chairID': 55,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('f6').set(<String, dynamic>{
      'chairID': 56,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
    res.doc('f7').set(<String, dynamic>{
      'chairID': 57,
      'passengerID': 'null',
      'isPaid': "false",

      'isAvailable': "true",
    });
    res.doc('f8').set(<String, dynamic>{
      'chairID': 58,
      'passengerID': 'null',
      'isAvailable': "true",
      'isPaid': "false",

    });
  }


//Users
  @override
  Future<List<UsersTableModel>> getUsers() async {
    List<UsersTableModel> list = [];
    var res = await FirebaseFirestore.instance.collection('Accounts')
        .doc('1')
        .collection('user')
        .get();
    for (var e in res.docs) {
      list.add(UsersTableModel.fromJson(e.data()));
    }
    return list;
  }


  @override
  Future addUser(UsersTableModel usersTableModel, context) async {
    var token = await CacheHelper.getDate(key: 'token');

    try {
      UserModel userModel = UserModel(
        name: usersTableModel.name,
        email: usersTableModel.email,
        password: usersTableModel.password,
        phone: usersTableModel.phone,
        uId: 'uid',
        city: usersTableModel.city,
        type: 'user',
        tripIdList: [],
        profileImage: AppImage.baseProfileImage,
        coverImage: AppImage.baseCoverImage,
        lat: 'null',
        long: 'null',
        wallet: '0.0', token: token,
      );
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userModel.email,
          password: userModel.password);
      var x = FirebaseFirestore.instance.collection('Accounts')
          .doc('1')
          .collection('user');
      x.add(userModel.toMap())
          .then((value) {
        x.doc(value.id).update({
          'uId': value.id,
        });
      }
      );
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast(
            "The password provided is too weak", ToastStates.error, context);
      } else if (e.code == 'email-already-in-use') {
        showToast(
            "The account already exists for that email", ToastStates.error,
            context);
      }
      else {
        showToast(e.code.toString(), ToastStates.error, context);
      }
    } catch (e) {
      showToast(e.toString(), ToastStates.error, context);
    }
  }

  @override
  Future deleteUser(UsersTableModel usersTableModel, context) async {
    try {
      var x = FirebaseFirestore.instance.collection('Accounts')
          .doc('1')
          .collection('user');
      x.doc(usersTableModel.uId).delete();
    }
    catch (e) {
      showToast(e.toString(), ToastStates.error, context);
    }
  }

  @override
  Future updateUser(UsersTableModel usersTableModel, context) async {
    var token = await CacheHelper.getDate(key: 'token');

    try {
      UserModel userModel = UserModel(
        name: usersTableModel.name,
        email: usersTableModel.email,
        password: usersTableModel.password,
        phone: usersTableModel.phone,
        uId: usersTableModel.uId.trim(),
        city: usersTableModel.city,
        type: 'user',
        tripIdList:usersTableModel.tripIdList,
        profileImage: usersTableModel.profileImage,
        coverImage: AppImage.baseCoverImage,
        lat: usersTableModel.lat,
        long: usersTableModel.long,
        wallet: usersTableModel.wallet, token: token,
      );
      var x = FirebaseFirestore.instance.collection('Accounts')
          .doc('1')
          .collection('user');
      x.doc(userModel.uId).update(userModel.toMap());
    }
    catch (e) {
      print(e.toString());
      showToast(e.toString(), ToastStates.error, context);
    }
  }


//Branch *******************************************************
  @override
  Future addBranch(UsersTableModel usersTableModel, context) async {
    var token = await CacheHelper.getDate(key: 'token');

    try {
      UserModel userModel = UserModel(
        name: usersTableModel.name,
        email: usersTableModel.email,
        password: usersTableModel.password,
        phone: usersTableModel.phone,
        uId: 'uid',
        city: usersTableModel.city,
        type: 'branch',
        tripIdList: [],
        profileImage: AppImage.baseProfileImage,
        coverImage: AppImage.baseCoverImage,
        lat: 'null',
        long: 'null',
        wallet: usersTableModel.wallet,
        token: token,
      );
      var x = FirebaseFirestore.instance.collection('Accounts')
          .doc('1')
          .collection('branch');
      x.add(userModel.toMap())
          .then((value) {
        x.doc(value.id).update({
          'uId': value.id,
        });
      }
      );
    }
    catch (e) {
      showToast(e.toString(), ToastStates.error, context);
    }
  }

  @override
  Future deleteBranch(UsersTableModel usersTableModel, context) async {
    try {
      var x = FirebaseFirestore.instance.collection('Accounts')
          .doc('1')
          .collection('branch');
      x.doc(usersTableModel.uId).delete();
    }
    catch (e) {
      showToast(e.toString(), ToastStates.error, context);
    }
  }

  @override
  Future updateBranch(UsersTableModel usersTableModel, context) async {
    try {
     var token = await CacheHelper.getDate(key: 'token');
      UserModel userModel = UserModel(
        name: usersTableModel.name,
        email: usersTableModel.email,
        password: usersTableModel.password,
        phone: usersTableModel.phone,
        uId: usersTableModel.uId.trim(),
        city: usersTableModel.city,
        type: 'branch',
        tripIdList: usersTableModel.tripIdList!,
        profileImage: AppImage.baseProfileImage,
        coverImage: AppImage.baseCoverImage,
        lat: usersTableModel.lat,
        long: usersTableModel.long,
        wallet: usersTableModel.wallet,
        token: token,
      );
      var x = FirebaseFirestore.instance.collection('Accounts')
          .doc('1')
          .collection('branch');
      x.doc(userModel.uId).update(userModel.toMap());
    }
    catch (e) {
      showToast(e.toString(), ToastStates.error, context);
    }
  }

  @override
  Future<List<UsersTableModel>> getBranches(context) async {
    List<UsersTableModel> list = [];
    var res = await FirebaseFirestore.instance.collection('Accounts')
        .doc('1')
        .collection('branch')
        .get();
    for (var e in res.docs) {
      list.add(UsersTableModel.fromJson(e.data()));
    }
    return list;
  }


//Chat ******************************************************
  @override
  Future<List<MessageModel>> getMessages(UserModel userModelSender,
      UsersTableModel userModelReceiver,) async {
    List<MessageModel> list = [];
    FirebaseFirestore.instance.collection('Accounts').doc('1').collection(
        userModelSender.type).doc(userModelSender.uId)
        .collection('Chat').doc(userModelReceiver.uId).collection('Message')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      list.clear();
      for (var a in event.docs) {
        list.add(MessageModel.fromJson(a.data()));
      }
    });
    return list;
  }

  @override
  Future<MessageModel> sendMessages(UserModel userModelSender,
      UsersTableModel userModelReceiver, String messageText) async {
    List<MessageModel> list = [];
    //send
    MessageModel messageModel = MessageModel(
        dateTime: '${DateTime.now()}',
        receiverId: userModelReceiver.uId.trim(),
        senderId: userModelSender.uId.trim(),
        text: messageText);
    await FirebaseFirestore.instance.collection('Accounts').doc('1').collection(
        userModelReceiver.type.trim()).doc(userModelReceiver.uId.trim())
        .collection('Chat').doc(userModelSender.uId.trim()).collection(
        'Message').add(messageModel.toJson()).then((value) {})
        .catchError((e) {
    });
    //mychat
    await FirebaseFirestore.instance.collection('Accounts').doc('1').collection(
        userModelSender.type.trim()).doc(userModelSender.uId.trim())
        .collection('Chat').doc(userModelReceiver.uId.trim()).collection(
        'Message').add(messageModel.toJson()).then((value) {})
        .catchError((e) {
    });


    return list[0];
  }


//Admin *******************************************************
  @override
  Future<List<UsersTableModel>> getAdmin(context) async {
    List<UsersTableModel> list = [];
    var res = await FirebaseFirestore.instance.collection('Accounts')
        .doc('1')
        .collection('admin')
        .get();
    for (var e in res.docs) {
      list.add(UsersTableModel.fromJson(e.data()));
    }
    return list;
  }

  @override
  Future cancelTrips(TripsModel tripsModel,UserModel userModel, String chairID)async {
    var res = FirebaseFirestore.instance.collection('Trips').doc(tripsModel.categoryID.trim())
        .collection(tripsModel.categoryName.trim()).doc(
        tripsModel.tripID.trim()).collection('Chairs');
       var t =await res.get();
        for(var r in t.docs){
          if(r.data()['chairID'].toString().trim()==chairID.trim()){
            res.doc(r.id).update({
              'isAvailable': 'true',
              'isPaid': 'false',
              'passengerID': 'null',
            });
          }
        }
    List<TripID> list = userModel.tripIdList!;
    var money ="0.0";
    for(var f in list){
      if(f.tripID.trim()==tripsModel.tripID.trim() && f.chairID.toString().trim()==chairID.trim()){
        money=tripsModel.price;
        break;
      }
    }
    list.removeWhere((element) => element.tripID.trim()==tripsModel.tripID.trim() && element.chairID.toString().trim()==chairID.trim());
    var r = FirebaseFirestore.instance.collection('Accounts')
        .doc('1').collection(userModel.type).doc(userModel.uId);
    r.update({
      'trips':List<Map<String, dynamic>>.from(list.map((e) => e.toJson())),
      'wallet':'${double.parse(userModel.wallet)+double.parse(money)}'
    });
  }

  @override
  Future recyclingTrip(TripsModelDataTable tripsModelDataTable)async {
    var x = FirebaseFirestore.instance.collection('Trips').doc(tripsModelDataTable.categoryID.trim())
        .collection(tripsModelDataTable.categoryName.trim()).doc(
        tripsModelDataTable.tripID.trim()).collection('Chairs');
    var res =await x.get();
    for(var a in res.docs){
       x.doc(a.id).update({
         'isAvailable':'true',
         'isPaid':'false',
         'passengerID':'null',
       });
    }
  }

  @override
  Future recyclingChairsOfTrip(TripsModelDataTable tripsModelDataTable)async {
    var x = FirebaseFirestore.instance.collection('Trips').doc(tripsModelDataTable.categoryID.trim())
        .collection(tripsModelDataTable.categoryName.trim()).doc(
        tripsModelDataTable.tripID.trim()).collection('Chairs');
    var res =await x.get();
    for(var a in res.docs){
      if(a.data()['isAvailable']=='true'&&a.data()['isPaid']=='true' ||
          a.data()['isAvailable']=='false'&&a.data()['isPaid']=='false'){
        x.doc(a.id).update({
          'isAvailable':'true',
          'isPaid':'false',
          'passengerID':'null',
        });
      }
    }
  }

  @override
  Future changeEmail(String email ,String id ,String type,context)async {
    try{
      User user =FirebaseAuth.instance.currentUser!;
      user.updateEmail(email.trim()).then((value){
        showToast('Success Update ', ToastStates.success, context);
      });
      var res =  FirebaseFirestore.instance.collection('Accounts')
          .doc('1').collection(type).doc(id);
        res.update({
          'email':email.trim(),
        });
    }catch(e){
      showToast(e.toString(), ToastStates.error, context);
    }
  }

  @override
  Future changePassword(String password, String id, String type, context) async{

    try{
      User user =FirebaseAuth.instance.currentUser!;
      user.updatePassword(password.trim()).then((value){
        showToast('Success Update ', ToastStates.success, context);
      });
      var res =  FirebaseFirestore.instance.collection('Accounts')
          .doc('1').collection(type).doc(id);
      res.update({
        'password':password.trim(),
      });
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
