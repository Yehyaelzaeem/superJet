import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(
    String text,
    ToastStates state,
    context
    )=>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseColor(state,context),
        textColor: Colors.white,
        fontSize: 16.0
    );
enum ToastStates{success ,error,warning}

Color chooseColor(ToastStates state,context){
  Color color;
  switch(state){
    case ToastStates.success:
      color =Colors.greenAccent;
      break;
    case ToastStates.error:
      color=Colors.red;
      break;
    case ToastStates.warning:
      color=Colors.amber;
      break;
  }
  return color;
}