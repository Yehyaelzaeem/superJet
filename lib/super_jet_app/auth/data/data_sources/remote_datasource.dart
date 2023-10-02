import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:superjet/core/services/routeing_page/reoute.dart';
import 'package:superjet/core/shared_preference/shared_preference.dart';
import 'package:superjet/super_jet_app/auth/data/models/user_model.dart';
import '../../../../core/image/image.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../main.dart';
import '../../presentation/bloc/cubit.dart';
import '../models/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/register_model.dart';

abstract class BaseAuthDataSource{
  Future login(LoginModel loginModel,context);
  Future register(RegisterModel registerModel ,context);
  Future createUserData(UserModel userModel ,context);
}

class AuthDataSource implements BaseAuthDataSource{

  // Login Method
  @override
  Future login(LoginModel loginModel,context) async {
    var type =await CacheHelper.getDate(key: 'type');
    print(type);
    try{
      if(type =='user'){
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: loginModel.email,
            password: loginModel.password).then((value) async{
          var r = await FirebaseFirestore.instance.collection("Accounts").doc('1').collection(type).get();
          for(var n in r.docs){
            if(loginModel.email == n.data()['email']){
              CacheHelper.saveDate(key: "uId", value: n.id);

            }
          }
        });
        NavigatePages.pushReplacePage( const CustomMain(), context);
        CacheHelper.saveDate(key: 'isLog', value: true);
        showToast('Login successful', ToastStates.success, context);
        AuthCubit.get(context).emailLog.clear();
        AuthCubit.get(context).passwordLog.clear();

      } else if(type =='branch'){
        var x =  FirebaseFirestore.instance.collection("Accounts").doc('1').collection(type);
        var r= await x.get();
        for(var n in r.docs){
          if( loginModel.email == n.data()['email']){
            if( loginModel.password ==n.data()['password']){
              CacheHelper.saveDate(key: "uId", value: n.id);
              NavigatePages.pushReplacePage( const CustomMain(), context);
              CacheHelper.saveDate(key: 'isLog', value: true);
              x.doc(n.id).get().then((value) {
                CacheHelper.saveDate(key: 'branchCity', value:value.data()!['city']);
              });
              showToast('Login successful by "$type"', ToastStates.success, context);
              AuthCubit.get(context).emailLog.clear();
              AuthCubit.get(context).passwordLog.clear();
              break;
            }
            else{
              showToast('the password is wrong', ToastStates.error, context);
            }

          }
        }
      }
      else if(type =='admin'){
        var r = await FirebaseFirestore.instance.collection("Accounts").doc('1').collection(type).get();
        for(var n in r.docs){
          if( loginModel.email == n.data()['email']){
            if( loginModel.password ==n.data()['password']){
              CacheHelper.saveDate(key: "uId", value: n.id);
              NavigatePages.pushReplacePage( const CustomMain(), context);
              CacheHelper.saveDate(key: 'isLog', value: true);
              showToast('Login successful by "$type"', ToastStates.success, context);
              AuthCubit.get(context).emailLog.clear();
              AuthCubit.get(context).passwordLog.clear();
            }else{
              showToast('the password is wrong', ToastStates.error, context);
            }
          }
          else{
            showToast('Not found this $type ', ToastStates.error, context);
          }
        }
      }
    }
   on FirebaseAuthException catch(e){
     if (e.code == 'user-not-found') {
       showToast("No user found for that email", ToastStates.error, context);
     } else if (e.code == 'wrong-password') {
       showToast("Wrong password provided for that user", ToastStates.error, context);
     }
     else{
       showToast(e.code.toString(), ToastStates.error, context);
     }
   }catch(e){
     showToast(e.toString(), ToastStates.error, context);
   }
    }

  // Register Method
  @override
  Future register(RegisterModel registerModel ,context)async {
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: registerModel.email,
          password: registerModel.password).then((value)async {
        CacheHelper.saveDate(key: 'uId', value: value.user!.uid);
          var lat =await CacheHelper.getDate(key: 'lat');
           var long =await CacheHelper.getDate(key: 'long');
           var city =await CacheHelper.getDate(key: 'city');
            var type =await CacheHelper.getDate(key: 'type');
          createUserData(
              UserModel(
                name: registerModel.name,
                email: registerModel.email,
                password: registerModel.password,
                phone: registerModel.phone,
                uId: value.user!.uid,
                lat: lat,
                long: long,
                city: city,
                type: type,
                profileImage: AppImage.baseProfileImage,
                coverImage: AppImage.baseCoverImage,
                tripIdList: [],),
              context);
        Navigator.pop(context);
        showToast('Register successful', ToastStates.success, context);
      });
    }
    on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        showToast("The password provided is too weak", ToastStates.error, context);
      } else if (e.code == 'email-already-in-use') {
        showToast("The account already exists for that email", ToastStates.error, context);
      }
      else{
        showToast(e.code.toString(), ToastStates.error, context);
      }
    }catch(e){
      showToast(e.toString(), ToastStates.error, context);
    }
  }

  //Create UserDate In FirebaseFireStore
  @override
  Future createUserData(UserModel userModel, context)async {
   try{
     FirebaseFirestore.instance.collection('Accounts')
         .doc('1')
         .collection(userModel.type!)
         .doc(userModel.uId)
         .set(userModel.toMap());
   }
   catch(e){
     showToast(e.toString(), ToastStates.error, context);

   }
  }
}

