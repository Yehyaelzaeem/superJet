import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:superjet/core/shared_preference/shared_preference.dart';
import 'package:superjet/core/utils/enums.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/trip_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/update_user_date_model.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/auth/domain/entities/user_entities.dart';
import '../../../auth/data/models/user_model.dart';
import '../../data/models/categories_model.dart';
import '../../data/models/chairs_model.dart';
import '../../domain/use_cases/trips_usecase.dart';
part 'trips_event.dart';
part 'trips_state.dart';

class TripsBloc extends Bloc<TripsEvent, TripsState> {
   final TripsUseCase tripsUseCase;
  TripsBloc(this.tripsUseCase) : super(TripsState()) {

    //GetCategories
    on<GetCategoriesTripsEvent>((event, emit) async{
       final res = await tripsUseCase.getCategories();
       emit(state.copyWith(categoriesState: RequestState.loaded ,categoriesModelList: res));
    });


    //Trips
    on<GetTripsEvent>((event, emit) async{
       final res = await tripsUseCase.getTrips(event.city,event.context);
       emit(
           state.copyWith(tripsState: RequestState.loaded ,tripsModelList: res));
    });


    //CurrentTrips
    on<GetCurrentTripsEvent>((event, emit) async{
      List<TripsModel> list=[];
      try{
        final res = await tripsUseCase.getTrips('All',event.context);
        for(var x in event.tripId){
          for(var n in res){
            if(n.tripID.trim()==x.tripID.trim()){
              list.add(n);
            }
          }
        }
      }catch(e){
        print(e.toString());
      }
      list=list.reversed.toList();
      emit(state.copyWith(currentTripsState: RequestState.loaded , currentTripsModelList: list));
    });


    //GetCustomFromTrips
    on<GetCustomFromTripsEvent>((event, emit) async{
       final res = await tripsUseCase.getCustomTrips(event.name,event.context);
      emit(state.copyWith(
          tripsCustomFromState: RequestState.loaded ,
          customFromTripsModelList:res,
      ));
    });


    //GetCustomToTrips
    on<GetCustomToTripsEvent>((event, emit) async{
       final res = await tripsUseCase.getCustomTrips(event.name,event.context);
      emit(state.copyWith(
          tripsCustomToState: RequestState.loaded,
          customToTripsModelList:res,

      ));
    });
    on<GetTestTripsEvent>((event, emit) async{
      emit(state.copyWith(
          tripsCustomToState: RequestState.loading,
          tripsCustomFromState: RequestState.loading,
      ));
    });


    //GetProfile
    on<GetProfileEvent>((event, emit,) async{
      final res = await tripsUseCase.getProfile();
      emit(state.copyWith(userModelState: RequestState.loaded ,userModel: res));
    });


    //SignOut
    on<SignOutEvent>((event, emit,) async{
      await FirebaseAuth.instance.signOut();
      CacheHelper.removeData(key: 'isLog');
      CacheHelper.removeData(key: 'uId');
       emit(state.copyWith());
    });



    //Update image cover picker
    on<EditCoverImageEvent>((event, emit,) async{
      var cubit = SuperCubit.get(event.context);
      var picker =ImagePicker();
      final image =await picker.pickImage(source: ImageSource.gallery);
      if(image !=null){
        cubit.coverImageFile=File(image.path);
        tripsUseCase.uploadImage(cubit.coverImageFile!,false,event.context);
      }
      else{
      }
    emit(state.copyWith(coverImageFile: cubit.coverImageFile));
    });


    //Update image profile picker
    on<EditProfileImageEvent>((event, emit,) async{
      var cubit = SuperCubit.get(event.context);

      var picker1 =ImagePicker();
      final image1 =await picker1.pickImage(source: ImageSource.gallery);
      if(image1 !=null){
        cubit.profileImageFile=File(image1.path);
       tripsUseCase.uploadImage(cubit.profileImageFile!,true,event.context);
      }
      else{
      }
      emit(state.copyWith(profileImageFile:cubit.profileImageFile));
    });
/*
    UserModel(
           name: controllerName.text.isNotEmpty?controllerName.text: state.userModel!.name,
           email: state.userModel!.email,
           password:state.userModel!.password,
           phone: controllerPhone.text.isNotEmpty?controllerPhone.text:state.userModel!.phone,
           uId: state.userModel!.uId,
           lat: state.userModel!.lat,
           long: state.userModel!.long,
           city: state.userModel!.city,
           type: state.userModel!.type,
           profileImage: profileImageFilepath??state.userModel!.profileImage,
           coverImage: coverImageFilepath??state.userModel!.coverImage,
          );
 */
    //Update profile
    on<UpdateProfileEvent>((event, emit,) async{
      UpdateUserDataModel updateUserDataModel =UpdateUserDataModel(
          name:event.name.isNotEmpty?event.name:event.subName,
          phone: event.phone.isNotEmpty?event.phone:event.subPhone,
          profileImage: event.profileImage.isNotEmpty?event.profileImage:event.subProfileImage,
          coverImage: event.coverImage.isNotEmpty?event.coverImage:event.subCoverImage,
      );
      var res =await tripsUseCase.upDateProfile(updateUserDataModel,event.context);
      emit(state.copyWith(updateUserDataModel:res ,
          updateUserDataModelState: RequestState.loaded,
          isUpdating: false));
    });

    on<IsUpdatingEvent>((event, emit,) async{
      emit(state.copyWith(isUpdating: event.x));
    });
  }

}

