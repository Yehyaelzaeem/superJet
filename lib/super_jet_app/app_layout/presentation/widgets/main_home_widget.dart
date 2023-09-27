import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/state.dart';
import 'package:superjet/super_jet_app/auth/presentation/bloc/cubit.dart';
import '../screens/admin.dart';
import '../screens/categories.dart';
import '../screens/home.dart';
import '../screens/payment_screen.dart';
import '../screens/profile.dart';
import 'package:badges/badges.dart' as badges;

class AppHomeWidgets {
  // static var type='user';
  // static getType(context){
  //   type =AuthCubit.get(context).isKnowType;
  // }
  //User Screens ***********************
  static List<Widget> userScreens = [
    const Home(),
    const Categories(),
    const PaymentScreen(),
    const Profile(),

  ];
  static List<Widget> adminScreens = [
    const Home(),
    const Categories(),
    const PaymentScreen(),
    const AdminScreen(),
    const Profile(),
  ];

  //PersistentBottom ****************
  static List<PersistentBottomNavBarItem> userNavBarsItems(context) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.apps),
        title: ("Categories"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: BlocConsumer<SuperCubit,AppSuperStates>(builder: (context, state) {
          return
          SuperCubit.get(context).listCartTrips.isNotEmpty?
           badges.Badge(
            badgeContent: Text(SuperCubit.get(context).listCartTrips.length.toString(),style: const TextStyle(color: Colors.white),),
            badgeStyle:const badges.BadgeStyle(badgeColor: Colors.red) ,
            child: const Icon(Icons.payments_outlined),
          ): const Icon(Icons.payments_outlined);
        },
                   listener: (context, state){},),
        title: ("Payment"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),

    ];
  }
  static List<PersistentBottomNavBarItem> adminNavBarsItems(context) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.apps),
        title: ("Categories"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: BlocConsumer<SuperCubit,AppSuperStates>(builder: (context, state) {
          return
          SuperCubit.get(context).listCartTrips.isNotEmpty?
           badges.Badge(
            badgeContent: Text(SuperCubit.get(context).listCartTrips.length.toString(),style: const TextStyle(color: Colors.white),),
            badgeStyle:const badges.BadgeStyle(badgeColor: Colors.red) ,
            child: const Icon(Icons.payments_outlined),
          ): const Icon(Icons.payments_outlined);
        },
                   listener: (context, state){},),
        title: ("Payment"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.admin_panel_settings_outlined),
        title: ("Admin"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),  PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),

    ];
  }
}


