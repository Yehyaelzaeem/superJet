// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:superjet/core/services/routeing_page/routing.dart';
// import 'package:superjet/super_jet_app/app_layout/presentation/bloc/trips_bloc.dart';
// import 'package:superjet/super_jet_app/app_layout/presentation/screens/home.dart';
//
// import '../../../../core/services/services_locator.dart';
// import '../../../../core/utils/enums.dart';
//
// class BranchStarting extends StatelessWidget {
//   const BranchStarting({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       BlocProvider(
//         create: (context) => TripsBloc(sl())..add(GetProfileEvent(context)),
//         child: BlocBuilder<TripsBloc, TripsState>(builder: (context, state) {
//           if (state.userModel != null) {
//             switch (state.userModelState) {
//               case RequestState.loading:
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               case RequestState.loaded:
//                 return Scaffold(
//                   backgroundColor: Colors.grey.shade300,
//                   body: Center(
//                     child: InkWell(
//                       onTap: () {
//                         NavigatePages.pushReplacePage(Home(city: state.userModel!.city,), context);
//                       },
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.85,
//                         height: MediaQuery.of(context).size.height * 0.3,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             border: Border.all(color: Colors.black54, width: 1),
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(20)),
//                             boxShadow: const [
//                               BoxShadow(color: Colors.black54, blurRadius: 15)
//                             ]),
//                         child: Center(
//                           child: Text(
//                             'Start Work  \n at  ${state.userModel!.city}',
//                             textAlign: TextAlign.center,
//                             style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 35),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//
//               case RequestState.error:
//                 return const SizedBox(
//                     child: Center(
//                   child: CircularProgressIndicator(),
//                 ));
//             }
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         }));
//   }
// }
