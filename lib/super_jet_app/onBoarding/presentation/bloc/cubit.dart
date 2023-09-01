import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/super_jet_app/onBoarding/presentation/bloc/states.dart';
import '../../../../core/services/routeing_page/reoute.dart';
import '../../../../core/shared_preference/shared_preference.dart';
import '../../../auth/presentation/screens/chick_user.dart';
import '../../data/data_sources/local_database.dart';
import '../../data/models/model.dart';
import '../../data/repositories/repo.dart';
import '../../domain/repositories/base_repo.dart';
import '../../domain/use_cases/use_case.dart';

class AppOnBoardingCubit extends Cubit<AppOnBoardingStates>{


  AppOnBoardingCubit() : super(AppInitialOnBoardingStates()){
     BaseLocalDataBase baseLocalDataBase =LocalDataBase();
     BaseOnBoardingRepo baseOnBoardingRepo =OnBoardingRepo(baseLocalDataBase);
     list= OnBoardingUseCase(baseOnBoardingRepo).getOnBoarding();
     emit(AppGetData());
  }



  static AppOnBoardingCubit get(context)=>BlocProvider.of(context);
  List<OnBoardingModel> list=[];
  int page =0;
  void changingPageView(context){
    if(page == list.length-1){
      CacheHelper.saveDate(key: 'onBoarding', value: true).then((value) =>
       {
          NavigatePages.pushReplacePage(const ChickUsers(), context)
       });
    }
    else
    {
      pageController.nextPage(
          duration: const Duration(milliseconds: 1000), curve: Curves.easeInBack);
    }
    emit(AppChangingPageView());
  }

  PageController pageController=PageController();

}