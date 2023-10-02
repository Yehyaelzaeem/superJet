import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/trips_bloc.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/categories.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/chat_details.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/chats.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/home.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/payment_screen.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/profile.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/widgets/main_home_widget.dart';
import 'package:superjet/super_jet_app/auth/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/auth/presentation/bloc/states.dart';
import 'package:superjet/super_jet_app/auth/presentation/screens/chick_user.dart';
import 'package:superjet/super_jet_app/auth/presentation/screens/login.dart';
import 'package:superjet/super_jet_app/auth/presentation/widgets/login_widget.dart';
import 'package:superjet/super_jet_app/onBoarding/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/onBoarding/presentation/screens/onboarding_screen.dart';
import 'core/bloc_observer/bloc_observer.dart';
import 'core/services/services_locator.dart';
import 'core/shared_preference/shared_preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/utils/constants.dart';
import 'core/utils/enums.dart';

void main() async {
  Stripe.publishableKey = App.publishableKey;
  ServicesLocator().init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget widget;
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [ SystemUiOverlay.top ]);
  var onBoarding = await CacheHelper.getDate(key: 'onBoarding');
  var type = await CacheHelper.getDate(key: 'type');
  var isLog = await CacheHelper.getDate(key: 'isLog');
  var uId = await CacheHelper.getDate(key: 'uId');

  print(type);
  print(isLog);
  print(uId);
  if (onBoarding != null) {
    if (type != null) {
      if (isLog != null) {
        widget = const CustomMain();
      } else {
        widget = LoginScreen(
          type: type,
        );
      }
    } else {
      widget = const ChickUsers();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.widget});

  final Widget widget;

  @override
  Widget build(context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppOnBoardingCubit()),
        BlocProvider(
          create: (context) => AuthCubit(sl()),
        ),
        BlocProvider(
          create: (context) => AuthCubit(sl())..getPermission(),
        ),
        BlocProvider(
            create: (context) => TripsBloc(sl())
              ..add(GetProfileEvent(context))
              ..add(GetCategoriesTripsEvent())),
        BlocProvider(
          create: (context) => SuperCubit(sl()),
        ),
        // BlocProvider(create: (context)=>AppCubit()..getHomeData(context),),
        // BlocProvider(create: (context)=>AppCubit()..getHomeData(context),),
        // BlocProvider(create: (context)=>AppCubit()..getHomeData(context)..getCategories(context)..getFavoritesData(context)..getProfileData(context),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Super Jet',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: const Color(0xffEABE67),
            appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  systemNavigationBarColor: Colors.white,
                  statusBarColor: Color(0xffEABE67),
                ),
                elevation: 0)
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
        home: widget,
      ),
    );
  }
}

class CustomMain extends StatelessWidget {
  const CustomMain({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    cubit.getType();
    SuperCubit.get(context).getType();
    PersistentTabController controller = PersistentTabController(initialIndex: 0);
    return SafeArea(
        child: Scaffold(
      body:  BlocConsumer<AuthCubit, AppAuthStates>(
        builder: (context, state1) {
          return WillPopScope(
            onWillPop: () {
              customDialogPopScope(context);
              return Future.value(false);
            },
            child: ConditionalBuilder(
                condition: cubit.type.isNotEmpty,
                //&& cubit.city.isNotEmpty,
                builder: (context) {
                  return PersistentTabView(
                    context,
                    controller: controller,
                    screens: cubit.type == "user"
                        ? AppHomeWidgets.userScreens
                        : cubit.type == "admin"
                        ? AppHomeWidgets.adminScreens
                        : [
                      const Home(city: 'cairo'),
                      const Categories(),
                      const PaymentScreen(),
                      const Profile(),
                    ],
                    items: cubit.type == "user"
                        ? AppHomeWidgets.userNavBarsItems(context)
                        : cubit.type == "admin"
                        ? AppHomeWidgets.adminNavBarsItems(
                        context)
                        : AppHomeWidgets.branchNavBarsItems(
                        context),
                    confineInSafeArea: true,
                    backgroundColor: Colors.white,
                    // Default is Colors.white.
                    handleAndroidBackButtonPress: true,
                    // Default is true.
                    resizeToAvoidBottomInset: true,
                    // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
                    stateManagement: false,
                    // Default is true.
                    hideNavigationBarWhenKeyboardShows: true,
                    // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
                    decoration: NavBarDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      colorBehindNavBar: Colors.white,
                    ),
                    popAllScreensOnTapOfSelectedTab: true,
                    popActionScreens: PopActionScreensType.all,
                    itemAnimationProperties:
                    const ItemAnimationProperties(
                      // Navigation Bar's items animation properties.
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease,
                    ),
                    screenTransitionAnimation:
                    const ScreenTransitionAnimation(
                      // Screen transition animation on change of selected tab.
                      animateTabTransition: true,
                      curve: Curves.ease,
                      duration: Duration(milliseconds: 200),
                    ),

                    navBarStyle: NavBarStyle
                        .style3, // Choose the nav bar style with this property.
                  );
                },
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.yellowAccent,

                  ),
                )),
          );
        },
        listener: (context, state) {},
      ),
    ));
  }
}
