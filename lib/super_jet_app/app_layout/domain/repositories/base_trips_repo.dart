import 'dart:io';

import 'package:superjet/super_jet_app/app_layout/data/models/admin_trips_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/admin_users_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/chairs_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/trip_model.dart';
import 'package:superjet/super_jet_app/auth/data/models/user_model.dart';
import '../../data/models/categories_model.dart';
import '../../data/models/update_user_date_model.dart';

abstract class BaseTripsRepo {
  Future<List<CategoriesModel>> getCategories();
  Future<List<TripsModel>> getTrips(String city,context);
  Future<List<TripsModelDataTable>> getAllTrips();
  Future<List<TripsModel>> getCustomTrips(String name,context);
  Future<UserModel?> getProfile();
  Future<List<UsersTableModel>> getUsers();
  Future<UpdateUserDataModel?>  upDateProfile(UpdateUserDataModel updateUserDataModel,context);
  Future<List<ChairsModel>> getChairs(String categoriesID ,String tripsID);
   void uploadImage(File image, bool isProfile,context);
}