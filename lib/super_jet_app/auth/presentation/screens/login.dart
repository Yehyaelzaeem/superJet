import 'package:flutter/material.dart';
import 'package:superjet/super_jet_app/auth/presentation/widgets/login_widget.dart';
import '../widgets/widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () {
        customDialogPopScope(context);
        return Future.value(false);
      },
      child: Scaffold(
        body: customAuthDesignBackGround(customLoginDesign(context),context,)
      ),
    );

  }
}
//            customLoginDesign(context),