import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/super_jet_app/auth/presentation/widgets/widget.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/enums.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';

Widget customResetDesign(context){
  final isDarkMode = Theme.of(context).brightness;
  return   BlocProvider(create: (context)=>AuthCubit(sl()),
    child: BlocConsumer<AuthCubit, AppAuthStates>(builder: (context, state) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Center(child: customTitleScreen('Reset Password', Theme.of(context).hintColor)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Padding(
              padding:  EdgeInsets.only(left:
              MediaQuery.of(context).size.width*0.09,
              ),
              child: const Text("Please enter your email for reset password",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(13))
                ),
                child:
                customTextField(
                  textColor: isDarkMode==Brightness.dark? Colors.black:Colors.white,
                  hintTextColor:  isDarkMode==Brightness.dark? Colors.black45:Colors.white70,
                  colorIcon:isDarkMode==Brightness.dark? Colors.black45:Colors.white70,
                  isPassword: false,
                  context: context,
                  keyboardType:TextInputType.text,
                  textInputAction: TextInputAction.done,
                  validator: (value){
                    if(value!.isEmpty){
                    }
                    return null;
                  },
                  controller:AuthCubit.get(context).resetPasswordController,
                  hintText: 'Email',
                  iconData:  Icons.email_outlined,
                  obscureText: false,
                  onFieldSubmitted:(value) {
                    if(AuthCubit.get(context).resetPasswordController.text.isNotEmpty){
                      AuthCubit.get(context).resetPassword(AuthCubit.get(context).resetPasswordController.text, context);
                    }else{
                      showToast('Email address is empty', ToastStates.error, context);
                    }
                  },
                ),

              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            const SizedBox(height: 60,),
            Center(
              child: ConditionalBuilder(
                  condition: AuthCubit.get(context).y ==false,
                  builder: (context)=> customAuthButton(context, 0.5, 'Reset Password', () {
                    if(AuthCubit.get(context).resetPasswordController.text.isNotEmpty){
                      AuthCubit.get(context).resetPassword(AuthCubit.get(context).resetPasswordController.text, context);
                    }else{
                      showToast('Email address is empty', ToastStates.error, context);
                    }
                  },isDarkMode==Brightness.dark?Colors.black45:Colors.white
                  ),
                  fallback: (context)=>Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),)),
            )
          ],
        ),
      );
    }, listener: (context, state) {}),
  );
}