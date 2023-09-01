import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/core/services/routeing_page/reoute.dart';
import 'package:superjet/core/utils/enums.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/categories_details_screen.dart';
import '../../../../core/image/image.dart';
import '../../data/models/categories_model.dart';
import '../bloc/cubit.dart';
import '../bloc/state.dart';
import '../bloc/trips_bloc.dart';

List listOfCity = [
  'All',
  'Cairo',
  'Alex',
  'Port Saied',
  'mansoura',
  'الوجة البحري',
  'الوجة القبلي'
];

//CarouselSlider
Widget carouselSlider(context) => CarouselSlider(
        items: [
          Image.asset(
            AppImage.onBoarding1,
            fit: BoxFit.cover,
          ),
          Image.asset(
            AppImage.onBoarding2,
            fit: BoxFit.cover,
          ),
          Image.asset(
            AppImage.onBoarding3,
            fit: BoxFit.cover,
          ),
          Image.asset(
            AppImage.onBoarding4,
            fit: BoxFit.cover,
          ),
          Image.asset(
            AppImage.onBoarding4,
            fit: BoxFit.cover,
          ),
        ],
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.35,
          viewportFraction: 2,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
        ));

//List OF City
Widget listOfCityWidget() => SizedBox(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listOfCity.length,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () {
                SuperCubit.get(context).chickIndex(true);
                SuperCubit.get(context).changeCategoriesIndex(i);
                 context.read<TripsBloc>().add(GetTripsEvent(listOfCity[i],context));
                Future.delayed(const Duration(seconds: 1)).then((value) =>{
                SuperCubit.get(context).chickIndex(false),
                });

              },
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child:
                    BlocConsumer<SuperCubit,AppSuperStates>(
                        builder: (context,state){
                          return Container(
                              decoration: BoxDecoration(
                                  color:
                                  SuperCubit.get(context).categoriesIndex==i?Theme.of(context).primaryColor:
                                  Colors.grey.shade300,
                                  borderRadius: const BorderRadius.all(Radius.circular(10))),
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Center(
                                child: Text(listOfCity[i],
                                    style: const TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold)),
                              ));

                        }, listener: (context,state){})
              ),
            );
          }),
    );

//Categories ListView Widget
Widget categoriesWidget(context) =>
    BlocBuilder<TripsBloc, TripsState>(
        builder: (context, state) {
      switch (state.categoriesState) {
        case RequestState.loading:
          return const SizedBox(
              height: 120,
              child: Center(
                child: CircularProgressIndicator(),
              ));
        case RequestState.loaded:
          return Container(
            margin: const EdgeInsets.only(left: 5),
            height: 130,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ConditionalBuilder(
                  condition: true,
                  builder: (context1) =>
                      InkWell(
                          onTap: (){

                              context.read<TripsBloc>().add(GetTestTripsEvent());
                              context.read<TripsBloc>().add(GetCustomFromTripsEvent(state.categoriesModelList[index].categoryName,context));
                              context.read<TripsBloc>().add(GetCustomToTripsEvent(state.categoriesModelList[index].categorySecondName,context));
                              NavigatePages.persistentNavBarNavigator( CategoriesDetailsScreen(categoriesModel: state.categoriesModelList[index],), context);
                          },
                          child: categoryWidget(context, state.categoriesModelList[index])),
                  fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      )),
              separatorBuilder: (context, i) => const SizedBox(
                width: 10,
              ),
              itemCount: state.categoriesModelList.length,
            ),
          );
        case RequestState.error:
          return const SizedBox(
              height: 120,
              child: Center(
                child: CircularProgressIndicator(),
              ));
      }
    });

//Category Widget
Widget categoryWidget(context, CategoriesModel tripsModel) => Padding(
  padding: const EdgeInsets.only(top: 8.0, bottom: 6.0, right: 3.0),
  child: Stack(
    children: [
      Container(
        width: 100,
        height: 110,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(color: Colors.black54, blurRadius: 2)
          ],
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            child: Image.network(
              tripsModel.image,
              fit: BoxFit.fill,
            )),
      ),
      Container(
        width: 100,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(17)),
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black54,
                  // Colors.black45,
                  Colors.black12,
                  Colors.transparent,
                ])),
      ),
      Positioned(
          left: 10,
          top: 70,
          right: 10,
          child: Center(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                tripsModel.name,
                maxLines: 2,
                style: const TextStyle(
                  shadows: [BoxShadow(color: Colors.black,blurRadius: 3)],
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
            ),
          ))
    ],
  ),
);

// row title
Widget rowTitleHome(String title) => Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
      ],
    );

//Linear
Widget customLinearProgressIndicatorHome(){
  return     BlocConsumer<SuperCubit,AppSuperStates>(
      builder: (context,state){
        return SuperCubit.get(context).x==true?
        Container(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child:  LinearProgressIndicator(
              color:Theme.of(context).primaryColor ,
              backgroundColor: Colors.yellow.shade100,
            )):
        const SizedBox();
      }, listener: (context,state){

  });
}