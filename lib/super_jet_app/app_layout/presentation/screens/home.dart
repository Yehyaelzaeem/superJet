import 'package:flutter/material.dart';
import '../widgets/home_widgets.dart';
import '../widgets/widgets.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  carouselSlider(context),
                  const SizedBox(height: 8,),
                  listOfCityWidget(),
                  rowTitleHome('Categories'),
                  categoriesWidget(context),
                  rowTitleHome('Trips'),
                  customLinearProgressIndicatorHome(),
                  const SizedBox(height: 8,),
                  gridViewTrips(context,false,false),
                ],
              ),
            )
        );
  }
}
