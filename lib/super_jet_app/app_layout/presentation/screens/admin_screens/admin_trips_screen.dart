import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/services/routeing_page/reoute.dart';
import '../../bloc/cubit.dart';
import '../../widgets/admin.dart';
import 'all_trips_table_screen.dart';

class AdminTripsScreen extends StatelessWidget {
  const AdminTripsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var m =MediaQuery.of(context).size;
    return   Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: m.height*0.07,),
            Text('Manage Trips',
              style: TextStyle(
                fontSize: 40,
                color: Theme.of(context).primaryColor,
                shadows: const [BoxShadow(color: Colors.black,blurRadius: 1)],
                fontWeight: FontWeight.bold,
              ),),
            SizedBox(height: m.height*0.06,),
            customAdminItems(Icons.add, "Add Trip", (){

            },context),
            SizedBox(height: m.height*0.04,),
            customAdminItems(Icons.edit, "Update Trip", (){

            },context),
            SizedBox(height: m.height*0.04,),
            customAdminItems(Icons.delete_forever_rounded, "Delete Trip", (){

            },context),
            SizedBox(height: m.height*0.04,),
            customAdminItems(Icons.get_app, "Get All Trip", (){
              SuperCubit.get(context).getTrips(context);
              NavigatePages.persistentNavBarNavigator(const TripsDateTableScreen(), context);
            }, context),
            SizedBox(height: m.height*0.04,),
            customAdminItems(Icons.insert_page_break_rounded, "Insert new Time", (){

            }, context),
            SizedBox(height: m.height*0.04,),
          ],
        ),
      ),
    );
  }
}
