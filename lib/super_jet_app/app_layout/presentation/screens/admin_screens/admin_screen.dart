import 'package:flutter/material.dart';
import 'package:superjet/core/services/routeing_page/routing.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/admin_screens/admin_notification.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/widgets/admin.dart';
import 'branches_table_screen.dart';
import 'trips_table_screen.dart';
import 'user_table_screen.dart';

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
            Text('Manger',
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
              SuperCubit.get(context).tripsList.clear();
              SuperCubit.get(context).getAdminCategoryName();
              SuperCubit.get(context).getTrips(context);
              NavigatePages.persistentNavBarNavigator(const TripsDateTableScreen(), context);

            },context),
            SizedBox(height: m.height*0.04,),
            customAdminItems(Icons.margin_sharp, "Branches", (){
              SuperCubit.get(context).getBranches(context);
              NavigatePages.persistentNavBarNavigator(const BranchesDateTableScreen(), context);
            },context),
            SizedBox(height: m.height*0.04,),

            customAdminItems(Icons.groups, "Employees", (){
              // NavigatePages.persistentNavBarNavigator(const AdminTripsScreen2(), context);
            }, context),
            SizedBox(height: m.height*0.04,),
            customAdminItems(Icons.notification_add, "Notification", (){
              NavigatePages.persistentNavBarNavigator(
                  const AdminNotification(
                    text: 'Send notification to all users in Super Jet App',
                    token:'/topics/usersSuperJet',), context);
            }, context),
            SizedBox(height: m.height*0.04,),

          ],
        ),
      ),
    );
  }
}
