import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';
import '../widgets/widges.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<AppOnBoardingCubit, AppOnBoardingStates>(
        builder: (context, state) {
          return Scaffold(
              body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                            controller: AppOnBoardingCubit.get(context).pageController,
                            physics: const BouncingScrollPhysics(),
                            onPageChanged: (int index){
                               AppOnBoardingCubit.get(context).page=index;
                            },
                            itemCount: AppOnBoardingCubit.get(context).list.length,
                            itemBuilder: (context, i) {
                              return customPageViewColum(AppOnBoardingCubit.get(context).list[i],context);
                            }),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          SmoothPageIndicator(
                              controller: AppOnBoardingCubit.get(context).pageController,
                              count:AppOnBoardingCubit.get(context).list.length,
                            effect: ExpandingDotsEffect(
                              activeDotColor: Theme.of(context).primaryColor,
                              dotColor: const Color(0xffe4e9ff),
                              expansionFactor: 2.5,
                              dotHeight: 10,
                            ),
                          ),
                          const Spacer(),
                          FloatingActionButton(
                            onPressed: () {
                              AppOnBoardingCubit.get(context).changingPageView(context);
                            },
                            backgroundColor: Theme.of(context).primaryColor,
                            child: const Icon(Icons.arrow_forward_ios),
                          )
                        ],
                      )
                    ],
                  )));
        },
        listener: (context, state) {},
      );
  }
}
