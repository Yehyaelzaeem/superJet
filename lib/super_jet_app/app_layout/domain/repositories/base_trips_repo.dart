import 'dart:io';

import 'package:superjet/super_jet_app/app_layout/data/models/admin_trips_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/admin_users_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/chairs_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/trip_model.dart';
import 'package:superjet/super_jet_app/auth/data/models/user_model.dart';
import '../../data/models/add_trip_model.dart';
import '../../data/models/categories_model.dart';
import '../../data/models/message_model.dart';
import '../../data/models/update_user_date_model.dart';

abstract class BaseTripsRepo {
  Future<List<CategoriesModel>> getCategories();
  Future addCategory(CategoriesModel categoriesModel, context);
  Future<List<TripsModel>> getTrips(String city,context);
  Future addTrips(AddTripModel addTripModel, context);
  Future deleteTrips(TripsModelDataTable tripsModelDataTable, context);
  Future updateTrips(TripsModelDataTable tripsModelDataTable, context);
  Future addUser(UsersTableModel usersTableModel, context);
  Future deleteUser(UsersTableModel usersTableModel, context);
  Future updateUser(UsersTableModel usersTableModel, context);
  Future addBranch(UsersTableModel usersTableModel, context);
  Future deleteBranch(UsersTableModel usersTableModel, context);
  Future updateBranch(UsersTableModel usersTableModel, context);
  Future<List<TripsModelDataTable>> getAllTrips();
  Future<List<TripsModel>> getCustomTrips(String name,context);
  Future<UserModel?> getProfile();
  Future<List<UsersTableModel>> getUsers();
  Future<List<UsersTableModel>> getBranches(context);
  Future<UpdateUserDataModel?>  upDateProfile(UpdateUserDataModel updateUserDataModel,context);
  Future<List<ChairsModel>> getChairs(String categoriesID ,String tripsID);
   void uploadImage(File image, bool isProfile,context);
  Future<List<MessageModel>> getMessages(UserModel userModelSender ,UsersTableModel userModelReceiver,);
  Future<MessageModel> sendMessages(UserModel userModelSender ,UsersTableModel userModelReceiver,String messageText);
  Future<List<UsersTableModel>> getAdmin(context);
  Future<List<UserModel>> getUser(context);

}