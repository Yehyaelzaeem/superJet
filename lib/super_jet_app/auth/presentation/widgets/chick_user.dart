import 'package:flutter/material.dart';
import '../../../../core/services/routeing_page/reoute.dart';
import '../bloc/cubit.dart';
import '../screens/login.dart';

Widget customCheckUserButton(String type ,context)=>
    Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [BoxShadow(color: Colors.black54,blurRadius: 7)]
      ),
      width: MediaQuery.of(context).size.width*0.5,
      height: MediaQuery.of(context).size.height*0.15,
      child: MaterialButton(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        color: Theme.of(context).primaryColor,
        onPressed: (){
          AuthCubit.get(context).chickUsers(type).then((value) =>
          {
            NavigatePages.pushReplacePage(const LoginScreen(), context)
          });
        },
        child:  Text(type,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30
          ),
        ),
      ),
    );