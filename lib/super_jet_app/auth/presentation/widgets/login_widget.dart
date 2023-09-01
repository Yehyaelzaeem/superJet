import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:superjet/super_jet_app/auth/presentation/widgets/widget.dart';
import '../../../../core/image/image.dart';
import '../../../../core/services/routeing_page/reoute.dart';
import '../../../../core/utils/enums.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';
import '../screens/register.dart';
import '../screens/reset_password.dart';


Future<String?> customDialogPopScope(context)=>
    showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text("Are You Sure ?"),
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20),
      actionsOverflowButtonSpacing: 20,
      actions: [
        MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Theme.of(context).primaryColor,
            child: const Text("Back")),
        MaterialButton(
            onPressed: () {
              exit(0);
            },
            color: Theme.of(context).primaryColor,
            child: const Text("Yes")),
      ],
      content: const Text("Want to close the app"),
    ));

Widget customLoginDesign(context){
  var h= MediaQuery.of(context).size.height;
  var w= MediaQuery.of(context).size.width;
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: h*.2,),
        customWidgetsLogin(context),
        SizedBox(height: h*.04,),
        Padding(
          padding: const EdgeInsets.only(left: 28.0,right: 28),
          child: Row(
            children: [
              const Expanded(child: Divider(thickness: 2,)),
              SizedBox(width: w*.02,),
              const Text('Sign In With',
                style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(width: w*.02,),
              const Expanded(child: Divider(thickness: 2,)),
            ],
          ),
        ),
        SizedBox(height: w*.01,),
        customAccountsIcons(context),
      ],
    ),
  );

}

Widget customWidgetsLogin(context){
  var m =MediaQuery.of(context).size;
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
            SizedBox(height: m.height*.04,),
            customTitleScreen('SIGN IN',Colors.black),
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
                  controller: AuthCubit.get(context).emailLog,
                  hintText: 'User name/Email',
                  iconData:  Icons.person,
                  obscureText: false,
                ),),
            SizedBox(height:m.height*.03,),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20))
              ),
              child:
              customTextField(
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
                hintText: 'Password',
                iconData: Icons.lock,
                obscureText: !AuthCubit.get(context).isEye,
                suffixIcon:
                  IconButton(onPressed: (){AuthCubit.get(context).changeEyePassword();}, icon:
                  Icon(AuthCubit.get(context).isEye==false ?
                  Icons.visibility_off: Icons.visibility,
                      color: AuthCubit.get(context).isEye==false ?
                      Colors.white:Colors.grey.shade300) ,),
                onFieldSubmitted:
                (value){
                      if(AuthCubit.get(context).formKey.currentState!.validate() ){
                        AuthCubit.get(context).login(AuthCubit.get(context).emailLog.text, AuthCubit.get(context).passwordLog.text,context);
                      }}
                   ),
      ),
            Container(
                alignment: Alignment.topRight,
                child: TextButton(onPressed: (){
                 NavigatePages.pushToPage(const ResetPassword(), context);
                }, child:  Text("Forget Password?",
                  style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.w800),
                ))),
            SizedBox(height: m.height*.04,),
            BlocConsumer<AuthCubit,AppAuthStates>(
                builder: (context,state)=>
                    ConditionalBuilder(
                      condition: AuthCubit.get(context).isNotLoading,
                      builder: (context)=>
                          customAuthButton(context, 0.38, 'LOGIN', () {
                            var c =AuthCubit.get(context);
                            if(c.emailLog.text.isEmpty||c.passwordLog.text.isEmpty){
                              showToast('email or password is empty', ToastStates.warning, context);
                            }else{
                              if(AuthCubit.get(context).formKey.currentState!.validate() ){
                                AuthCubit.get(context).login(AuthCubit.get(context).emailLog.text, AuthCubit.get(context).passwordLog.text,context);}
                            }
                          }),
                      fallback: (context)=> Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),),
                    ), listener: (context,state){}),
            const Spacer(),
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade600),
                  ),
                  TextButton(onPressed: (){
                    NavigatePages.pushToPage(const Register(), context);
                  }, child:  Text("Sign Up",
                    style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w800,fontSize: 16),
                  ))
                ],
              ),
            ),
            SizedBox(height:m.height*.01,),

          ],
        ),
      ),
    ),
  );

}

Widget customAccountsIcons(context)=>Row(
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
      icon:  const Icon(FontAwesomeIcons.facebook, size: 30,color: Colors.blue,),),
    IconButton(onPressed: (){
    },
      icon:  const Icon(FontAwesomeIcons.instagram, size: 30,color: Color(0xffF500A2),),),
    IconButton(onPressed: (){
    },
      icon:  Icon(FontAwesomeIcons.twitter, size: 30,color: Colors.blue.shade400,),),
    InkWell(
      onTap: (){
        AuthCubit.get(context).loginWithGoogle(context);
      },
      child: SizedBox(
        height: 37,
        width:37,
        child:Image.asset(AppImage.googleImage,fit: BoxFit.cover,),
      ),
    ),
  ],);
