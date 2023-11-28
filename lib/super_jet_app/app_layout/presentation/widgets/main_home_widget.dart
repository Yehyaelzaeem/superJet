import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:superjet/core/global/localization/appLocale.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/state.dart';
import '../screens/admin_screens/admin_screen.dart';
import '../screens/categories/categories.dart';
import '../screens/home/home.dart';
import '../screens/payment/payment_screen.dart';
import '../screens/profile/profile.dart';
import 'package:badges/badges.dart' as badges;

import '../screens/setting/setting.dart';

class AppHomeWidgets {

  static List<Widget> userScreens = [
    const Home(city: 'All',),
    const Categories(),
    const PaymentScreen(),
    const Setting(),

  ];
  static List<Widget> adminScreens = [
     const Home(city: 'All',),
    const Categories(),
    const PaymentScreen(),
    const AdminScreen(),
    const Setting(),
  ];
  static List<Widget> branchScreens = [
    const Home(city: 'Alex',),
    const Categories(),
    const PaymentScreen(),
    const Setting(),
  ];

  //PersistentBottom ****************
  static List<PersistentBottomNavBarItem> userNavBarsItems(context) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ('${getLang(context, 'home')}'),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.apps),
        title: ('${getLang(context, 'categories')}'),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon:
        BlocConsumer<SuperCubit,AppSuperStates>(builder: (context, state) {
          return
          SuperCubit.get(context).listCartTrips.isNotEmpty?
           badges.Badge(
            badgeContent: Text(SuperCubit.get(context).listCartTrips.length.toString(),style: const TextStyle(color: Colors.white),),
            badgeStyle:const badges.BadgeStyle(badgeColor: Colors.red) ,
            child: const Icon(Icons.payments_outlined),
          ): const Icon(Icons.payments_outlined);
        },
                   listener: (context, state){},),
        title: ('${getLang(context, 'payment')}'),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon:
        BlocConsumer<SuperCubit,AppSuperStates>(builder: (context, state) {
          return
            SuperCubit.get(context).listOfChats.isNotEmpty?
            badges.Badge(
              badgeContent: Text(SuperCubit.get(context).listOfChats.length.toString(),style: const TextStyle(color: Colors.white),),
              badgeStyle:const badges.BadgeStyle(badgeColor: Colors.red) ,
              child: const Icon(Icons.settings),
            ): const Icon(Icons.settings);
        },
          listener: (context, state){},),
        title: ('${getLang(context, 'setting')}'),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),

    ];
  }
  static List<PersistentBottomNavBarItem> adminNavBarsItems(context) {
    return [
      PersistentBottomNavBarItem(
        icon:  Icon(Icons.home),
        title: ("${getLang(context, 'home')}"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.apps),
        title: ("${getLang(context, 'categories')}"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon:
        BlocConsumer<SuperCubit,AppSuperStates>(builder: (context, state) {
          return
          SuperCubit.get(context).listCartTrips.isNotEmpty?
           badges.Badge(
            badgeContent: Text(SuperCubit.get(context).listCartTrips.length.toString(),style: const TextStyle(color: Colors.white),),
            badgeStyle:const badges.BadgeStyle(badgeColor: Colors.red) ,
            child: const Icon(Icons.payments_outlined),
          ): const Icon(Icons.payments_outlined);
        },
                   listener: (context, state){},),
        title: ("${getLang(context, 'payment')}"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.admin_panel_settings_outlined),
        title: ("${getLang(context, 'admin')}"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon:
        BlocConsumer<SuperCubit,AppSuperStates>(builder: (context, state) {
          return
            SuperCubit.get(context).listOfChatSetting.isNotEmpty?
            badges.Badge(
              badgeContent: Text(SuperCubit.get(context).listOfChatSetting.length.toString(),style: const TextStyle(color: Colors.white),),
              badgeStyle:const badges.BadgeStyle(badgeColor: Colors.red) ,
              child: const Icon(Icons.settings),
            ): const Icon(Icons.settings);
        },
          listener: (context, state){},),
        title: ("${getLang(context, 'settings')}"),
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),


    ];
  }
  static List<PersistentBottomNavBarItem> branchNavBarsItems(context) {
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
        icon:
        BlocConsumer<SuperCubit,AppSuperStates>(builder: (context, state) {
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
}


