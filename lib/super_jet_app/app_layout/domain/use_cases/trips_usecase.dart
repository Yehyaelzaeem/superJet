import 'dart:io';

import 'package:superjet/super_jet_app/app_layout/data/models/trip_model.dart';
import '../../../auth/data/models/user_model.dart';
import '../../data/models/add_trip_model.dart';
import '../../data/models/admin_trips_model.dart';
import '../../data/models/admin_users_model.dart';
import '../../data/models/categories_model.dart';
import '../../data/models/chairs_model.dart';
import '../../data/models/message_model.dart';
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
  Future addTrips(AddTripModel addTripModel,context)async{
    return await baseTripsRepo.addTrips(  addTripModel ,context);
  }
  Future deleteTrips(TripsModelDataTable tripsModelDataTable,context)async{
    return await baseTripsRepo.deleteTrips(tripsModelDataTable,context);
  }
  Future updateTrips(TripsModelDataTable tripsModelDataTable, context)async{
    return await baseTripsRepo.updateTrips(tripsModelDataTable,context);
  }
  Future<List<TripsModel>> getCustomTrips(String name,context)async{
    return await baseTripsRepo.getCustomTrips(name,context);
  }
  Future<List<UserModel>> getProfile()async{
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
  Future addUser(UsersTableModel usersTableModel, context)async{
    return await baseTripsRepo.addUser(usersTableModel, context);

  }
  Future deleteUser(UsersTableModel usersTableModel, context)async{
    return await baseTripsRepo.deleteUser(usersTableModel, context);
  }
  Future updateUser(UsersTableModel usersTableModel, context)async{
    return await baseTripsRepo.updateUser(usersTableModel, context);
  }

  Future addBranch(UsersTableModel usersTableModel, context)async{
    return await baseTripsRepo.addBranch(usersTableModel, context);

  }
  Future deleteBranch(UsersTableModel usersTableModel, context)async{
    return await baseTripsRepo.deleteBranch(usersTableModel, context);
  }
  Future updateBranch(UsersTableModel usersTableModel, context)async{
    return await baseTripsRepo.updateBranch(usersTableModel, context);
  }
  Future addCategory(CategoriesModel categoriesModel, context)async{
    return await baseTripsRepo.addCategory(categoriesModel, context);
  }
  Future<List<UsersTableModel>> getBranches(context)async{
    return await baseTripsRepo.getBranches(context);
  }
  Future<List<MessageModel>> getMessages(UserModel userModelSender ,UsersTableModel userModelReceiver,)async{
    return await baseTripsRepo.getMessages(userModelSender, userModelReceiver);
  }
  Future<MessageModel> sendMessages(UserModel userModelSender ,UsersTableModel userModelReceiver,String messageText)async{
    return await baseTripsRepo.sendMessages(userModelSender, userModelReceiver, messageText);
  }
  Future<List<UsersTableModel>> getAdmin(context)async{
    return await baseTripsRepo.getAdmin(context);
  }


}