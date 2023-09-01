
part of 'trips_bloc.dart';



class TripsState  {
  final List<CategoriesModel> categoriesModelList;
  final List<TripsModel> tripsModelList;
  final List<TripsModel> customFromTripsModelList;
  final List<TripsModel> customToTripsModelList;
  final List<TripsModel> currentTripsModelList;
  final List<ChairsModel> currentOneChairList;
  final RequestState currentTripsState;
  final RequestState currentOneChairState;
  final RequestState tripsState;
  final RequestState tripsCustomFromState;
  final RequestState tripsCustomToState;
  final RequestState categoriesState;
  final UserModel? userModel ;
  final UpdateUserDataModel? updateUserDataModel ;
  final RequestState userModelState;
  final RequestState updateUserDataModelState;
  final File? profileImageFile ;
  final File? coverImageFile ;
  final bool isUpdating;
  final List<ChairsModel> chairsModel;
  final RequestState chairsModelState;



  TripsState({
    this.tripsModelList=const[],
    this.customFromTripsModelList=const[],
    this.customToTripsModelList=const[],
    this.currentTripsModelList=const[],
    this.currentOneChairList=const[],
    this.currentTripsState=RequestState.loading,
    this.currentOneChairState=RequestState.loading,
    this.tripsState=RequestState.loading,
    this.tripsCustomFromState=RequestState.loading,
    this.tripsCustomToState=RequestState.loading,
    this.categoriesModelList =const [],
    this.categoriesState=RequestState.loading,
    this.userModelState=RequestState.loading,
    this.updateUserDataModelState=RequestState.loading,
    this.updateUserDataModel,
    this.userModel,
    this.profileImageFile,
    this.coverImageFile,
    this.chairsModel=const[],
    this.chairsModelState=RequestState.loading,
    this.isUpdating=false,
  });


  TripsState copyWith({List<CategoriesModel>? categoriesModelList,
    List<TripsModel>? tripsModelList,
    List<TripsModel>? customFromTripsModelList,
    List<TripsModel>? customToTripsModelList,
    List<TripsModel>? currentTripsModelList,
    List<ChairsModel>? currentOneChairList,
    RequestState? currentTripsState,
    RequestState? currentOneChairState,
    RequestState? tripsState,
    RequestState? tripsCustomFromState,
    RequestState? tripsCustomToState,
    RequestState? categoriesState,
    final RequestState? userModelState,
    final RequestState? updateUserDataModelState,
    final UserModel? userModel,
    final UpdateUserDataModel? updateUserDataModel,
    final List<ChairsModel>? chairsModel,
    final RequestState? chairsModelState,
    final File? profileImageFile,
    final File? coverImageFile,
    final bool? isUpdating,

  })
  {
    return TripsState(
        categoriesModelList: categoriesModelList ?? this.categoriesModelList,
        tripsModelList : tripsModelList ?? this.tripsModelList,
        customFromTripsModelList : customFromTripsModelList ?? this.customFromTripsModelList,
        customToTripsModelList : customToTripsModelList ?? this.customToTripsModelList,
        currentTripsModelList : currentTripsModelList ?? this.currentTripsModelList,
        currentOneChairList : currentOneChairList ?? this.currentOneChairList,
        currentOneChairState : currentOneChairState ?? this.currentOneChairState,
        tripsState : tripsState ?? this.tripsState,
        currentTripsState : currentTripsState ?? this.currentTripsState,
        tripsCustomFromState : tripsCustomFromState ?? this.tripsCustomFromState,
        tripsCustomToState : tripsCustomToState ?? this.tripsCustomToState,
        categoriesState : categoriesState ?? this.categoriesState,
        userModelState : userModelState ?? this.userModelState,
        updateUserDataModelState : updateUserDataModelState ?? this.updateUserDataModelState,
        userModel: userModel ?? this.userModel,
        updateUserDataModel: updateUserDataModel ?? this.updateUserDataModel,
        coverImageFile: coverImageFile ?? this.coverImageFile,
        profileImageFile: profileImageFile ?? this.profileImageFile,
        chairsModel: chairsModel ?? this.chairsModel,
        chairsModelState: chairsModelState ?? this.chairsModelState,
        isUpdating:isUpdating??this.isUpdating,

    );
  }



}

