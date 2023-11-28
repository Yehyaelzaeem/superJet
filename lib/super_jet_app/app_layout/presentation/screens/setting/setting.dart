import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:superjet/core/global/localization/appLocale.dart';
import 'package:superjet/core/services/routeing_page/routing.dart';
import 'package:superjet/core/utils/enums.dart';

import '../../../../../core/services/services_locator.dart';
import '../../../../auth/presentation/screens/login.dart';
import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../bloc/trips_bloc.dart';
import '../../widgets/profile.dart';
import '../../widgets/settings_widget.dart';
import '../profile/profile.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    // SuperCubit.get(context).removeNotificationListOfChatSetting();
    SuperCubit.get(context).getType();

    var m =MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          child: Theme(
            data: ThemeData(
              iconTheme:  IconThemeData(
                color: Theme.of(context).hintColor,
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTitleSettingScreen(context),
                SizedBox(height: m.height*0.03,),
                customWidgetTitleRowSettings(m: m, text: '${getLang(context, 'account')}', iconData: Icons.person_2_outlined, context: context),
                const Divider(color: Colors.black54,),
                customWidgetRowDetailsSettings(m: m, text: '${getLang(context, 'profile')}', onTap: (){
                  NavigatePages.persistentNavBarNavigator(const Profile(), context);
                }, context: context, style: Theme.of(context).textTheme.titleSmall),
                customWidgetRowDetailsSettings(m: m, text: '${getLang(context, 'changeEmail')}', onTap: (){
                  var c =SuperCubit.get(context);
                  customBottomSheetChangeEmail(
                      title: '${getLang(context, 'changeEmail')}', text: '${getLang(context, 'changeEmailAddress')}',
                      hintText: '${getLang(context, 'email')}', iconData: Icons.person,
                      onTap: (){
                       if(c.controllerName.text.isNotEmpty){
                         c.getType();
                         c.getID();
                         c.changeEmail(c.controllerName.text.trim(),context);
                       }else{
                         showToast('${getLang(context, 'pleaseEnter')} ${getLang(context, 'email')}', ToastStates.warning, context);
                       }
                      },
                      context: context,
                      iconTitle: Icons.email_outlined);
                }, context: context, style: Theme.of(context).textTheme.titleSmall),
                customWidgetRowDetailsSettings(m: m, text: '${getLang(context, 'changePassword')}', onTap: (){
                  var c =SuperCubit.get(context);
                  customBottomSheetChangeEmail(
                      title: '${getLang(context, 'changePassword')}', text: '${getLang(context, 'changePassword')}',
                      hintText: '${getLang(context, 'passwordHintText')}', iconData: Icons.security,
                      onTap: (){
                           if(c.controllerName.text.isNotEmpty){
                             c.getType();
                             c.getID();
                             c.changePassword(c.controllerName.text.trim(),context);
                           }else{
                             showToast('${getLang(context, 'pleaseEnter')} ${getLang(context, 'passwordHintText')}', ToastStates.warning, context);
                           }
                      },
                      context: context,
                      iconTitle: Icons.security);
                }, context: context, style: Theme.of(context).textTheme.titleSmall),
                SizedBox(height: m.height*0.03,),
                customWidgetTitleRowSettings(m: m, text: '${getLang(context, 'payment2')}', iconData: Icons.payments_outlined, context: context),
                const Divider(color: Colors.black54,),
                customWidgetRowDetailsSettings(m: m, text: '${getLang(context, 'wallet2')}', onTap: (){}, context: context, style: Theme.of(context).textTheme.titleSmall),
                customWidgetRowDetailsSettings(m: m, text: '${getLang(context, 'visa')}', onTap: (){}, context: context, style: Theme.of(context).textTheme.titleSmall),
                customWidgetRowDetailsSettings(m: m, text: '${getLang(context, 'fawry')}', onTap: (){}, context: context, style: Theme.of(context).textTheme.titleSmall),
                SizedBox(height: m.height*0.03,),
                customWidgetTitleRowSettings(m: m, text: '${getLang(context, 'mode')}', iconData: Icons.brightness_4_outlined, context: context),
                const Divider(color: Colors.black54,),
                customWidgetRowSwitchModeSettings(m: m, text: '${getLang(context, 'typeOfMode')}',context: context),
                SizedBox(height: m.height*0.03,),
                customWidgetTitleRowSettings(m: m, text: '${getLang(context, 'language')}', iconData: Icons.language_outlined, context: context),
                const Divider(color: Colors.black54,),
                customWidgetRowSwitchLanguageSettings(m: m, text: '${getLang(context, 'en')}', isEn: true, onChanged: (bool value) {
                  SuperCubit.get(context).changeLanguageSwitch(value);
                }, style: Theme.of(context).textTheme.titleSmall),
                customWidgetRowSwitchLanguageSettings(m: m, text: '${getLang(context, 'ar')}', isEn: false, onChanged: (bool value) {
                  SuperCubit.get(context).changeLanguageAr(value);
                }, style:  Theme.of(context).textTheme.titleSmall),
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
                            const Icon(Icons.logout_outlined,),
                            SizedBox(width: m.width*0.02,),
                             Text('${getLang(context, 'logOut')}',
                            style: TextStyle(
                              color: Theme.of(context).hintColor,
                            )
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
      ),
    );
  }
}
