import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/core/services/routeing_page/routing.dart';
import 'package:superjet/super_jet_app/auth/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/auth/presentation/bloc/states.dart';
import 'package:superjet/super_jet_app/auth/presentation/screens/chick_user.dart';
import 'package:superjet/super_jet_app/auth/presentation/widgets/login_widget.dart';
import '../widgets/widget.dart';

class LoginScreen extends StatelessWidget {
  final String type;
  const LoginScreen({super.key, required this.type});
  @override
  Widget build(BuildContext context) {
    AuthCubit.get(context).getType();
    return  WillPopScope(
      onWillPop: () {
        customDialogPopScope(context);
        return Future.value(false);
      },
      child:
      Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              AuthCubit.get(context).emailLog.clear();
              AuthCubit.get(context).passwordLog.clear();
              AuthCubit.get(context).isEye=false;
              NavigatePages.pushReplacePage(const ChickUsers(), context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: customAuthDesignBackGround(customLoginDesign(type,context),context,),
      ),
    );

  }
}
//            customLoginDesign(context),