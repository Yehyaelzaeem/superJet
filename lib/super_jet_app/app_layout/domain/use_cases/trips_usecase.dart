import 'dart:io';

import 'package:superjet/super_jet_app/app_layout/data/models/trip_model.dart';
import '../../../auth/data/models/user_model.dart';
import '../../data/models/admin_trips_model.dart';
import '../../data/models/admin_users_model.dart';
import '../../data/models/categories_model.dart';
import '../../data/models/chairs_model.dart';
import '../../data/models/update_user_date_model.dart';
import '../repositories/base_trips_repo.dart';

class TripsUseCase {
  final BaseTripsRepo baseTripsRepo;

  TripsUseCase(this.baseTripsRepo);

  Future<List<CategoriesModel>> getCategories()async{
    return await baseTripsRepo.getCategories();
  }
   Future<List<TripsModel>> getTrips(String city,context)async{
    return await baseTripsRepo.getTrips(city,context);
  }
  Future<List<TripsModelDataTable>> getAllTrips()async{
    return await baseTripsRepo.getAllTrips();
  }
  Future<List<TripsModel>> getCustomTrips(String name,context)async{
    return await baseTripsRepo.getCustomTrips(name,context);
  }
  Future<UserModel?> getProfile()async{
    return await baseTripsRepo.getProfile();
  }
  Future<List<UsersTableModel>> getUsers()async{
    return await baseTripsRepo.getUsers();
  }

  Future<List<ChairsModel>> getChairs(String categoriesID ,String tripsID)async{
    return await baseTripsRepo.getChairs(categoriesID,tripsID);
  }

  Future<UpdateUserDataModel?>  upDateProfile(UpdateUserDataModel updateUserDataModel,context)async{
    return await baseTripsRepo.upDateProfile(updateUserDataModel,context);
  }
  void uploadImage(File image, bool isProfile,context){
     baseTripsRepo.uploadImage(image, isProfile,context);
  }
}