import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/trips_bloc.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/widgets/main_home_widget.dart';
import 'package:superjet/super_jet_app/auth/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/auth/presentation/bloc/states.dart';
import 'package:superjet/super_jet_app/auth/presentation/screens/chick_user.dart';
import 'package:superjet/super_jet_app/auth/presentation/screens/login.dart';
import 'package:superjet/super_jet_app/onBoarding/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/onBoarding/presentation/screens/onboarding_screen.dart';
import 'core/bloc_observer/bloc_observer.dart';
import 'core/services/services_locator.dart';
import 'core/shared_preference/shared_preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/utils/constants.dart';
void main() async{
  Stripe.publishableKey=App.publishableKey;
  ServicesLocator().init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget widget;
  var onBoarding = await CacheHelper.getDate(key: 'onBoarding');
  var  type = await CacheHelper.getDate(key: 'type');
   var isLog = await CacheHelper.getDate(key: 'isLog');
   var uId = await CacheHelper.getDate(key: 'uId');

  print(type);
  print(isLog);
  print(uId);
  if(onBoarding != null)
  {
    if(type !=null){
      if(isLog !=null){
        widget = const CustomMain();
      }else{
        widget = LoginScreen(type: type,);
      }
    }
    else{
      widget =const ChickUsers();
    }

  }
  else{
    widget = const OnBoardingScreen();
  }

  runApp( MyApp(widget: widget,));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.widget});
  final Widget widget;
  @override
  Widget build( context) {
  return
      MultiBlocProvider(
        providers: [
           BlocProvider(create: (context) => AppOnBoardingCubit()),
           BlocProvider(create: (context)=>AuthCubit(sl()),),
           BlocProvider(create: (context)=>AuthCubit(sl())..getPermission(),),
           BlocProvider(create: (context)=>TripsBloc(sl())..add(GetProfileEvent(context))..add(GetCategoriesTripsEvent())..add(GetTripsEvent('All',context))),
           BlocProvider(create: (context)=>SuperCubit(sl()),),
          // BlocProvider(create: (context)=>AppCubit()..getHomeData(context),),
          // BlocProvider(create: (context)=>AppCubit()..getHomeData(context),),
          // BlocProvider(create: (context)=>AppCubit()..getHomeData(context)..getCategories(context)..getFavoritesData(context)..getProfileData(context),),
        ],
        child:MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Super Jet',
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                primaryColor: const Color(0xffEABE67),
                appBarTheme:    const AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Color(0xffEABE67),
                    ),
                    elevation: 0
                )
              // useMaterial3: true,
            ),
            // themeMode: ThemeMode.light,
            // darkTheme:ThemeData(
            //     scaffoldBackgroundColor: Colors.black,
            //     primaryColor: const Color(0xff1c2860),
            //     appBarTheme: const AppBarTheme(
            //         systemOverlayStyle: SystemUiOverlayStyle(
            //           statusBarColor: Colors.blueGrey,
            //         ),
            //         elevation: 0
            //     )
            //   // useMaterial3: true,
            // ) ,
            home:widget
        ),
      );

  }
}
class CustomMain extends StatelessWidget {

  const CustomMain({super.key});
  @override
  Widget build(BuildContext context) {

    PersistentTabController controller = PersistentTabController(initialIndex: 0);

    return  SafeArea(
      child:
     BlocConsumer<AuthCubit,AppAuthStates>(
       builder: (context,state){
         var cubit =AuthCubit.get(context);
         return  Scaffold(
           bottomNavigationBar:
           PersistentTabView(
             context,
             controller: controller,
             screens: cubit.isKnowType =="user"?AppHomeWidgets.userScreens:AppHomeWidgets.adminScreens,
             items: cubit.isKnowType =="user"?AppHomeWidgets.userNavBarsItems(context):AppHomeWidgets.adminNavBarsItems(context),
             confineInSafeArea: true,
             backgroundColor: Colors.white, // Default is Colors.white.
             handleAndroidBackButtonPress: true, // Default is true.
             resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
             stateManagement: false, // Default is true.
             hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
             decoration: NavBarDecoration(
               borderRadius: BorderRadius.circular(10.0),
               colorBehindNavBar: Colors.white,
             ),
             popAllScreensOnTapOfSelectedTab: true,
             popActionScreens: PopActionScreensType.all,
             itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
               duration: Duration(milliseconds: 200),
               curve: Curves.ease,
             ),
             screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
               animateTabTransition: true,
               curve: Curves.ease,
               duration: Duration(milliseconds: 200),
             ),

             navBarStyle: NavBarStyle.style3, // Choose the nav bar style with this property.
           ),
         );
       },
       listener: (context,state){},
     )
    );
  }
}