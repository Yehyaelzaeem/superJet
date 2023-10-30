import 'dart:io';

import 'package:superjet/super_jet_app/app_layout/data/models/admin_trips_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/admin_users_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/message_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/trip_model.dart';
import 'package:superjet/super_jet_app/auth/data/models/user_model.dart';
import '../../domain/repositories/base_trips_repo.dart';
import '../data_sources/data_source.dart';
import '../models/add_trip_model.dart';
import '../models/categories_model.dart';
import '../models/chairs_model.dart';
import '../models/update_user_date_model.dart';

class TripsRepo extends BaseTripsRepo{
  final BaseSuperJetDataSource baseSuperJetDataSource;

  TripsRepo(this.baseSuperJetDataSource);

  @override
  Future<List<CategoriesModel>> getCategories() async{
    return await baseSuperJetDataSource.getCategories();
  }

  @override
  Future<List<TripsModel>> getTrips(String city,context) async{
    return await baseSuperJetDataSource.getTrips(city,context);
  }

  @override
  Future<List<UserModel>> getProfile()async {
    return await baseSuperJetDataSource.getProfile();

  }
  @override
  Future<List<ChairsModel>> getChairs(String categoriesID ,String tripsID)async {
    return await baseSuperJetDataSource.getChairs(categoriesID,tripsID);

  }

  @override
  Future<UpdateUserDataModel?>  upDateProfile(UpdateUserDataModel updateUserDataModel,context)async {
    return await baseSuperJetDataSource.upDateProfile(updateUserDataModel,context);

  }

  @override
  Future<List<TripsModel>> getCustomTrips(String name, context) async{
    return await baseSuperJetDataSource.getCustomTrips(name, context);
  }

  @override
  void uploadImage(File image, bool isProfile,context) {
    baseSuperJetDataSource.uploadImage(image, isProfile, context);
  }

  @override
  Future<List<UsersTableModel>> getUsers()async {
    return await baseSuperJetDataSource.getUsers();
  }

  @override
  Future<List<TripsModelDataTable>> getAllTrips() async{
  return await baseSuperJetDataSource.getAllTrips();
  }

  @override
  Future addTrips(AddTripModel addTripModel ,context)async {
  return await baseSuperJetDataSource.addTrips(  addTripModel ,context);
  }

  @override
  Future deleteTrips(TripsModelDataTable tripsModelDataTable, context)async {
   return await baseSuperJetDataSource.deleteTrips(tripsModelDataTable, context);
  }

  @override
  Future updateTrips(TripsModelDataTable tripsModelDataTable, context)async {
    return await baseSuperJetDataSource.updateTrips(tripsModelDataTable, context);

  }

  @override
  Future addUser(UsersTableModel usersTableModel, context) async{
    return await baseSuperJetDataSource.addUser(usersTableModel, context);
  }

  @override
  Future deleteUser(UsersTableModel usersTableModel, context) async{
    return await baseSuperJetDataSource.deleteUser(usersTableModel, context);
  }

  @override
  Future updateUser(UsersTableModel usersTableModel, context) async{
    return await baseSuperJetDataSource.updateUser(usersTableModel, context);
  }

  @override
  Future addCategory(CategoriesModel categoriesModel, context) async{
   return await baseSuperJetDataSource.addCategory(categoriesModel, context);
  }

  @override
  Future addBranch(UsersTableModel usersTableModel, context)async {
  return await baseSuperJetDataSource.addBranch(usersTableModel, context);
  }

  @override
  Future deleteBranch(UsersTableModel usersTableModel, context) async{
    return await baseSuperJetDataSource.deleteBranch(usersTableModel, context);
  }

  @override
  Future updateBranch(UsersTableModel usersTableModel, context)async {
    return await baseSuperJetDataSource.updateBranch(usersTableModel, context);

  }

  @override
  Future<List<UsersTableModel>> getBranches(context)async {
   return await baseSuperJetDataSource.getBranches(context);
  }

  @override
  Future<List<MessageModel>> getMessages(UserModel userModelSender ,UsersTableModel userModelReceiver,) async{
  return await baseSuperJetDataSource.getMessages(userModelSender, userModelReceiver);
  }

  @override
  Future<MessageModel> sendMessages(UserModel userModelSender ,UsersTableModel userModelReceiver,String messageText) async{
    return await baseSuperJetDataSource.sendMessages(userModelSender, userModelReceiver, messageText);

  }

  @override
  Future<List<UsersTableModel>> getAdmin(context) async{
    return await baseSuperJetDataSource.getAdmin(context);
  }


}