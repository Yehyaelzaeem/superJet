import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/state.dart';
import 'package:badges/badges.dart' as badges;

Widget customTitleSettingScreen(){
  return const Text('Settings',
    style: TextStyle(
        fontSize: 30,
        color: Colors.black,
        fontWeight: FontWeight.bold),
  );
}

Widget customWidgetTitleRowSettings({required Size m,required String text ,required IconData iconData}){
  return Row(
    children: [
      Icon(iconData),
      SizedBox(width: m.width*0.025,),
       Text(text,
        style: const TextStyle(
            fontSize: 18,
            color: Colors.black87,
            fontWeight: FontWeight.w500
        ),
      ),
    ],
  );
}

Widget customWidgetRowDetailsSettings({required Size m ,required String text,required void Function()? onTap}){
  return  InkWell(
    onTap: onTap,
    child: SizedBox(
      height: m.height*0.05,
      child: Row(
        children: [
          SizedBox(width: m.width*0.02,),
          text=='Profile'?
          BlocConsumer<SuperCubit,AppSuperStates>(
              builder: (context, state) {
            return
              SuperCubit.get(context).listOfChats.isNotEmpty?
              badges.Badge(
                badgeContent: Text(SuperCubit.get(context).listOfChats.length.toString(),style: const TextStyle(color: Colors.white),),
                badgeStyle:const badges.BadgeStyle(badgeColor: Colors.red) ,
                child:  Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(text,
                    style: const TextStyle(
                        fontSize: 17,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ),

              ):  Text(text,
                style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400
                ),
              );
          },
            listener: (context, state){}):
          Text(text,
            style: const TextStyle(
                fontSize: 17,
                color: Colors.black54,
                fontWeight: FontWeight.w400
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios,
            color: Colors.black54,
          )
        ],
      ),
    ),
  );
}


Widget customWidgetRowSwitchModeSettings({required Size m ,required String text,}){
  bool light = false;
  return  SizedBox(
    height: m.height*0.05,
    child: Row(
      children: [
        SizedBox(width: m.width*0.02,),
        Text(text,
          style: const TextStyle(
              fontSize: 17,
              color: Colors.black54,
              fontWeight: FontWeight.w400
          ),
        ),
        const Spacer(),
        StatefulBuilder(builder: (context,setState){
          return Switch(
            value: light,
            onChanged: (bool value) {
              setState(() {
                light = value;
              });
            },
          );
        }),
      ],
    ),
  );
}
Widget customWidgetRowSwitchLanguageSettings({required Size m ,required String text,required bool isEn,required void Function(bool)? onChanged}){
  return BlocConsumer<SuperCubit,AppSuperStates>
    (
      builder: (context ,state){
    return SizedBox(
      height: m.height*0.05,
      child: Row(
        children: [
          SizedBox(width: m.width*0.02,),
          Text(text,
            style: const TextStyle(
                fontSize: 17,
                color: Colors.black54,
                fontWeight: FontWeight.w400
            ),
          ),
          const Spacer(),
          isEn==true?
          Switch(
            value: SuperCubit.get(context).lightEn,
            onChanged: onChanged
          ):
          Switch(
            value: SuperCubit.get(context).lightAr,
            onChanged: onChanged
          ),
        ],
      ),
    );
  }, listener: (context ,state){});
}