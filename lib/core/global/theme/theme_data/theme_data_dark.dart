import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../app_color/app_color_dark.dart';

ThemeData getThemeDataDark()=>
    ThemeData(
    dialogBackgroundColor: AppColorDark.categoryItemColor,
    shadowColor: AppColorDark.shadowColor,
    hintColor:  AppColorDark.primaryHardColor,
    //Trip Color Widget
    highlightColor:AppColorDark.tripWidgetColor ,
    scaffoldBackgroundColor: AppColorDark.scaffoldBackgroundColor,
    primaryColor: AppColorDark.primaryColor,
    //Chairs Colors
    focusColor:AppColorDark.waitingCart,
    hoverColor: AppColorDark.availableChair,
    disabledColor:AppColorDark.unAvailableChair ,
    splashColor:AppColorDark.baseChair ,
    canvasColor: AppColorDark.bookedDetailTopBackgroundColor,
    primaryColorDark: AppColorDark.chairNumberColor,
    indicatorColor: AppColorDark.notificationTitleColor,
    unselectedWidgetColor:AppColorDark.categoryDetailsTitleBackgroundColor,
   //Title Category BackgroundColor
    primaryColorLight:AppColorDark.categoryDetailsBackgroundColor,
    appBarTheme: getAppThemeDataDark(),
    bottomNavigationBarTheme: getBottomNavigationBarThemeDataDark(),
    textTheme: getTextTheme(),
    iconTheme: const IconThemeData(
      color: AppColorDark.primarySecondColor
    ),
  textButtonTheme:  TextButtonThemeData(
    style:
    ButtonStyle(
      backgroundColor:MaterialStateProperty.all(Colors.grey.shade600),
      foregroundColor: MaterialStateProperty.all(Colors.white)
    )
  )
  // useMaterial3: true,
) ;

TextTheme getTextTheme() =>
         TextTheme(
           displaySmall: const TextStyle(
             fontSize: 16,
             color: AppColorDark.primarySecondColor,
             fontWeight: FontWeight.w600,
           ),
           displayMedium: const TextStyle(
             fontSize: 20,
             fontWeight: FontWeight.bold,
             color: AppColorDark.primarySecondColor,),
           displayLarge: const TextStyle(
             fontSize: 30,
             fontWeight: FontWeight.bold,
             color:AppColorDark.primaryHardColor,
           ),

           titleMedium:   TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 25,
             color:  AppColorDark.categoryDetailsBackgroundColor,
           ),
           //Category Screen Font
           bodySmall: const TextStyle(
             fontSize: 10,
             fontWeight: FontWeight.w500,
             color:AppColorDark.primaryHardColor,),
           headlineSmall:  TextStyle(
             fontSize: 10,
             fontWeight: FontWeight.w500,
             color: AppColorDark.categoriesTextColor,),
           bodyMedium: const TextStyle(
             fontSize: 15,
             fontWeight: FontWeight.w600,
             color:AppColorDark.primaryHardColor,
           ),
           //title of booked screen
           titleSmall: const TextStyle(
             color:AppColorDark.primaryColor,
           ),
           titleLarge: TextStyle(
             fontSize: 16,
             fontWeight: FontWeight.w600,
             color:AppColorDark.chairNumberColor,
           ),










    );




//BottomNavigationBarThemeData
BottomNavigationBarThemeData getBottomNavigationBarThemeDataDark() =>
    BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      elevation: 20.0,
      backgroundColor:  HexColor('333739'),
    );



// AppBarTheme
AppBarTheme getAppThemeDataDark() =>
    AppBarTheme(
    backgroundColor: HexColor('333739'),
    systemOverlayStyle: SystemUiOverlayStyle(
      systemNavigationBarColor:HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.grey.shade600,
    ),
    titleTextStyle: const TextStyle(
        color:  Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold
    ),
    iconTheme: const IconThemeData(
        color: Colors.white
    ),
    elevation: 0
);