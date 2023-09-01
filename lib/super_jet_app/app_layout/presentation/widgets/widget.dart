import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../../core/image/image.dart';
import '../screens/categories.dart';
import '../screens/home.dart';
import '../screens/current_trips.dart';
import '../screens/profile.dart';

class AppHomeWidgets {

  //Screens ***********************
  static List<Widget> screens = [
    const Home(),
    const Categories(),
    const CurrentTrips(),
    const Profile(),
  ];

  //PersistentBottom ****************
  static List<PersistentBottomNavBarItem> navBarsItems(context) {
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
        icon: const Icon(Icons.directions_bus),
        title: ("Current Trips"),
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
Widget customTextFieldProfile(
{
   context,
   TextInputType? keyboardType,
   TextInputAction? textInputAction,
   String? Function(String?)? validator,
   TextEditingController? controller,
   String? hintText,
   IconData? iconData,
   bool? obscureText ,
   void Function(String)? onFieldSubmitted,
  void Function(String)? onChanged
}
    )=>  TextFormField(
  textInputAction:textInputAction,
  validator:validator,
  keyboardType: keyboardType,
  controller:controller,
  style: const TextStyle(color: Colors.black,fontSize: 16),
  decoration:  InputDecoration(
    hintText:hintText,
    hintStyle: const TextStyle(fontSize: 15,color: Colors.grey),
    prefixIcon:Icon(iconData,color: Colors.grey.shade700,),
    errorBorder: InputBorder.none,
    border: InputBorder.none,
  ),
  onFieldSubmitted:  onFieldSubmitted,
  onChanged: onChanged,
  obscureText :obscureText!,
);

