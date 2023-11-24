import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/core/utils/enums.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/trips_bloc.dart';
import 'package:superjet/super_jet_app/auth/data/models/user_model.dart';
import '../../../../core/services/routeing_page/routing.dart';
import '../../../../core/services/services_locator.dart';
import '../../../auth/presentation/screens/login.dart';
import '../../../auth/presentation/widgets/widget.dart';
import '../bloc/state.dart';
import '../screens/chat/chats.dart';
import '../screens/profile/recent_trips.dart';
import '../screens/profile/edit_profile.dart';

import 'package:badges/badges.dart' as badges;

Widget customProfileDesign(TripsState state,context){
  return SingleChildScrollView(
    child: Column(
      children: [
        profileImageWidget(state.userModel[0].coverImage, state.userModel[0].profileImage),
        Center(
            child: Text(state.userModel[0].name,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            )),
        Center(
            child: Text(state.userModel[0].email, style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 11),
            )),
        Center(
            child: Text(state.userModel[0].phone != 'null' ? state.userModel[0].phone : '',
              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 10),
            )),
        const SizedBox(height: 10,),
        customRowDateProfile(state.userModel[0].tripIdList!.length.toString(),state.userModel[0].wallet,'8.5'),
        const SizedBox(height: 15,),
        customProfileWidgets(state,context),
      ],
    ),
  );
}



Widget customProfileWidgets(TripsState state,context){
  return
  Theme(data: ThemeData(
    textButtonTheme:  TextButtonThemeData(
        style: ButtonStyle(
            backgroundColor:MaterialStateProperty.all(Colors.transparent),
        )
    ),
        ),
      child:   Column(
    children: [
      Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.68,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                    Radius.circular(10)),
                border: Border.all(color: Colors.grey.shade400, width: 1)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: TextButton(
              onPressed: () {},
              child:  Text(
                ' The Wallet',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                    Radius.circular(10)),
                border: Border.all(
                    color: Colors.grey.shade400, width: 1)),
            child: IconButton(
              onPressed: () {
                NavigatePages.pushReplacePage( EditProfileScreen(userModel: state.userModel[0],), context);
              },
              icon:  Icon(
                Icons.edit,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
        ],
      ),
      const SizedBox(height: 10,),
      Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius:
            const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
                color: Colors.grey.shade400, width: 1)),
        child: TextButton(
          onPressed: () {
            NavigatePages.pushReplacePage(RecentTrips(tripIdLis: state.userModel[0].tripIdList!), context);
          },
          child:  Text(
            'Recent Trips',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius:
            const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
                color: Colors.grey.shade400, width: 1)),
        child: TextButton(
          onPressed: () {

            SuperCubit.get(context).getAdminDate(context);
            SuperCubit.get(context).getBranches(context);
            SuperCubit.get(context).getUsers();
            NavigatePages.persistentNavBarNavigator(Chats(userModel: state.userModel[0],), context);

          },
          child:
          BlocConsumer<SuperCubit,AppSuperStates>(builder: (context1, state) {
            return
              SuperCubit.get(context1).listOfChat.isNotEmpty?
              badges.Badge(
                badgeContent: Text(SuperCubit.get(context1).listOfChat.length.toString(),style: const TextStyle(color: Colors.white),),
                badgeStyle:const badges.BadgeStyle(badgeColor: Colors.red) ,
                child:  Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    'Chats',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ):
              Text(
                'Chats',
                style: Theme.of(context).textTheme.labelLarge,
              );
          },
            listener: (context, state){},),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius:
            const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
                color: Colors.grey.shade400, width: 1)),
        child: TextButton(
          onPressed: () {
            // TripsBloc c =TripsBloc(sl());
            //  c.add(SignOutEvent(context));
            // NavigatePages.persistentNavBarNavigator(LoginScreen(type: SuperCubit.get(context).type,),context);
          },
          child:  Text(
            'Offers %',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
    ],
  ));
}
Future customBottomSheetChangeEmail({required String title,required String text,required String hintText,
  required IconData? iconData,required IconData? iconTitle,required void Function()? onTap,required context}){
  var c =SuperCubit.get(context);
  var m =MediaQuery.of(context).size;
  return  showModalBottomSheet(
      elevation:5.5,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: m.height*0.07,),
               Icon(iconTitle,size: 100,),
               Center(child: Text(title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              ),),
                SizedBox(height: m.height*0.07,),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child:  Text(text),
                ),
                 SizedBox(height:  m.height*0.01,),
                Container(
                width: m.width * 0.85,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(30))),
                child: customTextField(
                      isPassword: false,
                      context: context,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isEmpty) {}
                        return null;
                      },
                      controller: SuperCubit.get(context).controllerName,
                      hintText: hintText,
                      iconData: iconData,
                      colorIcon: Colors.black54,
                      hintTextColor: Colors.black54,
                      textColor: Colors.black,
                      obscureText: false,
             ),
              ),
                 SizedBox(height: m.height*0.07,),

                 InkWell(
              onTap: onTap,
              child: Container(
                height:
                m.width * 0.115,
                width:m.width * 0.82,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    boxShadow: const [BoxShadow(color: Colors.black54,blurRadius: 5)],
                    borderRadius: const BorderRadius.all(
                        Radius.circular(30))),
                child: const Center(
                    child: Text(
                      'Update',
                      style: TextStyle(
                          color: Colors.white,
                          shadows:  [BoxShadow(color: Colors.black54,blurRadius: 4)],
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
                SizedBox(height: m.height*0.025,),
                InkWell(
                  onTap: (){
                    c.controllerName.text='';
                    Navigator.pop(context);
                  },
                  child: Container(
                    height:
                    MediaQuery.of(context).size.width *
                        0.115,
                    width: MediaQuery.of(context).size.width *
                        0.82,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        boxShadow: const [BoxShadow(color: Colors.black54,blurRadius: 5)],
                        borderRadius: const BorderRadius.all(
                            Radius.circular(30))),
                    child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: Colors.white,
                              shadows:  [BoxShadow(color: Colors.black54,blurRadius: 4)],
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                SizedBox(height: m.height*0.07,),

              ],
            ),
          ),
        );
      });
}


Widget customRowDateProfile(String trips,String wallet ,String r){
  return   Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      customColumInRow('Trips',trips,),
      customColumInRow('The Wallet','$wallet EG',),
      customColumInRow('Rate',r,),
    ],
  );
}
Widget customColumInRow(String title,String number){
  return   Column(
    children: [
      Text(
        number,
        style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        title,
        style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
    ],
  );
}



Widget profileImageWidget(String? coverImage,String? profileImage)=>
    SizedBox(
      width: double.infinity,
      height: 340,
      child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: Container(
                width: double.infinity,
                height: 260,
                decoration:  BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                  image: DecorationImage(
                    image: NetworkImage(coverImage!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            CircleAvatar(
              radius: 75,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius:70,
                backgroundImage:
                NetworkImage(profileImage!),

              ),),
          ]
      ),
    );

//Edite Profile Widgets
Widget customEditeProfileDesign(TripsState state,UserModel userModel){
  return
    BlocBuilder(builder: (context,state5){
      return SizedBox(
        width: double.infinity,
        height: 320,
        child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Container(
                      width: double.infinity,
                      height: 260,
                      decoration:  const BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                      ),
                      child:
                      state.coverImageFile !=null?
                      Image.file(state.coverImageFile!,fit: BoxFit.cover,):
                      Image.network(userModel.coverImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child:
                    CircleAvatar(
                      backgroundColor: Colors.blue.shade300,
                      radius: 20,
                      child: IconButton(
                        onPressed: (){
                          context.read<TripsBloc>().add(EditCoverImageEvent(context));
                        },
                        icon: const Icon(Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 23,),
                      ),
                    ),
                  )
                ],
              ),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  state.profileImageFile !=null?
                  CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                        radius:70,
                        backgroundImage:
                        FileImage(state.profileImageFile!)
                    ),):
                  CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                        radius:70,
                        backgroundImage:
                        NetworkImage(userModel.profileImage!)
                    ),),
                  Positioned(
                    bottom: 13,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue.shade300,
                      radius: 20,
                      child: IconButton(
                        onPressed: (){
                          context.read<TripsBloc>().add(EditProfileImageEvent(context));
                        },
                        icon: const Icon(Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 23,),
                      ),
                    ),
                  ),
                ],
              ),
            ]
        ),
      );
    });

}
