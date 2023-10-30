import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/core/services/routeing_page/routing.dart';

import '../../../../../core/services/services_locator.dart';
import '../../../../auth/presentation/screens/login.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../bloc/trips_bloc.dart';
import '../../widgets/settings_widget.dart';
import '../profile/profile.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    SuperCubit.get(context).removeNotificationListOfChatSetting();
    var m =MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTitleSettingScreen(),
              SizedBox(height: m.height*0.03,),
              customWidgetTitleRowSettings(m: m, text: 'Account', iconData: Icons.person_2_outlined),
              const Divider(color: Colors.black54,),
              customWidgetRowDetailsSettings(m: m, text: 'Profile', onTap: (){
                NavigatePages.persistentNavBarNavigator(const Profile(), context);
              }),
              customWidgetRowDetailsSettings(m: m, text: 'Change Email', onTap: (){}),
              customWidgetRowDetailsSettings(m: m, text: 'Change Password', onTap: (){}),
              SizedBox(height: m.height*0.03,),
              customWidgetTitleRowSettings(m: m, text: 'Payment', iconData: Icons.payments_outlined),
              const Divider(color: Colors.black54,),
              customWidgetRowDetailsSettings(m: m, text: 'The Wallet', onTap: (){}),
              customWidgetRowDetailsSettings(m: m, text: 'Visa', onTap: (){}),
              customWidgetRowDetailsSettings(m: m, text: 'Fawry', onTap: (){}),
              SizedBox(height: m.height*0.03,),
              customWidgetTitleRowSettings(m: m, text: 'Mode', iconData: Icons.brightness_4_outlined),
              const Divider(color: Colors.black54,),
              customWidgetRowSwitchModeSettings(m: m, text: 'Dark mode'),
              SizedBox(height: m.height*0.03,),
              customWidgetTitleRowSettings(m: m, text: 'Language', iconData: Icons.language_outlined),
              const Divider(color: Colors.black54,),
              customWidgetRowSwitchLanguageSettings(m: m, text: 'English', isEn: true, onChanged: (bool value) {
                SuperCubit.get(context).changeLanguage(value);
              }),
              customWidgetRowSwitchLanguageSettings(m: m, text: 'arabic', isEn: false, onChanged: (bool value) {
                SuperCubit.get(context).changeLanguageAr(value);
              }),
              SizedBox(height: m.height*0.01,),
              Center(
                child: InkWell(
                  onTap: (){
                    TripsBloc c =TripsBloc(sl());
                    c.add(SignOutEvent(context));
                    NavigatePages.persistentNavBarNavigator(LoginScreen(type: SuperCubit.get(context).type,),context);
                  },
                  child: SizedBox(
                    height: m.height*0.06,
                    width: m.width*0.5,
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.logout_outlined,color: Colors.black87,),
                          SizedBox(width: m.width*0.02,),
                          const Text('LOGOUT',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400
                          ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: m.height*0.03,),
            ],
          ),
        ),
      ),
    );
  }
}
