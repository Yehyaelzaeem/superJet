import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/core/services/routeing_page/reoute.dart';
import 'package:superjet/core/utils/enums.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/profile.dart';
import 'package:superjet/super_jet_app/auth/presentation/widgets/widget.dart';
import '../../../../core/services/services_locator.dart';
import '../bloc/cubit.dart';
import '../bloc/trips_bloc.dart';
import '../widgets/profile.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripsBloc, TripsState>(
        builder: (context, state) {
      switch (state.userModelState) {
        case RequestState.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case RequestState.loaded:
          TripsBloc c = TripsBloc(sl());
          return state.userModel != null ?
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
                    title: const Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.black, fontSize: 20),
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
                                          state.userModel!.name,
                                          cubit.controllerPhone.text,
                                          state.userModel!.phone,
                                          cubit.coverImageFilepath,
                                          state.userModel!.coverImage!,
                                          cubit.profileImageFilepath,
                                          state.userModel!.profileImage!,
                                          context,
                                        )),
                                      }).then((value) {
                                      NavigatePages.pushReplacePage(const Profile(), context);
                              });
                              c.add(GetProfileEvent(context));
                            },
                            child: const Text(
                              'UPDATE',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            )),
                      )
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        state.isUpdating == true
                            ?const LinearProgressIndicator(): const SizedBox(),
                        customEditeProfileDesign(state),
                        const SizedBox(
                          height: 50,
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
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {}
                              return null;
                            },
                            controller: SuperCubit.get(context).controllerName,
                            hintText: 'name',
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
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {}
                              return null;
                            },
                            controller: SuperCubit.get(context).controllerPhone,
                            hintText: 'phone',
                            iconData: Icons.phone,
                            obscureText: false,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                )
              : Container(color: Colors.white,
                child: const Center(
                    child: CircularProgressIndicator(),
                  ),
              );
        case RequestState.error:
          return const Center(
            child: Text("Error"),
          );
      }
    },
        listener: (context,state){},
    );
  }
}
/*
Scaffold(
        appBar:

        body:
 */
