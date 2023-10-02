import 'package:flutter/material.dart';
import '../../../../core/image/image.dart';

Widget customAuthDesignBackGround(Widget designScreen, context,) =>
    Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: double.infinity,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(200),
                    ),
                    color: Theme.of(context).primaryColor),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                width: 200,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(205),
                  ),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Expanded(
                child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(120),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 50, top: 0),
                    height: 190,
                    child: Image.asset(
                      AppImage.logImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            )),
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100),
                  ),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        designScreen,
      ],
    );

Widget customTitleScreen(String title,Color color)=>
    Text(title,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: color
      ),
    );

Future signInWithFacebook(context) async {
  // try {
  //   final LoginResult result = await FacebookAuth.instance
  //       .login(); // by default we request the email and the public profile
  //
  //   if (result.status == LoginStatus.success) {
  //
  //     final AccessToken accessToken = result.accessToken!;
  //   } else {
  //
  //   }
  // } catch (e) {
  //   showToast(e.toString(), ToastStates.error, context);
  //
  // }
  // Trigger the sign-in flow
  // final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email', 'public_profile'],loginBehavior:LoginBehavior.nativeWithFallback );
  //
  // // Create a credential from the access token
  // final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
  // print(facebookAuthCredential.idToken);
  // print(facebookAuthCredential.secret);
  // print(facebookAuthCredential.signInMethod);
  // // Once signed in, return the UserCredential
  // return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}

Widget customAuthButton(context, double x, String text, void Function()? onPressed) =>
    SizedBox(
      width: MediaQuery.of(context).size.width * x,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.black,
          elevation: 15,
          backgroundColor: Theme.of(context).primaryColor,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 17),
        ),
      ),
    );

Widget customTextField(
        {bool? isPassword,
        context,
        TextInputType? keyboardType,
        TextInputAction? textInputAction,
        String? Function(String?)? validator,
        TextEditingController? controller,
        String? hintText,
        IconData? iconData,
        Color? colorIcon =Colors.white,
        Color? hintTextColor =Colors.white,
        Color? textColor =Colors.white,
        bool? obscureText,
        Widget? suffixIcon,
       void Function()? onTap,

        void Function(String)? onFieldSubmitted}) =>

    TextFormField(
      onTap: onTap,
      textAlignVertical: TextAlignVertical.center,
      textInputAction: textInputAction,
      validator: validator,
      keyboardType: keyboardType,
      controller: controller,
      style:  TextStyle(color:textColor, fontSize: 16,),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:  TextStyle(fontSize: 15, color: hintTextColor),
        prefixIcon: Icon(
          iconData,
          color: colorIcon,
        ),
        errorBorder: InputBorder.none,
        border: InputBorder.none,
        suffixIcon: isPassword == true ? suffixIcon : null,
      ),
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText!,
    );

