import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:superjet/core/widgets/widgets.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/admin_trips_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/admin_users_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/trip_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/update_user_date_model.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import '../../../../core/shared_preference/shared_preference.dart';
import '../../../auth/data/models/user_model.dart';
import '../models/categories_model.dart';
import '../models/chairs_model.dart';

abstract class BaseSuperJetDataSource {
  Future<List<CategoriesModel>> getCategories();
  Future<List<TripsModel>> getTrips(String city,context);
  Future<List<TripsModelDataTable>> getAllTrips();
  Future<List<TripsModel>> getCustomTrips(String name,context);
  Future<UserModel?> getProfile();
  Future<List<UsersTableModel>> getUsers();
  void uploadImage(File image, bool isProfile,context);
  Future<List<ChairsModel>> getChairs(String categoriesID ,String tripsID);
  Future<UpdateUserDataModel?>  upDateProfile(UpdateUserDataModel updateUserDataModel,context);
}

class SuperJetDataSource implements BaseSuperJetDataSource {
  final CollectionReference tripsCollection = FirebaseFirestore.instance.collection('Trips');

  @override
  Future<List<CategoriesModel>> getCategories() async {
    QuerySnapshot querySnapshot = await tripsCollection.get();
    List<CategoriesModel> categories = querySnapshot.docs.map((doc) => CategoriesModel.fromJson(doc)).toList();
    return categories;
  }

  @override
  Future<List<TripsModel>> getTrips(String city, context) async {
    List<TripsModel> list = [];
    List<TripsModel> trips = [];
    if (city == 'All') {
      var res = await FirebaseFirestore.instance.collection('Trips').get();
      for (var s in res.docs) {
        QuerySnapshot querySnapshot = await tripsCollection.doc(s.id)
            .collection(s.data()["categoryName"])
            .get();
        trips = querySnapshot.docs.map((e) => TripsModel.fromJson(e)).toList();
        for (var a in trips) {
          list.add(a);
        }
        QuerySnapshot querySnapshot2 = await tripsCollection.doc(s.id)
            .collection(s.data()["categorySecondName"])
            .get();
        trips = querySnapshot2.docs.map((e) => TripsModel.fromJson(e)).toList();
        for (var a in trips) {
          list.add(a);
        }
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
  Future<UserModel?> getProfile() async {
    var uId = await CacheHelper.getDate(key: 'uId');
    var type = await CacheHelper.getDate(key: 'type');
    UserModel? listOfData;
    var res = await FirebaseFirestore.instance.collection('Accounts').doc('1').collection(type).get();
    for (var e in res.docs) {
      if (e.id == uId) {
        listOfData = UserModel.fromJson(e.data());
      }
    }
    return listOfData;
  }

  @override
  Future<UpdateUserDataModel?> upDateProfile(UpdateUserDataModel updateUserDataModel, context) async {
    var uId = await CacheHelper.getDate(key: 'uId');
    var type = await CacheHelper.getDate(key: 'type');
    var res = FirebaseFirestore.instance.collection('Accounts')
        .doc('1').collection(type).doc(uId);
     res.update(updateUserDataModel.toJson());
    return updateUserDataModel;
  }

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

  @override
  void uploadImage(File image, bool isProfile,context) {
    var cubit =SuperCubit.get(context);
    firebase_storage.FirebaseStorage.instance.ref()
        .child('user/${Uri.file(image.path).pathSegments.last}')
        .putFile(image).then((value){
      value.ref.getDownloadURL().then((value) {
        if(isProfile ==true){
          cubit.profileImageFilepath=value;
          print('this is profile ${cubit.profileImageFilepath}');
        }else{
          cubit.coverImageFilepath=value;
          print(cubit.coverImageFilepath);
        }
      });
    });
  }

  @override
  Future<List<UsersTableModel>> getUsers() async{
    List<UsersTableModel> list=[];
    var res = await FirebaseFirestore.instance.collection('Accounts').doc('1').collection('user').get();
    for (var e in res.docs) {
      list.add(UsersTableModel.fromJson(e.data()));
    }
    return list;
  }

  @override
  Future<List<TripsModelDataTable>> getAllTrips() async{
    List<TripsModelDataTable> list = [];
    List<TripsModelDataTable> trips = [];
    var res = await FirebaseFirestore.instance.collection('Trips').get();
    for (var s in res.docs) {
      QuerySnapshot querySnapshot = await tripsCollection.doc(s.id)
          .collection(s.data()["categoryName"])
          .get();
      trips = querySnapshot.docs.map((e) => TripsModelDataTable.fromJson(e)).toList();
      for (var a in trips) {
        list.add(a);
      }
      QuerySnapshot querySnapshot2 = await tripsCollection.doc(s.id)
          .collection(s.data()["categorySecondName"])
          .get();
      trips = querySnapshot2.docs.map((e) => TripsModelDataTable.fromJson(e)).toList();
      for (var a in trips) {
        list.add(a);
      }
    }
    return list;
  }

}
