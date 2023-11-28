import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/core/global/localization/appLocale.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/state.dart';
import 'package:badges/badges.dart' as badges;

Widget customTitleSettingScreen(context){
  return  Text('${getLang(context, 'settings')}',
    style: Theme.of(context).textTheme.displayLarge
  );
}

Widget customWidgetTitleRowSettings({required Size m,required String text ,required IconData iconData,required context}){
  return Row(
    children: [
      Icon(iconData),
      SizedBox(width: m.width*0.025,),
       Text(text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ],
  );
}

Widget customWidgetRowDetailsSettings({required TextStyle? style ,required Size m ,required String text,required void Function()? onTap,required context}){
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
                  child: Text(text, style:style),
                ),

              ):   Text(text, style:style);
          },
            listener: (context, state){}):
          Text(text, style:style),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios,

          )
        ],
      ),
    ),
  );
}


Widget customWidgetRowSwitchModeSettings({required Size m ,required String text,required context}){
  var c =SuperCubit.get(context);
  return  SizedBox(
    height: m.height*0.05,
    child: Row(
      children: [
        SizedBox(width: m.width*0.02,),
        Text(text,
          style: Theme.of(context).textTheme.titleSmall
        ),
        const Spacer(),
       Switch(
         value: c.isDark,
         onChanged: (bool value) {
           c.changeMode(value);
         },
       ),
      ],
    ),
  );
}
Widget customWidgetRowSwitchLanguageSettings({required TextStyle? style ,required Size m ,required String text,required bool isEn,required void Function(bool)? onChanged}){
  return BlocConsumer<SuperCubit,AppSuperStates>
    (
      builder: (context ,state){
    return SizedBox(
      height: m.height*0.05,
      child: Row(
        children: [
          SizedBox(width: m.width*0.02,),
          Text(text,
            style:style
          ),
          const Spacer(),
          isEn==true?
          Switch(
            value: SuperCubit.get(context).lightEn!,
            onChanged: onChanged
          ):
          Switch(
            value: SuperCubit.get(context).lightAr!,
            onChanged: onChanged
          ),
        ],
      ),
    );
  }, listener: (context ,state){});
}