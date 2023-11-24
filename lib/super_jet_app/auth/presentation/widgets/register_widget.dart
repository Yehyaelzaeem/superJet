import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/super_jet_app/auth/presentation/widgets/widget.dart';
import '../../../../core/utils/enums.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';

Widget customRegisterDesign() {
  return BlocConsumer<AuthCubit, AppAuthStates>(
      builder: (context, state) {
        final isDarkMode = Theme.of(context).brightness;
        var m = MediaQuery.of(context).size;
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: AuthCubit.get(context).registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: m.height * 0.38,),
                Container(
                  width:m.width * 0.89,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child:
                  customTextField(
                    textColor: isDarkMode==Brightness.dark? Colors.black:Colors.white,
                    hintTextColor:  isDarkMode==Brightness.dark? Colors.black45:Colors.white70,
                    colorIcon:isDarkMode==Brightness.dark? Colors.black45:Colors.white70,
                    isPassword: false,
                    context: context,
                    keyboardType:TextInputType.text,
                    textInputAction:  TextInputAction.next,
                    validator: (value){
                      if(value!.isEmpty){
                      }
                      return null;
                    },
                    controller: AuthCubit.get(context).name,
                    hintText: 'Name',
                    iconData:  Icons.person,
                    obscureText: false,
                  ),),
                SizedBox(height:m.height * 0.03,),
                Container(
                  width:m.width * 0.89,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child:
                  customTextField(
                    textColor: isDarkMode==Brightness.dark? Colors.black:Colors.white,
                    hintTextColor:  isDarkMode==Brightness.dark? Colors.black45:Colors.white70,
                    colorIcon:isDarkMode==Brightness.dark? Colors.black45:Colors.white70,
                    isPassword: false,
                    context: context,
                    keyboardType:TextInputType.number,
                    textInputAction:  TextInputAction.next,
                    validator: (value){
                      if(value!.isEmpty){
                      }
                      return null;
                    },
                    controller: AuthCubit.get(context).phone,
                    hintText: 'Phone',
                    iconData:  Icons.phone,
                    obscureText: false,
                  ),
                ),
                SizedBox(height: m.height * 0.03,),
                Container(
                  width: m.width * 0.89,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child:
                  customTextField(
                    textColor: isDarkMode==Brightness.dark? Colors.black:Colors.white,
                    hintTextColor:  isDarkMode==Brightness.dark? Colors.black45:Colors.white70,
                    colorIcon:isDarkMode==Brightness.dark? Colors.black45:Colors.white70,
                    isPassword: false,
                    context: context,
                    keyboardType:TextInputType.text,
                    textInputAction:  TextInputAction.next,
                    validator: (value){
                      if(value!.isEmpty){
                      }
                      return null;
                    },
                    controller: AuthCubit.get(context).email,
                    hintText: 'User name/Email ',
                    iconData:  Icons.email_outlined,
                    obscureText: false,
                  ),
                ),
                SizedBox(height: m.height * 0.03,),
                Container(
                  width: m.width * 0.89,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child:
                  customTextField(
                    textColor: isDarkMode==Brightness.dark? Colors.black:Colors.white,
                    hintTextColor:  isDarkMode==Brightness.dark? Colors.black45:Colors.white70,
                    colorIcon:isDarkMode==Brightness.dark? Colors.black45:Colors.white70,
                    isPassword: true,
                    context: context,
                    keyboardType:TextInputType.text,
                    textInputAction:  TextInputAction.next,
                    validator: (value){
                      if(value!.isEmpty){
                      }
                      return null;
                    },
                    controller: AuthCubit.get(context).password,
                    hintText: 'Password',
                    iconData:  Icons.lock_open,
                    obscureText: !AuthCubit.get(context).isEyePassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        AuthCubit.get(context).changeEyePasswordRegister();
                      },
                      icon: Icon(
                          AuthCubit.get(context).isEyePassword == false ? Icons.visibility_off
                              : Icons.visibility, color:
                      isDarkMode==Brightness.dark?
                      (AuthCubit.get(context).isEyePassword==false ?
                      Colors.black45:Colors.white70):
                      (AuthCubit.get(context).isEye==false ?
                      Colors.white : Colors.blue.shade300)),
                    ),
                  ),
                ),
                SizedBox(height:m.height * 0.03,),
                Container(
                  width: m.width * 0.89,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child:
                  customTextField(
                    textColor: isDarkMode==Brightness.dark? Colors.black:Colors.white,
                    hintTextColor:  isDarkMode==Brightness.dark? Colors.black45:Colors.white70,
                    colorIcon:isDarkMode==Brightness.dark? Colors.black45:Colors.white70,
                    isPassword: true,
                    context: context,
                    keyboardType:TextInputType.text,
                    textInputAction:  TextInputAction.done,
                    validator: (value){
                      if(value!.isEmpty){
                      }
                      return null;
                    },
                    controller: AuthCubit.get(context).confirmPassword,
                    hintText: 'Confirm Password',
                    iconData:  Icons.lock_open,
                    obscureText: !AuthCubit.get(context).isEyeConPassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        AuthCubit.get(context).changeEyeConPasswordRegister();
                      },
                      icon: Icon(AuthCubit.get(context).isEyeConPassword == false
                              ? Icons.visibility_off : Icons.visibility, color:
                      isDarkMode==Brightness.dark?
                      (AuthCubit.get(context).isEyeConPassword==false ?
                      Colors.black45:Colors.white70):
                      (AuthCubit.get(context).isEye==false ?
                      Colors.white : Colors.blue.shade300)),
                      ),
                    onFieldSubmitted:  (value) {
                      AuthCubit.get(context).register(
                          AuthCubit.get(context).name.text,
                          AuthCubit.get(context).phone.text,
                          AuthCubit.get(context).email.text,
                          AuthCubit.get(context).confirmPassword.text,
                          context);
                      },
                    ),
                  ),
                SizedBox(height: m.height * 0.07,),
                customAuthButton(context, 0.5, 'Sign In', () {

                  var c = AuthCubit.get(context);
                  if (c.name.text.isEmpty ||
                      c.phone.text.isEmpty ||
                      c.email.text.isEmpty ||
                      c.password.text.isEmpty ||
                      c.confirmPassword.text.isEmpty) {
                    showToast('Your registration found empty data',
                        ToastStates.warning, context);
                  } else {
                    if (c.phone.text.length != 11) {
                      showToast('The phone number not equal 11 number',
                          ToastStates.warning, context);
                    } else {
                      if (c.confirmPassword.text != c.password.text) {
                        showToast('The Confirm Password Not Like Password',
                            ToastStates.warning, context);
                      } else {
                        if (AuthCubit.get(context)
                            .registerFormKey
                            .currentState!
                            .validate()) {
                          AuthCubit.get(context)
                              .register(
                                  AuthCubit.get(context).name.text,
                                  AuthCubit.get(context).phone.text,
                                  AuthCubit.get(context).email.text,
                                  AuthCubit.get(context).confirmPassword.text,
                                  context)
                              .then((value) => {
                                    AuthCubit.get(context).name.text = '',
                                    AuthCubit.get(context).phone.text = '',
                                    AuthCubit.get(context).email.text = '',
                                    AuthCubit.get(context).password.text = '',
                                    AuthCubit.get(context)
                                        .confirmPassword
                                        .text = '',
                                    AuthCubit.get(context).isEyePassword =
                                        false,
                                    AuthCubit.get(context).isEyeConPassword =
                                        false,
                                  });
                        }
                      }
                    }
                  }
                },isDarkMode==Brightness.dark?Colors.black45:Colors.white
                     )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {});
}
