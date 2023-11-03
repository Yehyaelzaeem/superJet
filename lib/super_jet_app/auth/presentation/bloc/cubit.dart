import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:geolocator/geolocator.dart';
import 'package:superjet/core/widgets/widgets.dart';
import 'package:superjet/super_jet_app/auth/data/models/user_model.dart';
import 'package:superjet/super_jet_app/auth/presentation/bloc/states.dart';
import '../../../../core/image/image.dart';
import '../../../../core/shared_preference/shared_preference.dart';
import '../../../../main.dart';
import '../../data/models/login_model.dart';
import '../../data/models/register_model.dart';
import '../../domain/use_cases/auth_usecase.dart';
class AuthCubit extends Cubit<AppAuthStates>{
  final AuthUseCase authUseCase;
  AuthCubit(this.authUseCase) : super(AppAuthInitialStates());

  static AuthCubit get(context)=>BlocProvider.of(context);
  var formKey =GlobalKey<FormState>();
  var registerFormKey =GlobalKey<FormState>();
  var updateFormKey =GlobalKey<FormState>();
  var changeFormKey =GlobalKey<FormState>();
  List<LoginModel> listLoginModel=[];
  TextEditingController emailLog =TextEditingController();
  TextEditingController passwordLog =TextEditingController();
  TextEditingController name =TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();
  TextEditingController confirmPassword =TextEditingController();
  TextEditingController phone =TextEditingController();
  TextEditingController resetPasswordController =TextEditingController();

  bool isEye=false;
  bool isEyePassword=false;
  bool isEyeConPassword=false;
  bool isNotLoading=true;
  bool isNotLoading2=true;
  bool x=false;
  bool y=false;
  RegisterModel? registerModel;
  RegisterModel? updateProfileModel;

  //Get Permission To GetLocation
  Future getPermission()async{
    bool service;
    LocationPermission permission;
    service =await Geolocator.isLocationServiceEnabled();
    if(service ==false){
    }
    permission =await Geolocator.checkPermission();
    if(permission ==LocationPermission.denied){
      permission =await Geolocator.requestPermission();
    }
    Position p ;
    p=await Geolocator.getCurrentPosition().then((value) => value);
    List<Placemark> place= await placemarkFromCoordinates( p.latitude,p.longitude);
    CacheHelper.saveDate(key: 'lat', value:  p.latitude.toString());
    CacheHelper.saveDate(key: 'long', value:  p.longitude.toString());
    CacheHelper.saveDate(key: 'city', value:  place[0].administrativeArea);
    emit(GetPermissionStates());
    return permission;
  }


  //Login
  Future login(String email,String password,context)async{
    isNotLoading =false;
    emit(LoginGetDataModelStates());
    await authUseCase.login(LoginModel(email: email, password: password),context);
    await FirebaseMessaging.instance.subscribeToTopic('usersSuperJet');
    isNotLoading =true;
    emit(LoginGetDataModelStates());
  }
  //Register
  Future register(String name, String phone, String email, String password,context)async
  {
    isNotLoading2 =false;
    emit(RegisterWaitingStates());
    await authUseCase.register(
        RegisterModel(name: name, phone: phone, email: email, password: password ),context);
    isNotLoading2 =true;
    emit(RegisterWaitingStates());
  }
  var type='';
  var city='';
  getType()async{
    type =await CacheHelper.getDate(key: 'type');
    city =await CacheHelper.getDate(key: 'branchCity')??'';
    isKnowType =type;
  }
  //Chick this person is user or admin
   Future chickUsers(String type)async{
     await CacheHelper.saveDate(key: 'type', value: type);
     emit(ChickUsersStates());
   }

  //ResetPassword When Forget Password
  Future resetPassword(String email,context)async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim()).then((value)
      {
        showToast('Chick your mail', ToastStates.warning, context);
        Navigator.pop(context);
      });
    }
    catch(e){
      showToast(e.toString(), ToastStates.warning, context);
    }
    emit(ResetPasswordStates());

  }

  // Login with GoogleAccount
  Future loginWithGoogle(context)async {
    var lat =await CacheHelper.getDate(key: 'lat');
    var long =await CacheHelper.getDate(key: 'long');
    var city =await CacheHelper.getDate(key: 'city');
    var type =await CacheHelper.getDate(key: 'type');
    var token =await CacheHelper.getDate(key: 'token');
    UserCredential us = await signInWithGoogle(context);
    CacheHelper.saveDate(key: 'isLog', value: true);
    CacheHelper.saveDate(key: 'uId', value: us.user!.uid);
    var r = await FirebaseFirestore.instance.collection("Accounts").doc('1').collection(type).get();
     bool isFound=false;
    for(var n in r.docs){
      if(us.user!.email.toString() == n.data()['email']){
        CacheHelper.saveDate(key: "uId", value: n.id);
        isFound =true;
        break;
      }
    }
    if(isFound ==false){
      await  authUseCase.createUserData(
          UserModel(
            name: us.user!.displayName.toString(),
            email:  us.user!.email.toString(),
            password: '*********',
            phone: (us.user!.phoneNumber) ?? 'null',
            uId:  us.user!.uid,
            lat: lat??'null',
            long: long??'null',
            city: city??'null',
            type: type,
            profileImage: (us.user!.photoURL.toString()),
            coverImage:AppImage.baseCoverImage,
            tripIdList: [],
            wallet: '0.0',
            token: token,
          ), context);
    }
    await FirebaseMessaging.instance.subscribeToTopic('usersSuperJet');
    emit(LoginGoogleStates());
  }

var isKnowType = '';
  // Follow Login with GoogleAccount
  Future<UserCredential> signInWithGoogle(context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseMessaging.instance.subscribeToTopic('usersSuperJet');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const CustomMain()));
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  //some method follow TextField
  void changeEyePassword(){
    isEye =!isEye;
    emit(ChangeEyePasswordStates());
  }
  void changeEyePasswordRegister(){
    isEyePassword =!isEyePassword;
    emit(ChangeEyePasswordStates());
  }
  void changeEyeConPasswordRegister(){
    isEyeConPassword =!isEyeConPassword;
    emit(ChangeEyePasswordStates());
  }

}