
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/core/global/localization/appLocale.dart';
import 'package:superjet/core/utils/enums.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/profile/profile.dart';
import 'package:superjet/super_jet_app/auth/data/models/user_model.dart';
import '../../../../../core/services/routeing_page/routing.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../auth/presentation/widgets/widget.dart';
import '../../bloc/cubit.dart';
import '../../bloc/trips_bloc.dart';
import '../../widgets/profile.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return
    BlocProvider(create: (context)=>TripsBloc(sl())..add(GetProfileEvent(context)),
    child:   BlocConsumer<TripsBloc,TripsState>(
      builder: (context,state){
        return  WillPopScope(
          onWillPop: () {
            NavigatePages.pushReplacePage(const Profile(), context);
            return Future.value(false);
          },
          child:
          Scaffold(
            appBar: AppBar(
              toolbarHeight: 50,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  context.read<TripsBloc>().add(GetProfileEvent(context));
                  NavigatePages.pushReplacePage(const Profile(), context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.black,
                ),
              ),
              title:  Text(
                '${getLang(context, 'editProfile')}',
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextButton(
                      onPressed: () {
                        var cubit = SuperCubit.get(context);
                        var c = context.read<TripsBloc>();
                        c.add(IsUpdatingEvent(true));
                        Future.delayed(const Duration(seconds: 4))
                            .then((value) => {
                          c.add(UpdateProfileEvent(
                            cubit.controllerName.text,
                            userModel.name,
                            cubit.controllerPhone.text,
                            userModel.phone,
                            cubit.coverImageFilepath,
                            userModel.coverImage!,
                            cubit.profileImageFilepath,
                            userModel.profileImage!,
                            context,
                          )),
                        }).then((value) {
                          cubit.controllerName.text='';
                          cubit.controllerPhone.text='';
                          NavigatePages.pushReplacePage( const Profile(), context);
                        });
                      },
                      child:  Text(
                        '${getLang(context, 'UPDATE')}',
                        style:
                        const TextStyle(color: Colors.blue, fontSize: 18),
                      )),
                )
              ],
            ),
            body: SingleChildScrollView(
                child:Column(
                  children: [
                    state.isUpdating == true
                        ?const LinearProgressIndicator(): const SizedBox(),
                    SizedBox(
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
            ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                      child:
                      customTextField(
                        isPassword: false,
                        context: context,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {}
                          return null;
                        },
                        controller: SuperCubit.get(context).controllerName,
                        hintText: '${getLang(context, 'nameHintText')}',
                        iconData: Icons.person,
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                      child: customTextField(
                        isPassword: false,
                        context: context,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty) {}
                          return null;
                        },
                        controller: SuperCubit.get(context).controllerPhone,
                        hintText: '${getLang(context, 'phone')}',
                        iconData: Icons.phone,
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                )

            ),
          ),
        );

      },
      listener: (context,state){},
    ),
    );
  }
}
