import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../app_color/app_color_light.dart';

ThemeData getThemeDataLight()=>
    ThemeData(
        shadowColor: AppColorLight.shadowColor,
        //Trip Color Widget
        highlightColor:AppColorLight.tripWidgetColor ,
        scaffoldBackgroundColor: AppColorLight.scaffoldBackgroundColor,
        primaryColor: AppColorLight.primaryColor,
        //Chairs Colors
        focusColor:AppColorLight.waitingCart,
        hoverColor: AppColorLight.availableChair,
        disabledColor:AppColorLight.unAvailableChair ,
        splashColor:AppColorLight.baseChair ,
        unselectedWidgetColor:AppColorLight.categoryDetailsTitleBackgroundColor,
        //Title Category Background Color
        primaryColorLight:AppColorLight.categoryDetailsBackgroundColor,
        dialogBackgroundColor: AppColorLight.categoryItemColor,
        primaryColorDark: AppColorLight.chairNumberColor,
        indicatorColor: AppColorLight.notificationTitleColor,
        hintColor:  AppColorLight.primaryHardColor,
        canvasColor: AppColorLight.bookedDetailTopBackgroundColor,

        appBarTheme: getAppThemeDataDark(),
        bottomNavigationBarTheme: getBottomNavigationBarThemeDataDark(),
        textTheme: getTextTheme(),
        iconTheme: const IconThemeData(
            color: AppColorLight.primarySecondColor
        ),
        textButtonTheme:  TextButtonThemeData(
            style:
            ButtonStyle(
                backgroundColor:MaterialStateProperty.all(AppColorLight.primaryColor),
                foregroundColor: MaterialStateProperty.all(Colors.white)
            )
        )
      // useMaterial3: true,
    ) ;

TextTheme getTextTheme() =>
    TextTheme(
      displaySmall: const TextStyle(
        fontSize: 16,
        color: AppColorLight.primarySecondColor,
        fontWeight: FontWeight.w600,
      ),
      displayMedium: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColorLight.primarySecondColor,),
      titleMedium:  const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color:  AppColorLight.categoryDetailsBackgroundColor,
      ),
      //Category Screen Font
      bodySmall: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color:AppColorLight.primaryHardColor,),
      headlineSmall:  TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColorLight.categoriesTextColor,),
        //title of booked screen
      titleSmall:  TextStyle(
          color:Colors.grey.shade600,
        ),
      titleLarge: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color:AppColorLight.primaryHardColor,
      ),
      displayLarge: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color:AppColorLight.primaryHardColor,
      ),
      bodyMedium: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color:AppColorLight.primaryHardColor,
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
    const AppBarTheme(
        backgroundColor:Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor:Color(0xffEABE67),
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Color(0xffEABE67),
        ),
        titleTextStyle: TextStyle(
            color:  Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        elevation: 0
    );