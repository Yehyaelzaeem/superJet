
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/trips_bloc.dart';
import '../../../../core/services/routeing_page/reoute.dart';
import '../../../../core/services/services_locator.dart';
import '../../../auth/presentation/screens/login.dart';
import '../screens/recent_trips.dart';
import '../screens/edit_profile.dart';


Widget customProfileDesign(TripsState state,context){
  return SingleChildScrollView(
    child: Column(
      children: [
        profileImageWidget(state.userModel!.coverImage, state.userModel!.profileImage),
        Center(
            child: Text(state.userModel!.name,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            )),
        Center(
            child: Text(state.userModel!.email, style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 11),
            )),
        Center(
            child: Text(state.userModel!.phone != 'null' ? state.userModel!.phone : '',
              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 10),
            )),
        const SizedBox(height: 10,),
        customRowDateProfile('12','260.0','8.5'),
        const SizedBox(height: 15,),
        customProfileWidgets(state,context),
      ],
    ),
  );
}



Widget customProfileWidgets(TripsState state,context){
  return Column(
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
                border: Border.all(
                    color: Colors.grey.shade400, width: 1)),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                ' The Wallet',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
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
                NavigatePages.pushReplacePage(const EditProfileScreen(), context);
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.blue,
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
            NavigatePages.pushToPage(RecentTrips(tripIdLis: state.userModel!.tripIdList!), context);
          },
          child: const Text(
            'Recent Trips',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18),
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
          onPressed: () {},
          child: const Text(
            'Payment',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18),
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
            TripsBloc c =TripsBloc(sl());
             c.add(SignOutEvent(context));
            NavigatePages.persistentNavBarNavigator(const LoginScreen(),context);
          },
          child: const Text(
            'Sign Out',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
    ],
  );
}



Widget customRowDateProfile(String trips,String wallet ,String r){
  return   Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      customColumInRow('Trips',trips,),
      customColumInRow('Wallet',wallet,),
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
Widget customEditeProfileDesign(TripsState state){
  return  BlocBuilder<TripsBloc,TripsState>(builder: (context,state){
    return     SizedBox(
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
                    Image.network(state.userModel!.coverImage!,
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
                      NetworkImage(state.userModel!.profileImage!)
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

  })  ;

}
