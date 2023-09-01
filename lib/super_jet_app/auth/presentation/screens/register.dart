import 'package:flutter/material.dart';
import '../widgets/register_widget.dart';
import '../widgets/widget.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: customAuthDesignBackGround(customRegisterDesign(), context)
    );
  }
}
