import 'package:flutter/material.dart';
import 'package:superjet/super_jet_app/auth/presentation/widgets/chick_user.dart';
import '../../../../core/image/image.dart';
import '../widgets/login_widget.dart';

class ChickUsers extends StatelessWidget {
  const ChickUsers({super.key});

  @override
  Widget build(BuildContext context) {
    var h =MediaQuery.of(context).size.height;
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
            SizedBox(height: h*0.01,),
            Expanded(
              child: Center(
                child:
                Image.asset(AppImage.onBoarding1,
                fit: BoxFit.cover,
                ),
              ),
            ),
            customCheckUserButton('user', context),
            SizedBox(height:h*0.04,),
            customCheckUserButton('admin',context),
            SizedBox(height: h*0.08,),
          ],
        ),
      ),
    );
  }
}
