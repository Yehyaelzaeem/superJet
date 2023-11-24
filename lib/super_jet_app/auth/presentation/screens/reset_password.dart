import 'package:flutter/material.dart';
import '../widgets/reset_widget.dart';
import '../widgets/widget.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: 
        customAuthDesignBackGround(customResetDesign(context), context)
   );
  }
}
