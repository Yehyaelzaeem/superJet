import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/core/services/routeing_page/routing.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/admin_trips_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/admin_users_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/categories_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/message_model.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/trip_model.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/state.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/admin_screens/admin_notification.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/chat/chat_details.dart';
import 'package:superjet/super_jet_app/auth/data/models/user_model.dart';
import '../../../../core/image/image.dart';
import '../../../../core/shared_preference/shared_preference.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/enums.dart';
import '../../data/models/add_trip_model.dart';
import '../../domain/use_cases/trips_usecase.dart';
import '../widgets/admin.dart';
import 'package:http/http.dart' as http;

class SuperCubit extends Cubit<AppSuperStates> {
  final TripsUseCase tripsUseCase;

  SuperCubit(this.tripsUseCase) : super(AppSuperInitialStates()){
    initialLanguage();
  }
  void initialLanguage()async{
    var lang = await CacheHelper.getDate(key: 'lang');
    lightEn =  lang=='en'?true:false;
    lightAr =  lang=='en'?false:true;
  }
  static SuperCubit get(context) => BlocProvider.of(context);
  bool? lightEn ;
  bool? lightAr ;
  final ScrollController scrollController = ScrollController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerTitleNotification = TextEditingController();
  TextEditingController controllerBodyNotification = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  final searchTripsController = TextEditingController();
  final searchUsersController = TextEditingController();
  final searchBranchController = TextEditingController();
  final addFromCity = TextEditingController();
  final addToCity = TextEditingController();
  final addDate = TextEditingController();
  final addTime = TextEditingController();
  final addPrice = TextEditingController();
  final addAvgTime = TextEditingController();
  final userName = TextEditingController();
  final userEmail = TextEditingController();
  final userPassword = TextEditingController();
  final userPhone = TextEditingController();
  final userCity = TextEditingController();
  final categoryFromControl = TextEditingController();
  final categoryToControl = TextEditingController();
  final chatController = TextEditingController();
  var categoriesIndex = 0;
  List<TripsModel> listCartTrips = [];
  List<int> listOfChats = [];
  List<int> listOfChat = [];
  List<int> listOfChatSetting = [];
  List<String> listOfNameChats = [];
  List chairsId = [];
  List chairsDoc = [];
  double suTotal = 0.0;
  double total = 0.0;
  double tax = 0.0;
  double discount = -0.0;
  bool isPay = false;
  var uId ='' ;



  var type = '';
  File? profileImageFile;
  File? coverImageFile;
  String profileImageFilepath = '';
  String coverImageFilepath = '';
  Locale localeLanguage=Locale(CacheHelper.sharedPreference!.getString('lang').toString());
  changeLanguageApp(codeLang){
    localeLanguage =Locale(codeLang);
    CacheHelper.sharedPreference!.setString('lang', codeLang);
    emit(ChangeLanguage());
  }


  getID() async {
    uId = await CacheHelper.getDate(key: 'uId');
  }
  getType() async {
    type = await CacheHelper.getDate(key: 'type');
  }

//Send Notification
  sendNotification(String title, String body,String type, String token) async {
    await http.post(
      Uri.parse(
        'https://fcm.googleapis.com/fcm/send',
      ),
      headers: <String, String>{
        'Accept':'*/*',
        'Content-Type': 'application/json',
        'Authorization': 'key=${App.notificationServerKey}',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'title': title,
            'body': body,

          },
          "data": {
            'type': type.trim(),
          },
          "android": {
            "priority": "high"
          },
          'to': token
        },
      ),
    );
    controllerTitleNotification.text='';
    controllerBodyNotification.text='';
  }
//setting change Language
  changeLanguageSwitch(bool value){


    lightEn = value;
     lightAr=!value;
     changeLanguageApp('en');
    emit(ChangeLanguage());
  }
  changeLanguageAr(bool value){

    lightAr=value;
    lightEn = !value;
    changeLanguageApp('ar');
    emit(ChangeLanguage());
  }
//remove notification on profile
  removeNotificationListOfChats(){
    listOfChats.clear();
    emit(RemoveNotificationNumber());
  }
  removeNotificationListOfChat(){
    listOfChat.clear();
    emit(RemoveNotificationNumber());
  }
  removeNotificationListOfNameChats(){
    listOfNameChats.clear();
    emit(RemoveNotificationNumber());
  }
  removeNotificationListOfChatSetting(){
    listOfChatSetting.clear();
    emit(RemoveNotificationNumber());
  }


 // Cart ****************************************************************
  addCartTrips(TripsModel tripsModel, String chairId, String chairDoc) {
    listCartTrips.add(tripsModel);
    chairsId.add(chairId);
    chairsDoc.add(chairDoc);
    suTotal += double.parse(tripsModel.price);
    total = suTotal + tax + discount;
    emit(GetCartTrips());
  }
  deleteCartTrips(TripsModel tripsModel, String chairId, String chairDoc) {
    listCartTrips.remove(tripsModel);
    chairsId.remove(chairId);
    chairsDoc.remove(chairDoc);
    suTotal -= double.parse(tripsModel.price);
    total = suTotal + tax + discount;
    total < 0 ? total = 0 : total = total;
    emit(DeleteCartTrips());
  }
  removeCart() {
    listCartTrips.clear();
    chairsDoc.clear();
    chairsId.clear();
    suTotal = 0.0;
    total = 0.0;
    emit(RemoveCartTrips());
  }




// Admin  ****************************************************
  // Control Data Table
  String? btn2SelectedVal;
  bool isSelectedCategory= false;
  String? btn2SelectedVal2;
  int selectedOptionType = 0;
  int selectedOptionState = 2;
  int rowPer = PaginatedDataTable.defaultRowsPerPage;
  int currentSortColumn = 0;
  int currentSortColumnTrips = 0;
  bool isSortAsc = true;
  bool isSortAscTrips = true;
  List<UsersTableModel> usersList = [];
  List<UsersTableModel> adminList = [];
  List<UsersTableModel> branchesList = [];
  List<TripsModelDataTable> tripsList = [];
  rowPerPage(int v) {
    rowPer = v;
    emit(InitGetTable());
  }
  sortingUserDataTable() {
    isSortAsc = !isSortAsc;
    emit(InitGetTable());
  }
  sortingTripsDataTable() {
    isSortAscTrips = !isSortAscTrips;
    emit(InitGetTable());
  }




 // Get Data to Date Table
  getUsers() async {
    var res = await tripsUseCase.getUsers();
    usersList = res;
    filteredDataUsers = res;
    emit(GetUsersDataTable());
  }
  getTrips(context) async {
    var res = await tripsUseCase.getAllTrips();
    tripsList = res;
    filteredDataTrips = res;
    emit(GetAllTripsDataTable());
  }






 // Add Data to Date Table
  addTrips(context) async {
    if(isSelectedCategory ==true && addDate.text.isNotEmpty &&addTime.text.isNotEmpty
        &&addPrice.text.isNotEmpty &&addAvgTime.text.isNotEmpty &&addPrice.text.isNotEmpty)
    {
      try{
        AddTripModel addTripModel = AddTripModel(
          name: '${addFromCity.text} -> ${addToCity.text} ',
          price: addPrice.text,
          time: addTime.text,
          date: addDate.text,
          avgTime: addAvgTime.text,
          fromCity: addFromCity.text,
          image:
          'https://firebasestorage.googleapis.com/v0/b/superjet-52b56.appspot.com/o/a4.jpg?alt=media&token=5e56f739-94f9-4430-90f1-16da294f0696',
          isVip: selectedOptionType == 0 ? 'false' : 'true',
          toCity: addToCity.text,
          categoryName: "${addFromCity.text.trim()}To${addToCity.text.trim()}",
          state: 'waiting',
        );
        await tripsUseCase.addTrips(addTripModel, context);
        tripsList.clear();
        Navigator.pop(context);
        Future.delayed(const Duration(milliseconds: 100)).then((value) {
          getTrips(context);
          addFromCity.clear();
          addToCity.clear();
          addDate.clear();
          addTime.clear();
          addPrice.clear();
          addAvgTime.clear();
          selectedOptionType = 0;
        });
      }catch (e){
        showToast('${e.toString()} , please sure you choose Category Name !!! ', ToastStates.error, context);

      }
    }
    else{
       showToast('Please Complete data', ToastStates.error, context);
    }

    emit(AddTrips());
  }
  addUser(context) async {
    if(userName.text.isNotEmpty &&userEmail.text.isNotEmpty
        &&userPassword.text.isNotEmpty &&userPhone.text.isNotEmpty &&userCity.text.isNotEmpty)
    {
      try{
        UsersTableModel usersTableModel =UsersTableModel(
            name: userName.text.trim(),
            email: userEmail.text.trim(),
            password:userPassword.text.trim(),
            phone:userPhone.text.trim(),
            uId: 'uId',
            city: userCity.text.trim(),
            tripIdList: [],
            profileImage: AppImage.baseProfileImage,
            long: 'null',
            lat: 'null',
            type: 'user',
            token: '',
            wallet: '0.0',
        );
        await tripsUseCase.addUser(usersTableModel, context);
        usersList.clear();
        Navigator.pop(context);
        Future.delayed(const Duration(milliseconds: 100)).then((value) {
          getUsers();
          userName.clear();
          userEmail.clear();
          userPassword.clear();
          userPhone.clear();
          userCity.clear();
        });
      }catch (e){
        showToast('${e.toString()} ', ToastStates.error, context);

      }
    }else{
      showToast(' Please complete data ', ToastStates.warning, context);

    }
    emit(AddUsers());
  }






  // Delete Data from Date Table
  deleteTrip(context) async {
    bool isFoundDelete =false;
    for (var a in filteredDataTrips) {
      if (a.selected == true) {
        await tripsUseCase.deleteTrips(a, context);
        isFoundDelete=true;
      }
    }
   if(isFoundDelete==false){
     showToast('Select your item for delete', ToastStates.warning, context);
   }else{
     tripsList.clear();
     getTrips(context);
   }

    isFoundDelete =false;

    emit(DeleteTrips());
  }
  deleteUser(context) async {
    bool isFoundDelete =false;
    for (var a in filteredDataUsers) {
      if (a.selected == true) {
        await tripsUseCase.deleteUser(a, context);
        isFoundDelete=true;
      }
    }
   if(isFoundDelete==false){
     showToast('Select your item for delete', ToastStates.warning, context);
   }else{
     usersList.clear();
     getUsers();
   }
    getUsers();
    isFoundDelete =false;
    emit(DeleteUsers());
  }






  //Update Data to Date Table
  updateTrip(context) async {
    bool isFoundUpdate =false;
    for (var a in filteredDataTrips) {
      if (a.selected == true) {
        isFoundUpdate=true;
        customBottomSheetCustomTrips(title: "Update", isUpdate: true, actionText: 'Update',
        onTap: ()async {
          await tripsUseCase.updateTrips(
              TripsModelDataTable(
                name: a.name,
                price: addPrice.text,
                time: addTime.text,
                date: addDate.text,
                avgTime: addAvgTime.text,
                fromCity: a.fromCity,
                image: a.image,
                isVip: selectedOptionType == 0 ? 'false' : 'true',
                toCity: a.toCity,
                tripID: a.tripID,
                categoryID: a.categoryID,
                categoryName: a.categoryName,
                state: selectedOptionState == 2 ? 'waiting' : 'finished',
              ),
              context);
          tripsList.clear();
          Navigator.pop(context);
          getTrips(context);
          emit(UpdateTrips());
        },context: context,tripsModelDataTable: a);
        break;
      }
    }

   if(isFoundUpdate==false){
     showToast('Select your item for Update', ToastStates.warning, context);
   }
    isFoundUpdate =false;
    emit(UpdateTrips());
  }
  updateUser(context) async {
    bool isFoundUpdate =false;
    for (var a in filteredDataUsers) {
      if (a.selected == true) {
        isFoundUpdate=true;
        customBottomSheetCustomUsers(title: "Update", isUpdate: true, actionText: 'Update',
        onTap: ()async {
          await tripsUseCase.updateUser(
            UsersTableModel(
                name: userName.text,
                email:a.email.trim(),
                phone: userPhone.text.trim(),
                uId: a.uId.trim(),
                city: userCity.text,
                tripIdList: a.tripIdList,
                profileImage: a.profileImage.trim(),
                password: a.password.trim(),
                long:a.long.trim(),
                lat: a.lat.trim(),
                type: a.type.trim(),
                token: a.token,
                wallet: a.wallet,

            )

              , context);
          usersList.clear();
          Navigator.pop(context);
          getUsers();
        },context: context,usersTableModel: a, isBranch: false);
        break;
      }
    }

   if(isFoundUpdate==false){
     showToast('Select your item for Update', ToastStates.warning, context);
   }
    isFoundUpdate =false;
    emit(UpdateTrips());
  }

  sendNotificationToUsersScreen(context) async {
    bool isFoundUpdate =false;
    for (var a in filteredDataUsers) {
      if (a.selected == true) {
        isFoundUpdate=true;
        NavigatePages.pushToPage(
            AdminNotification(text: 'Send Notification to This User :- \n'
                ' name :${a.name} \n username : ${a.email} \n phone : ${a.phone}', token: a.token.trim()), context);
        break;
      }
    }

    if(isFoundUpdate==false){
      showToast('Select your item for Update', ToastStates.warning, context);
    }
    isFoundUpdate =false;
    emit(SendNotification());
  }

  chatToUsers(context) async {
    bool isFoundUpdate =false;
    for (var a in filteredDataUsers) {
      if (a.selected == true) {
        isFoundUpdate=true;
        NavigatePages.pushToPage(
        ChatDetails(
            userModelReceiver: a,
        ), context);
        break;
      }
    }

    if(isFoundUpdate==false){
      showToast('Select your item for Update', ToastStates.warning, context);
    }
    isFoundUpdate =false;
    emit(SendNotification());
  }


//Payment
  payWallet(context,String total)async{
    getType();
     var d = FirebaseFirestore.instance.collection('Accounts').doc('1').collection(type.trim()).doc(uId.trim());
    var res =await d.get();
    var wallet ='${double.parse(res.data()!['wallet'])-double.parse(total)}';
    for(var i =0;i<=listCartTrips.length-1;i++){
      TripsModel list =listCartTrips[i];
      var chair=chairsId[i];
      var chairId=chairsDoc[i];
      var collectionReference = FirebaseFirestore.instance
          .collection('Trips').doc(list.categoryID.trim())
          .collection(list.categoryName.trim())
          .doc(list.tripID.trim()).collection('Chairs');
      collectionReference.doc(chairId.toString().trim()).update({'isPaid': 'true'});
      d.update({
        'trips':FieldValue.arrayUnion([
          {
            'chairID': int.parse(chair),
            'tripID': list.tripID,
          }
        ]),
        'wallet':wallet,
      });
    }
    removeCart();
    Navigator.pop(context);
    emit(PayByWallet());
  }


//Branches
  getBranches(context) async {
    var res = await tripsUseCase.getBranches(context);
    branchesList = res;
    filteredDataBranches = res;
    emit(GetBranchesDataTable());
  }
  addBranch(context) async {

    if(userName.text.isNotEmpty &&userEmail.text.isNotEmpty
        &&userPassword.text.isNotEmpty &&userPhone.text.isNotEmpty &&userCity.text.isNotEmpty)
    {
      try{
        UsersTableModel usersTableModel =UsersTableModel(
          name: userName.text.trim(),
          email: userEmail.text.trim(),
          password:userPassword.text.trim(),
          phone:userPhone.text.trim(),
          uId: 'uId',
          city: userCity.text.trim(),
          tripIdList: [],
          profileImage: AppImage.baseProfileImage,
          long: 'null',
          lat: 'null',
          type: 'branch',
          token: '',
          wallet: '0.0',
        );
        await tripsUseCase.addBranch(usersTableModel, context);
        branchesList.clear();
        Navigator.pop(context);
        Future.delayed(const Duration(milliseconds: 100)).then((value) {
          getBranches(context);
          userName.clear();
          userEmail.clear();
          userPassword.clear();
          userPhone.clear();
          userCity.clear();
        });
      }catch (e){
        showToast('${e.toString()} ', ToastStates.error, context);
      }
    }else{
      showToast(' Please complete data ', ToastStates.warning, context);

    }
    emit(AddBranchesDataTable());
  }
  deleteBranch(context) async {
    bool isFoundDelete =false;
    for (var a in filteredDataBranches) {
      if (a.selected == true) {
        await tripsUseCase.deleteBranch(a, context);
        isFoundDelete=true;
      }
    }
    if(isFoundDelete==false){
      showToast('Select your item for delete', ToastStates.warning, context);
    }else{
      branchesList.clear();
      getBranches(context);
    }

    isFoundDelete =false;

    emit(DeleteBranchesDataTable());
  }
  updateBranch(context) async {
    bool isFoundUpdate =false;
    for (var a in filteredDataBranches) {
      if (a.selected == true) {
        isFoundUpdate=true;
        customBottomSheetCustomUsers(title: "Update", isUpdate: true, actionText: 'Update',
            onTap: ()async {
              await tripsUseCase.updateBranch(
                  UsersTableModel(
                    name: userName.text.trim(),
                    email:userEmail.text.trim(),
                    phone: userPhone.text.trim(),
                    uId: a.uId,
                    city: userCity.text.trim(),
                    tripIdList: a.tripIdList,
                    profileImage: a.profileImage,
                    password:userPassword.text.trim(),
                    long:a.long,
                    lat: a.lat,
                    type: a.type,
                    token: a.token,
                    wallet: a.wallet,
                  )
                  , context);
              branchesList.clear();
              Navigator.pop(context);
              getBranches(context);
            },context: context,usersTableModel: a, isBranch: true);
        break;
      }
    }

    if(isFoundUpdate==false){
      showToast('Select your item for Update', ToastStates.warning, context);
    }
    isFoundUpdate =false;
    emit(UpdateBranchesDataTable());
  }

//Cancel Booked Trips
  Future cancelBookedTrips(TripsModel tripsModel,UserModel userModel, String chairID)async{
    await tripsUseCase.cancelTrips(tripsModel, userModel, chairID);
    emit(CancelBookedTrips());
  }

//Recycling Trip
  recyclingTrip(context) async {
    bool isFoundUpdate =false;
    for (var a in filteredDataTrips) {
      if (a.selected == true) {
        isFoundUpdate=true;
        await tripsUseCase.recyclingTrip(a);
        showToast('Recycling is success...', ToastStates.success, context);
        break;
      }
    }
    if(isFoundUpdate==false){
      showToast('Select your item for Recycling', ToastStates.warning, context);
    }
    isFoundUpdate =false;
    emit(RecyclingTrips());
  }
  recyclingChairsOfTrip(context) async {
    bool isFoundUpdate =false;
    for (var a in filteredDataTrips) {
      if (a.selected == true) {
        isFoundUpdate=true;
        await tripsUseCase.recyclingChairsOfTrip(a);
        showToast('Recycling Chairs UnAvailable is success...', ToastStates.success, context);
        break;
      }
    }
    if(isFoundUpdate==false){
      showToast('Select your item for Recycling', ToastStates.warning, context);
    }
    isFoundUpdate =false;
    emit(RecyclingTrips());
  }

//Change Email
  changeEmail(String email ,context)async{
    getID();
    getType();
    await tripsUseCase.changeEmail(email,uId,type,context).then((value) {
      controllerName.text='';
      Navigator.pop(context);
    });
    emit(ChangeEmailOrPassword());
  }
  changePassword(String password ,context)async{
    getID();
    getType();
    await tripsUseCase.changePassword(password,uId,type,context).then((value) {
      controllerName.text='';
      Navigator.pop(context);
    });
    emit(ChangeEmailOrPassword());
  }
//Chat
  sendMessage({required UserModel userModelSender ,required UsersTableModel userModelReceiver}) async {
    try{
       sendNotification(userModelSender.name, chatController.text,'chat',userModelReceiver.token,);
      await tripsUseCase.sendMessages(userModelSender,userModelReceiver,chatController.text).then((value) {
        chatController.text='';
      });
    }catch (e){
      print(e.toString());
    }
    emit(SendMessage());
  }
  List<MessageModel> chatDetailsList=[];
  getMessages({required UserModel userModelSender ,required UsersTableModel userModelReceiver})async{
    try{
      chatDetailsList=[];
      var res = await tripsUseCase.getMessages(userModelSender,userModelReceiver);
      chatDetailsList=res;
    }catch (e){
      print(e.toString());
    }
    emit(GetMessage());
  }





  //GetAdmin
  getAdminDate(context)async{
    var res = await tripsUseCase.getAdmin(context);
    adminList = res;
    emit(GetUsersDataTable());
  }




  //Search in Date Table
  bool isSearching=false;
  bool isSearchingUser=false;
  bool isSearchingBranches=false;
  changeSearch(){
    isSearching =!isSearching;
    searchTripsController.text='';
    emit(SearchTrips());
  }
  changeSearchBranches(){
    isSearchingBranches =!isSearchingBranches;
    searchBranchController.text='';
    emit(SearchTrips());
  }
  bool isDark =false;
  changeMode( bool fromShard)async{
    if(fromShard.toString().isNotEmpty){
      isDark=fromShard;
      await CacheHelper.saveDate(key: 'isDark', value: isDark);
      emit(ChangeMode());
    }else{
      isDark =!isDark;
      await CacheHelper.saveDate(key: 'isDark', value: isDark);
      emit(ChangeMode());
    }

  }
  changeSearchUser(){
    isSearchingUser =!isSearchingUser;
    searchUsersController.text='';
    emit(SearchTrips());
  }
  List<TripsModelDataTable> filteredDataTrips = [];
  List<UsersTableModel> filteredDataBranches = [];
  List<UsersTableModel> filteredDataUsers = [];
  void onSearchTripsTextChanged(String text) {
    filteredDataTrips = text.isEmpty
        ? tripsList
        : tripsList
            .where((item) =>
                item.name.toLowerCase().contains(text.toLowerCase()) ||
                item.name.toLowerCase().contains(text.toLowerCase()))
            .toList();
    emit(GetAllTripsDataTable());
  }
  void onSearchUsersTextChanged(String text) {
    filteredDataUsers = text.isEmpty
        ? usersList
        : usersList
            .where((item) =>
                item.name.toLowerCase().contains(text.toLowerCase()) ||
                item.name.toLowerCase().contains(text.toLowerCase()))
            .toList();
    emit(GetUsersDataTable());
  }
  void onSearchBranchesTextChanged(String text) {
    filteredDataBranches = text.isEmpty
        ? branchesList
        : branchesList
            .where((item) =>
                item.name.toLowerCase().contains(text.toLowerCase()) ||
                item.name.toLowerCase().contains(text.toLowerCase()))
            .toList();
    emit(GetUsersDataTable());
  }





//Admin Category control
  //Get Category Name and DropdownMenuItem
  getAdminCategoryName()async{
    var s =await tripsUseCase.getCategories();
    categoriesNameList=s;
    categoriesNameList2=s;
    emit(AddTrips());
  }
  List<CategoriesModel> categoriesNameList=[];
  List<CategoriesModel> categoriesNameList2=[];
  List<DropdownMenuItem<String>> get dropdownItems  {
    List<DropdownMenuItem<String>> menuItems = [];
    for (var x = 0; x <= categoriesNameList.length - 1; x++) {

      menuItems.add(
        DropdownMenuItem(
            value: '$x',
            child: Text(
              categoriesNameList[x].categoryName,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  shadows: [BoxShadow(color: Colors.white54, blurRadius: 1)]),
            )),
      );

    }
    return menuItems;
  }
  List<DropdownMenuItem<String>> get dropdownItems2  {
    List<DropdownMenuItem<String>> menuItems = [];
    for (var x = 0; x <= categoriesNameList2.length - 1; x++) {
      menuItems.add(
        DropdownMenuItem(
            value: '$x',
            child: Text(
              categoriesNameList2[x].categorySecondName,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  shadows: [BoxShadow(color: Colors.white54, blurRadius: 1)]),
            )),
      );

    }
    return menuItems;
  }

  //Add Category
  addCategory(context) async {
    if(categoryFromControl.text.isNotEmpty && categoryToControl.text.isNotEmpty){
      try{
        CategoriesModel categoriesModel =CategoriesModel(
          categoryID: "categoryID",
          image: "https://firebasestorage.googleapis.com/v0/b/superjet-52b56.appspot.com/o/a4.jpg?alt=media&token=5e56f739-94f9-4430-90f1-16da294f0696",
          name: "${categoryFromControl.text.trim()} -> ${categoryToControl.text.trim()}",
          masterCity:categoryFromControl.text.trim(),
          city: categoryToControl.text.trim(),
          categoryName: "${categoryFromControl.text.trim()}To${categoryToControl.text.trim()}",
          categorySecondName:"${categoryToControl.text.trim()}To${categoryFromControl.text.trim()}",
          numberOfTrips: "0",
        );
        await tripsUseCase.addCategory(categoriesModel, context).then((value) {
          getAdminCategoryName();
          Navigator.pop(context);
          categoryFromControl.clear();
          categoryToControl.clear();
        });
      }catch (e){
        showToast('${e.toString()} , please sure you choose Category Name !!! ', ToastStates.error, context);
      }

    }
    else{
      showToast('Please Complete data', ToastStates.warning, context);
    }
    emit(AddCategory());
  }



















// Change Index in App
  changeCategoriesIndex(int i) {
    categoriesIndex = i;
    emit(ChangeCategoriesIndexState());
  }
  bool x = false;
  chickIndex(bool y) {
    x = y;
    emit(ChickChangeCategoriesIndexState());
  }





//Dictionary
//   String selectedValue = "Today";
//
//   changeDropdownValue(String value) {
//     selectedValue = value;
//     emit(ChickChangeCategoriesIndexState());
//   }
//
//   String time = DateFormat("KK:mm a").format(DateTime.now());
//   String timef =
//       DateFormat("KK:mm a").format(DateTime.now().add(Duration(hours: 2)));
//
//   List<String> res = [];
//
//   Future getAllTimeOfTrip(String fromCity, String toCity, context) async {
//     res = ['9:00 am'];
//     emit(ChangeDropdownValueTime());
//     List<TripsModel> list = await tripsUseCase.getTrips(fromCity, context);
//     for (var n in list) {
//       if (n.toCity == toCity) {
//         menuItemsTime.add(
//           DropdownMenuItem(
//               value: n.time,
//               child: Text(
//                 n.time.toString(),
//                 style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     shadows: [BoxShadow(color: Colors.white54, blurRadius: 1)]),
//               )),
//         );
//         res.add(n.time);
//       }
//     }
//     print(res.length);
//     print(res.toString());
//     emit(ChangeDropdownValueTime());
//   }
//
//   List<DropdownMenuItem<String>> menuItemsTime = [];

  // List<DropdownMenuItem<String>> chick(){
  //
  //   for(var x in res){
  //     menuItemsTime.add(
  //       DropdownMenuItem(value: "TimeNow", child: Text(
  //         x.toString(),
  //         style: const TextStyle(
  //             color: Colors.white,
  //             fontSize: 14,
  //             fontWeight: FontWeight.bold,
  //             shadows: [BoxShadow(color: Colors.white54,blurRadius: 1)]
  //         ),
  //       )),);
  //   }
  //  return menuItemsTime;
  // }

//   List<DropdownMenuItem<String>> get dropdownItemsTime {
//     List<DropdownMenuItem<String>> menuItemsTime = [
//       DropdownMenuItem(
//           value: "TimeNow",
//           child: Text(
//             time.toString(),
//             style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 shadows: [BoxShadow(color: Colors.white54, blurRadius: 1)]),
//           )),
//       DropdownMenuItem(
//           value: "Tomorrow",
//           child: Text(
//             time.toString(),
//             style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 shadows: [BoxShadow(color: Colors.white54, blurRadius: 1)]),
//           )),
//       DropdownMenuItem(
//           value: "Next Tomorrow",
//           child: Text(
//             time.toString(),
//             style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 shadows: [BoxShadow(color: Colors.white54, blurRadius: 1)]),
//           )),
//       DropdownMenuItem(
//           value: "Future day1",
//           child: Text(
//             time.toString(),
//             style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 shadows: [BoxShadow(color: Colors.white54, blurRadius: 1)]),
//           )),
//       DropdownMenuItem(
//           value: "Future day2",
//           child: Text(
//             time.toString(),
//             style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 shadows: [BoxShadow(color: Colors.white54, blurRadius: 1)]),
//           )),
//       DropdownMenuItem(
//           value: "Future day3",
//           child: Text(
//             time.toString(),
//             style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 shadows: [BoxShadow(color: Colors.white54, blurRadius: 1)]),
//           )),
//       DropdownMenuItem(
//           value: "Future day4",
//           child: Text(
//             timef.toString(),
//             style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 shadows: [BoxShadow(color: Colors.white54, blurRadius: 1)]),
//           )),
//     ];
//
//     for (var x in res) {
//       menuItemsTime.add(
//         DropdownMenuItem(
//             value: '9:00 am',
//             child: Text(
//               x.toString(),
//               style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   shadows: [BoxShadow(color: Colors.white54, blurRadius: 1)]),
//             )),
//       );
//     }
//     return menuItemsTime;
//   }
//
//   String selectedValueTime = '9:00 am';
//
//   changeDropdownValueTime(String value) {
//     selectedValueTime = value;
//     emit(ChangeDropdownValueTime());
//   }
}
