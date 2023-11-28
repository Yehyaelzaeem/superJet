import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:superjet/core/global/localization/appLocale.dart';
import 'package:superjet/core/services/routeing_page/routing.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/state.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/trips_bloc.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/categories/categories.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/chat/chats.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/home/home.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/payment/payment_screen.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/profile/profile.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/widgets/main_home_widget.dart';
import 'package:superjet/super_jet_app/auth/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/auth/presentation/bloc/states.dart';
import 'package:superjet/super_jet_app/auth/presentation/screens/chick_user.dart';
import 'package:superjet/super_jet_app/auth/presentation/screens/login.dart';
import 'package:superjet/super_jet_app/auth/presentation/widgets/login_widget.dart';
import 'package:superjet/super_jet_app/onBoarding/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/onBoarding/presentation/screens/onboarding_screen.dart';
import 'core/bloc_observer/bloc_observer.dart';
import 'core/global/theme/theme_data/theme_data_dark.dart';
import 'core/global/theme/theme_data/theme_data_light.dart';
import 'core/image/image.dart';
import 'core/services/services_locator.dart';
import 'core/shared_preference/shared_preference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/utils/constants.dart';
import 'dart:io' show Platform;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}


void main() async {
  Stripe.publishableKey = App.publishableKey;
  ServicesLocator().init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  var lang = await CacheHelper.getDate(key: 'lang');
   if(lang ==null){
     CacheHelper.sharedPreference!.setString('lang', Platform.localeName.split('_')[0].toString());
   }

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.getToken().then((value)async {
    await CacheHelper.saveDate(key: 'token', value: value);
    print(value);
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  Bloc.observer = MyBlocObserver();
  Widget widget;

  var onBoarding = await CacheHelper.getDate(key: 'onBoarding');
  var type = await CacheHelper.getDate(key: 'type');
  var isLog = await CacheHelper.getDate(key: 'isLog');
  var uId = await CacheHelper.getDate(key: 'uId');
  var isDark = await CacheHelper.getDate(key: 'isDark');
  print(isDark);
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
    isDark: isDark??false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp( {super.key, required this.widget,required this.isDark});

  final Widget widget;
  final bool isDark;

  @override
  Widget build(context) {
    return
      MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppOnBoardingCubit()),
        BlocProvider(create: (context) => AuthCubit(sl()),),
        BlocProvider(create: (context) => AuthCubit(sl())..getPermission(),),
        BlocProvider(create: (context) => TripsBloc(sl())..add(GetCategoriesTripsEvent())..add(GetTripsEvent('All',context))..add(GetProfileEvent(context))),
        BlocProvider(create: (context) => SuperCubit(sl())..changeMode(isDark),),
      ],
      child:
      BlocConsumer<SuperCubit,AppSuperStates>(
        builder: (context,state){
        return MaterialApp(
          locale: SuperCubit.get(context).localeLanguage,
          localizationsDelegates: const [
             AppLocale.delegate,
             GlobalMaterialLocalizations.delegate,
             GlobalWidgetsLocalizations.delegate,
             GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('ar'), // Arabic
          ],
          debugShowCheckedModeBanner: false,
          title: 'Super Jet',
          theme: getThemeDataLight(),
          darkTheme: getThemeDataDark(),
          themeMode:

         SuperCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
          home: widget
        );
      },
      listener: (context,state){},
      )
    );
  }
}

class CustomMain extends StatefulWidget {
  const CustomMain({super.key});
  @override
  State<CustomMain> createState() => _CustomMainState();
}

class _CustomMainState extends State<CustomMain> {
  @override
  initState(){
    onMessageAndOpenedApp();
    onMessageNotification();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    cubit.getType();
    PersistentTabController controller = PersistentTabController(initialIndex: 0);
    return
      OfflineBuilder(
          connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,)
          {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return SafeArea(
                child:
                Scaffold(
                  body:
                  BlocConsumer<AuthCubit,AppAuthStates>(
                    builder: (context, state) {
                      return WillPopScope(
                          onWillPop: () {
                            customDialogPopScope(context);
                            return Future.value(false);
                          },
                          child:
                          ConditionalBuilder(
                              condition: cubit.type.isNotEmpty,
                              builder: (context){
                                return PersistentTabView(
                                  context,
                                  controller: controller,
                                  screens:
                                  cubit.type == "user"
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
                                  backgroundColor:Theme.of(context).scaffoldBackgroundColor,
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
                                  navBarStyle: NavBarStyle.style3, // Choose the nav bar style with this property.
                                );
                              },
                              fallback: (context)=>const Center(child: CircularProgressIndicator(),))
                      );
                    },
                    listener: (context, state) {},
                  ),
                ),
              );
            } else {
              return Scaffold(
                backgroundColor: Theme.of(context).primaryColor,
                body: Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height*0.5,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(AppImage.offline,fit: BoxFit.cover,),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: const EdgeInsets.all(20),
                      child: const Text(
                        "Can't Connect ....Check Your Internet",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              );
            }
          },
          child: const Center(child: CircularProgressIndicator()));

  }

  onMessageAndOpenedApp(){
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        if(message.data['type']=='chat'){
          setState(() {
            SuperCubit.get(context).listOfChats.add(1);
            SuperCubit.get(context).listOfChatSetting.add(1);
            SuperCubit.get(context).listOfChat.add(1);
            SuperCubit.get(context).listOfNameChats.add(message.notification!.title!.trim());
          });

        }
        else if(message.data['type']=='all'){
          setState(() {
            SuperCubit.get(context).listOfChatSetting.add(1);
          });
        }
      }

    });

  }
  onMessageNotification(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        if(message.data['type']=='chat'){
          setState(() {
            SuperCubit.get(context).listOfChatSetting.add(1);
            SuperCubit.get(context).listOfChats.add(1);
            SuperCubit.get(context).listOfChat.add(1);
            SuperCubit.get(context).listOfNameChats.add(message.notification!.title!.trim());
          });
        }else if(message.data['type']=='all'){
          setState(() {
            SuperCubit.get(context).listOfChatSetting.add(1);
          });
        }
      }

    });

  }

}
