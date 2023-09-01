import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/trips_bloc.dart';
import '../../../../core/services/routeing_page/reoute.dart';
import '../widgets/categories_widgets.dart';
import 'categories_details_screen.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar:AppBar(
          backgroundColor: Theme.of(context).primaryColor,
            title: const Center(child: Text('Categories')),
            actions: [
              IconButton(onPressed: (){},
                icon: const Icon(Icons.search),),
            ],
            elevation: 0,
        ),
        body: BlocBuilder<TripsBloc,TripsState>(
    builder: (context,state){
      return   ListView.separated(
          itemBuilder: (context,i){
            return InkWell(
                onTap: (){
                  context.read<TripsBloc>().add(GetTestTripsEvent());
                  context.read<TripsBloc>().add(GetCustomFromTripsEvent(state.categoriesModelList[i].categoryName,context));
                  context.read<TripsBloc>().add(GetCustomToTripsEvent(state.categoriesModelList[i].categorySecondName,context));
                  NavigatePages.persistentNavBarNavigator(CategoriesDetailsScreen(categoriesModel: state.categoriesModelList[i]), context);
                },
                child: rowCategories(context,state.categoriesModelList[i]));
          },
          separatorBuilder: (context ,i){
            return const SizedBox(height: 10,);
          },
          itemCount: state.categoriesModelList.length);
       }),

     );
  }
}
