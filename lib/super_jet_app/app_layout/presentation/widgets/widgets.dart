import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/routeing_page/reoute.dart';
import '../../../../core/utils/enums.dart';
import '../../data/models/trip_model.dart';
import '../bloc/trips_bloc.dart';
import '../screens/booked_screen.dart';



//trip Widget
Widget customTripWidget(context, TripsModel tripsModel) =>
    GestureDetector(
      onTap: (){
        NavigatePages.persistentNavBarNavigator(BookedScreen(tripsModel: tripsModel,), context);
      },
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 7)]),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            children: [
              Expanded(
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(18),
                            topLeft: Radius.circular(18),
                            bottomRight: Radius.circular(7),
                            bottomLeft: Radius.circular(7)),
                        child: Image.network(
                          tripsModel.image,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height * .25,
                          width: double.infinity,
                        ),
                      ),
                      tripsModel.isVip=="true"? Container(
                        decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(8))

                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 2),
                        child: const Text('VIP',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight:FontWeight.w600,
                              color: Colors.white
                          ),
                        ),
                      ):const SizedBox()
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5),
                child: Text(
                  tripsModel.name,
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tripsModel.date,
                      style: const TextStyle(
                          fontSize: 12, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Text(
                      tripsModel.time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        // decoration: TextDecoration.lineThrough,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    // Expanded(
                    //   child: IconButton(onPressed: (){
                    //     AppCubit.get(context).editeFavorites(productsModel.id, context);
                    //     // AppCubit.get(context).favorites[productsModel.id]= !AppCubit.get(context).favorites[productsModel.id]!;
                    //   }, icon:
                    //   AppCubit.get(context).favorites[productsModel.id] ==true ? Icon(Icons.favorite,color: Theme.of(context).primaryColor):
                    //   const Icon(Icons.favorite_border,color: Colors.grey,)),
                    // )
                  ],
                ),
              ),
              const SizedBox(height: 3,)
            ],
          ),
        ),
      ),
    );

//GridView Trips
Widget gridViewTrips(context,bool isCustom,bool isFrom) =>
    isCustom==true?
    isFrom==true?
    BlocBuilder<TripsBloc, TripsState>(
      builder: (context, state) {
        switch(state.tripsCustomFromState){
          case RequestState.loading:
            return const SizedBox(
                height:100,child: Center(child: CircularProgressIndicator(),));
          case RequestState.loaded:
            return
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1 / 1.2,
                  children: List.generate(state.customFromTripsModelList.length, (index) {
                    return customTripWidget(
                        context, state.customFromTripsModelList[index]);
                  }),
                ),
              );
          case RequestState.error:
            return const SizedBox(
                child: Center(
                  child: CircularProgressIndicator(),
                ));
        }
      },
    ):
    BlocBuilder<TripsBloc, TripsState>(
      builder: (context, state) {
        switch(state.tripsCustomToState){
          case RequestState.loading:
            return const SizedBox(
                height:100,child: Center(child: CircularProgressIndicator(),));
          case RequestState.loaded:
            return
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1 / 1.2,
                  children: List.generate(state.customToTripsModelList.length, (index) {
                    return customTripWidget(
                        context, state.customToTripsModelList[index]);
                  }),
                ),
              );
          case RequestState.error:
            return const SizedBox(
                child: Center(
                  child: CircularProgressIndicator(),
                ));
        }
      },
    )

        : BlocBuilder<TripsBloc, TripsState>(
      builder: (context, state) {
        switch(state.tripsState){
          case RequestState.loading:
            return const SizedBox(
                height:100,child: Center(child: CircularProgressIndicator(),));
          case RequestState.loaded:
            return
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1 / 1.2,
                  children: List.generate(state.tripsModelList.length, (index) {
                    return customTripWidget(
                        context, state.tripsModelList[index]);
                  }),
                ),
              );
          case RequestState.error:
            return const SizedBox(
                child: Center(
                  child: CircularProgressIndicator(),
                ));
        }
      },
    );

