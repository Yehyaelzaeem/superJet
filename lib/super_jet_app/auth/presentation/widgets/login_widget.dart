import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:superjet/super_jet_app/auth/presentation/widgets/widget.dart';
import '../../../../core/global/localization/appLocale.dart';
import '../../../../core/image/image.dart';
import '../../../../core/services/routeing_page/routing.dart';
import '../../../../core/utils/enums.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';
import '../screens/register.dart';
import '../screens/reset_password.dart';


Future<String?> customDialogPopScope(context){
  final isDarkModel =Theme.of(context).brightness;
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Are You Sure ?"),
        titleTextStyle:  TextStyle(
            fontWeight: FontWeight.bold,
            color: isDarkModel==Brightness.dark?Colors.white:Colors.black54,
            fontSize: 20),
        actionsOverflowButtonSpacing: 20,
        actions: [
          MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Theme.of(context).primaryColor,
              child:  Text("Back",
              style: TextStyle(
                color:  isDarkModel==Brightness.dark?Colors.black54:Colors.white70,
              ),
              )),
          MaterialButton(
              onPressed: () {
                exit(0);
              },
              color: Theme.of(context).primaryColor,
              child:  Text("Yes",
                style: TextStyle(
                  color:  isDarkModel==Brightness.dark?Colors.black54:Colors.white70,
                ),
              )),
        ],
        content:  Text("Want to close the app",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color:  isDarkModel==Brightness.dark?Colors.grey.shade200:Colors.grey,
          ),
        ),
      ));
}


Widget customLoginDesign(var type ,context){
  var h= MediaQuery.of(context).size.height;
  var w= MediaQuery.of(context).size.width;
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: h*.2,),
        customWidgetsLogin(type,context),
        SizedBox(height: h*.04,),
        type=='user'? Padding(
          padding: const EdgeInsets.only(left: 28.0,right: 28),
          child: Row(
            children: [
              const Expanded(child: Divider(thickness: 2,)),
              SizedBox(width: w*.02,),
               Text('${AppLocale.of(context).getTranslated('signInWith')}',
                style: const TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(width: w*.02,),
              const Expanded(child: Divider(thickness: 2,)),
            ],
          ),
        ):const SizedBox(),
        SizedBox(height: w*.01,),
        type=='user'? customAccountsIcons(context):const SizedBox(),
      ],
    ),
  );

}

Widget customWidgetsLogin(var type,context){
  var m =MediaQuery.of(context).size;
  final isDarkMode = Theme.of(context).brightness;

  return Container(
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black54,blurRadius: 20)]
    ),
    alignment: Alignment.center,
    height: 465,
    width: m.width*0.89,
    child:  Padding(
      padding: const EdgeInsets.only(left: 22.0,right: 22),
      child:
      Form(
        key: AuthCubit.get(context).formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            type=='user'? SizedBox(height:m.height*.04,):SizedBox(height:m.height*.07,),
            customTitleScreen('${AppLocale.of(context).getTranslated('signIn')}',Colors.black),
            SizedBox(height:m.height*.06,),
            Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20))
                ),
                child:
                customTextField(
                  isPassword: false,
                  context: context,
                  keyboardType:TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value){
                        if(value!.isEmpty){
                          }
                          return null;
                  },
                  textColor: isDarkMode==Brightness.dark? Colors.black:Colors.white,
                  hintTextColor:  isDarkMode==Brightness.dark? Colors.black45:Colors.white70,
                  colorIcon:isDarkMode==Brightness.dark? Colors.black45:Colors.white70,
                  controller: AuthCubit.get(context).emailLog,
                  hintText: '${AppLocale.of(context).getTranslated('usernameHintText')}',
                  iconData:  Icons.person,

                  obscureText: false,
                ),),
            type=='user'? SizedBox(height:m.height*.03,):SizedBox(height:m.height*.04,),
            BlocConsumer<AuthCubit,AppAuthStates>(
              builder: (context,state){
                return   Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                  child:
                  customTextField(
                      textColor: isDarkMode==Brightness.dark? Colors.black:Colors.white,
                      hintTextColor:  isDarkMode==Brightness.dark? Colors.black45:Colors.white70,
                      colorIcon:isDarkMode==Brightness.dark? Colors.black45:Colors.white70,
                      isPassword: true,
                      context: context,
                      keyboardType:TextInputType.text,
                      textInputAction: TextInputAction.done,
                      validator: (value){
                        if(value!.isEmpty){
                        }
                        return null;
                      },
                      controller: AuthCubit.get(context).passwordLog,
                      hintText: '${AppLocale.of(context).getTranslated('passwordHintText')}',
                      iconData: Icons.lock,
                      obscureText: !AuthCubit.get(context).isEye,
                      suffixIcon:
                      IconButton(onPressed: (){AuthCubit.get(context).changeEyePassword();}, icon:
                      Icon(AuthCubit.get(context).isEye==false ?
                      Icons.visibility_off: Icons.visibility,
                          color:
                          isDarkMode==Brightness.dark?
                          (AuthCubit.get(context).isEye==false ?
                          Colors.black45:Colors.white70):
                          (AuthCubit.get(context).isEye==false ?
                          Colors.white:Colors.grey.shade300)) ,),
                      onFieldSubmitted:
                          (value){
                        if(AuthCubit.get(context).formKey.currentState!.validate() ){
                          AuthCubit.get(context).login(AuthCubit.get(context).emailLog.text, AuthCubit.get(context).passwordLog.text,context);
                        }}
                  ),
                );
              },
              listener: (context,state){},
            ),
            type=='user'? Container(
                alignment: Alignment.topRight,
                child: TextButton(onPressed: (){
                 NavigatePages.pushToPage(const ResetPassword(), context);
                }, child:  Text('${AppLocale.of(context).getTranslated('forgetPassword')}',
                  style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.w800),
                ))):const SizedBox(),
            type=='user'?SizedBox(height: m.height*.04,):SizedBox(height: m.height*.09,),
            BlocConsumer<AuthCubit,AppAuthStates>(
                builder: (context,state)=>
                    ConditionalBuilder(
                      condition: AuthCubit.get(context).isNotLoading,
                      builder: (context)=>
                          customAuthButton(context, 0.38, '${getLang(context,'login')}', () {
                            var c =AuthCubit.get(context);
                            if(c.emailLog.text.isEmpty||c.passwordLog.text.isEmpty){
                              showToast('${getLang(context, 'emailOrPasswordIsEmpty')}', ToastStates.warning, context);
                            }else{
                              if(AuthCubit.get(context).formKey.currentState!.validate() ){
                                AuthCubit.get(context).login(AuthCubit.get(context).emailLog.text, AuthCubit.get(context).passwordLog.text,context);}
                            }
                          },
                          isDarkMode==Brightness.dark?Colors.black45:Colors.white
                          ),
                      fallback: (context)=> Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),),
                    ), listener: (context,state){}),
            const Spacer(),
            type=='user'? FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text( '${getLang(context,'haveAccount?')}',
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade600),
                  ),
                  TextButton(onPressed: (){
                    NavigatePages.pushToPage(const Register(), context);
                  }, child:  Text( '${getLang(context,'signUp')}',
                    style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w800,fontSize: 16),
                  ))
                ],
              ),
            ):const SizedBox(),
            SizedBox(height:m.height*.01,),

          ],
        ),
      ),
    ),
  );

}

Widget customAccountsIcons(context){
  final isDarkMode = Theme.of(context).brightness;
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(onPressed: ()async{
        signInWithFacebook(context);
        //  var result = await FacebookAuth.instance.login();
        // print(result.message);
        // print(result.status);
        // if (kIsWeb || defaultTargetPlatform == TargetPlatform.macOS) {
        //   // initialiaze the facebook javascript SDK
        //  await FacebookAuth.instance.webAndDesktopInitialize(
        //     appId: "227421716303304",
        //     cookie: true,
        //     xfbml: true,
        //     version: "v15.0",
        //   );
        //
        // }
        // String prettyPrint(Map json) {
        //   JsonEncoder encoder = const JsonEncoder.withIndent('  ');
        //   String pretty = encoder.convert(json);
        //   return pretty;
        // }
      },
        icon:   Icon(FontAwesomeIcons.facebook, size: 30,color: isDarkMode==Brightness.light?Colors.blue: Theme.of(context).primaryColor,),),
      IconButton(onPressed: (){
      },
        icon:
        Icon(FontAwesomeIcons.instagram, size: 30,color: isDarkMode==Brightness.light? const Color(0xffF500A2): Theme.of(context).primaryColor,),),
      IconButton(onPressed: (){
      },
        icon:  Icon(FontAwesomeIcons.twitter, size: 30,color: isDarkMode==Brightness.light?Colors.blue.shade400: Theme.of(context).primaryColor,),),
      InkWell(
        onTap: (){
          AuthCubit.get(context).loginWithGoogle(context);
        },
        child: SizedBox(
          height: 37,
          width:37,
          child:
          isDarkMode==Brightness.light?
          Image.asset(AppImage.googleImage,fit: BoxFit.cover,):
           Icon(FontAwesomeIcons.google, size: 26,color: Theme.of(context).primaryColor,),),
        ),
    ],);

}


