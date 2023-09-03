import 'package:flutter/material.dart';
import 'package:superjet/core/image/image.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/trips_bloc.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/cart_trips_details.dart';
import '../../../../core/services/routeing_page/reoute.dart';
import '../../data/models/trip_model.dart';

Widget customPaymentDetails(List<TripsModel> listTrips,List chairsList,double total,double subTotal,double tax,double discount,context)
{
  List<TripsModel> resList=[];
  List resChairsList=[];

  for (var a=0;a<= listTrips.length-1; a++) {
    if(resList.contains(listTrips[a])){
     var i = resList.indexWhere((innerElement)  => innerElement == listTrips[a]);
     resChairsList[i] +=1;
    }else{
      resList.add(listTrips[a]);
      resChairsList.add(1);
    }
  }
  var m =MediaQuery.of(context).size;
  Color colorTextBase = Colors.black54;
  Color colorText = Colors.black;
  return
    Container(
      decoration:  BoxDecoration(
          boxShadow:  const [BoxShadow(color: Colors.black87,blurRadius: 5)],
          color:Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          )
      ),
      height: m.height*0.37,
      child:
      Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom:18.0),
              child: SizedBox(
                height: 150,
                child: Image.asset(AppImage.paymentImage),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0,right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: m.height*0.022,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text('Trips name',
                        style:  TextStyle(
                            color: colorTextBase,
                            fontWeight: FontWeight.w600
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Expanded(
                        flex: 1,
                        child: SizedBox()),
                    Expanded(
                      flex: 1,

                      child: Text('*',
                        style: TextStyle(
                            color: colorTextBase,
                            fontWeight: FontWeight.w600
                        ),),
                    ),
                    const Expanded(
                        flex: 1,
                        child: SizedBox()),
                    Expanded(
                      flex: 1,
                      child: Text('Chairs',
                        style: TextStyle(
                            color: colorTextBase,
                            fontSize: 10,
                            fontWeight: FontWeight.w600
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Expanded(
                        flex: 1,
                        child: SizedBox()),
                    Expanded(
                      flex: 2,
                      child: Text('Total',
                        style:  TextStyle(
                            color: colorText,
                            fontWeight: FontWeight.w600
                        ),),
                    ),
                  ],
                ),
                SizedBox(height: m.height*0.01,),
                SizedBox(
                  height: m.height*0.1,
                  child: ListView.builder(
                      itemCount: resList.length,
                      itemBuilder: (context,index){
                        return
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0,bottom: 3.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(resList[index].name,
                                    style:  TextStyle(
                                        color: colorTextBase,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Expanded(
                                    flex: 1,
                                    child: SizedBox()),
                                Expanded(
                                  flex: 1,
                                  child: Text('*',
                                    style: TextStyle(
                                        color: colorTextBase,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600
                                    ),),
                                ),
                                const Expanded(
                                    flex: 1,
                                    child: SizedBox()),
                                Expanded(
                                  flex: 1,
                                  child: Text('${resChairsList[index]}',
                                    style: TextStyle(
                                        color: colorTextBase,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600
                                    ),),
                                ),
                                const Expanded(
                                    flex: 1,
                                    child: SizedBox()),
                                Expanded(
                                  flex: 2,
                                  child: Text('${(double.parse(resList[index].price)*resChairsList[index])} EGP',
                                    style:  TextStyle(
                                        color: colorText,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600
                                    ),),
                                ),
                              ],
                            ),
                          );
                      }),
                ),
                const Divider(color: Colors.black12,thickness: 1,),
                customRowDate('Subtotal',colorTextBase,'$subTotal EGP',colorText),
                SizedBox(height: m.height*0.012,),
                customRowDate('Tax & Fees',colorTextBase,'$tax EGP',colorText),
                SizedBox(height: m.height*0.012,),
                customRowDate('Discount',colorTextBase,'$discount EGP',colorText),
                SizedBox(height: m.height*0.012,),
                const Divider(color: Colors.black12,thickness: 1,),
                SizedBox(height: m.height*0.012,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Total',
                      style: TextStyle(
                          color: colorText,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),),
                    const Spacer(),
                    Text('$total EGP',
                      style: TextStyle(
                          color: colorText,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),),
                    const SizedBox(width: 10,)
                  ],
                ),
              ],),
          ),
        ],
      )
  );
}
Widget customRowDate(String baseText,Color colorTextBase,String data,Color colorText, )=>   Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Text(baseText,
      style: TextStyle(
          color: colorTextBase,
          fontWeight: FontWeight.w600
      ),),
    const Spacer(),
    Text(data,
      style: TextStyle(
          color: colorText,
          fontSize: 17,
          fontWeight: FontWeight.bold
      ),),
    const SizedBox(width: 10,)
  ],
);

Widget customCartGridView(List<TripsModel> listTrips,List chairId,TripsState tripsState,context){
  return GridView.count(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    crossAxisSpacing: 10,
    mainAxisSpacing: 15,
    childAspectRatio: 1 / 1.2,
    children: List.generate(listTrips.length, (index) {
      return customCartTripWidget(tripsState,context,listTrips[index],chairId[index]);
    }),
  );
}
Widget customCartTripWidget(TripsState tripsState,context, TripsModel tripsModel,String chairId) =>
    GestureDetector(
      onTap: ()async{
         NavigatePages.persistentNavBarNavigator(DisplayCartTripsDetails(tripsState: tripsState, tripsModel: tripsModel, chairId: chairId), context);
      },
      child: Stack(
        children: [
          Container(
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
                  const SizedBox(height: 2,) ,
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tripsModel.date,
                          style: const TextStyle(
                              fontSize: 10, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          tripsModel.time,
                          style: const TextStyle(
                            fontSize: 10,
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
                  const SizedBox(height: 2,) ,
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Price : ${tripsModel.price}',
                          style: const TextStyle(
                              fontSize: 10, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          'Chair : $chairId',
                          style: const TextStyle(
                            fontSize: 10,
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
                  const SizedBox(height: 1,)
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: IconButton(
            icon: const Icon(Icons.delete_forever_rounded,color: Colors.white,),
            onPressed: (){
              SuperCubit.get(context).deleteCartTrips(tripsModel, chairId);
            },
           ),
          ),
        ],
      ),
    );
