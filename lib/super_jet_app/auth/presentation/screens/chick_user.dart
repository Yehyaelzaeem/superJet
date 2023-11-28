import 'package:flutter/material.dart';
import 'package:superjet/core/global/localization/appLocale.dart';
import 'package:superjet/super_jet_app/auth/presentation/widgets/chick_user.dart';
import '../../../../core/image/image.dart';
import '../widgets/login_widget.dart';

class ChickUsers extends StatelessWidget {
  const ChickUsers({super.key});

  @override
  Widget build(BuildContext context) {
    var h =MediaQuery.of(context).size.height;
    final isDarkMode = Theme.of(context).brightness;

    return WillPopScope(
      onWillPop: () {
        customDialogPopScope(context);
        return Future.value(false);
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child:
                Image.asset(
                  isDarkMode==Brightness.light?
                  AppImage.onBoarding1:AppImage.darkLogImage,
                fit: BoxFit.cover,
                ),
              ),
            ),
            customCheckUserButton('user','${AppLocale.of(context).getTranslated('client')}', context),
            SizedBox(height:h*0.04,),
            customCheckUserButton('admin','${AppLocale.of(context).getTranslated('admin')}',context),
            SizedBox(height: h*0.08,),
          ],
        ),
      ),
    );
  }
}
