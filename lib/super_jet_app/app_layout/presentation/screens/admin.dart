import 'package:flutter/material.dart';
import 'package:superjet/core/services/routeing_page/reoute.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/admin_screens/admin_branches.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/admin_screens/admin_chat.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/admin_screens/admin_notification.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/admin_screens/admin_trips_screen.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/widgets/admin.dart';
import 'admin_screens/user_table_screen.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var m =MediaQuery.of(context).size;
    return   Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: m.height*0.07,),
            Text('Administrator',
          style: TextStyle(
            fontSize: 40,
            color: Theme.of(context).primaryColor,
            shadows: const [BoxShadow(color: Colors.black,blurRadius: 1)],
            fontWeight: FontWeight.bold,
          ),),
            SizedBox(height: m.height*0.06,),
            customAdminItems(Icons.people_alt_outlined, "Users", (){
              SuperCubit.get(context).getUsers();
              NavigatePages.persistentNavBarNavigator( const UserTableScreen(), context);
            },context),
            SizedBox(height: m.height*0.04,),
            customAdminItems(Icons.format_align_justify_rounded, "Trips", (){
              SuperCubit.get(context).getTrips(context);
              NavigatePages.persistentNavBarNavigator(const AdminTripsScreen(), context);

            },context),
            SizedBox(height: m.height*0.04,),
            customAdminItems(Icons.margin_sharp, "Branches", (){
              NavigatePages.persistentNavBarNavigator(const AdminBranchesScreen(), context);

            },context),
            SizedBox(height: m.height*0.04,),

            customAdminItems(Icons.chat, "Chat", (){
              NavigatePages.persistentNavBarNavigator(const AdminChat(), context);

            }, context),
            SizedBox(height: m.height*0.04,),
            customAdminItems(Icons.notification_add, "Notification", (){
              NavigatePages.persistentNavBarNavigator(const AdminNotification(), context);
            }, context),
            SizedBox(height: m.height*0.04,),

          ],
        ),
      ),
    );
  }
}