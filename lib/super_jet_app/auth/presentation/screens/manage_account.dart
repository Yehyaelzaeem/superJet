// import 'package:flutter/material.dart';
// import 'package:superjet/super_jet_app/auth/presentation/bloc/cubit.dart';
// import 'package:superjet/super_jet_app/auth/presentation/widgets/widget.dart';
// import '../../../app_layout/presentation/widgets/widget.dart';
//
// class ManageAccount extends StatelessWidget {
//   const ManageAccount({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Theme.of(context).primaryColor,
//         leading: IconButton(
//           onPressed: (){
//             Navigator.of(context);
//           },
//           icon: const Icon(Icons.arrow_back_ios_rounded,color: Colors.black,),
//         ),
//       ),
//       body:
//        SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 50,),
//                 const Text('Change Email',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold
//                 ),
//                 ),
//                 const Text('Please enter your email for reset password',
//                   style: TextStyle(
//                       color: Colors.black54,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w400
//                   ),
//                 ),
//                 const SizedBox(height: 50,),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 8.0),
//                   child: Text('Email Address',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10,),
//                 Container(
//                   decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: const BorderRadius.all(Radius.circular(10))
//
//                   ),
//                   width: MediaQuery.of(context).size.width*0.9,
//                   child:
//                   customTextFieldProfile(
//                     context: context,
//                     keyboardType: TextInputType.name,
//                     textInputAction: TextInputAction.next,
//                     validator: (value){
//                     },
//                     controller: AuthCubit.get(context).resetPasswordController,
//                     hintText: 'Email',
//                     iconData: Icons.email_outlined,
//                     obscureText: false,
//                     onFieldSubmitted: (v){
//                       AuthCubit.get(context).resetPasswordController.text=v;
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 200,),
//                 Center(
//                   child: customAuthButton(context,
//                       0.7, "Reset Password",
//                           () {
//                             var cubit = AuthCubit.get(context);
//                               if(cubit.resetPasswordController.text.isNotEmpty){
//                               cubit.resetPassword(cubit.resetPasswordController.text, context);
//                             }
//                             else{
//                               showToast('Email address is empty', ToastStates.error, context);
//                             }
//                           }),
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
