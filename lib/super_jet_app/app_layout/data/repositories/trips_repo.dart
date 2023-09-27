import 'dart:io';

import 'package:superjet/super_jet_app/app_layout/data/models/admin_trips_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/admin_users_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/trip_model.dart';
import 'package:superjet/super_jet_app/auth/data/models/user_model.dart';
import '../../domain/repositories/base_trips_repo.dart';
import '../data_sources/data_source.dart';
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
  Future<UserModel?> getProfile()async {
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
}