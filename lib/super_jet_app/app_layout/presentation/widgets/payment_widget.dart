import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:superjet/core/global/localization/appLocale.dart';
import 'package:superjet/core/image/image.dart';
import 'package:superjet/core/utils/enums.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/trips_bloc.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/screens/payment/cart_trips_details.dart';
import 'package:superjet/super_jet_app/auth/data/models/user_model.dart';
import '../../../../core/services/routeing_page/routing.dart';
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
            child: SingleChildScrollView(
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
                        child: Text('${getLang(context, 'tripsName')}',
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
                        child: Text('${getLang(context, 'chairs')}',
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
                        child: Text('${getLang(context, 'total')}',
                          style:  TextStyle(
                              color: colorText,
                              fontWeight: FontWeight.w600
                          ),),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: m.height*0.08,
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
                  customRowDate('${getLang(context, 'subtotal')}',colorTextBase,'$subTotal ${getLang(context, 'EGP')}',colorText),
                  SizedBox(height: m.height*0.012,),
                  customRowDate('${getLang(context, 'tax')}',colorTextBase,'$tax ${getLang(context, 'EGP')}',colorText),
                  SizedBox(height: m.height*0.012,),
                  customRowDate('${getLang(context, 'discount')}',colorTextBase,'$discount ${getLang(context, 'EGP')}',colorText),
                  SizedBox(height: m.height*0.012,),
                  Row(
                    children: [
                      SizedBox(
                          width:MediaQuery.of(context).size.width*0.2,
                          child: const Divider(color: Colors.black12,thickness: 1,),
                      ),
                      const Spacer(),
                      SizedBox(
                          width:MediaQuery.of(context).size.width*0.2,
                          child: const Divider(color: Colors.black12,thickness: 1,),
                      ),

                    ],
                  ),
                  SizedBox(height: m.height*0.012,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${getLang(context, 'total')}',
                        style: TextStyle(
                            color: colorText,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),),
                      const Spacer(),
                      Text('$total ${getLang(context, 'EGP')}',
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

Widget customCartGridView(List<TripsModel> listTrips,List chairId,List chairDoc ,TripsState tripsState,context){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 15,
      childAspectRatio: 1 / 1.2,
      children: List.generate(listTrips.length, (index) {
        return customCartTripWidget(tripsState,context,listTrips[index],chairId[index],chairDoc[index]);
      }),
    ),
  );
}
Widget customCartTripWidget(TripsState tripsState,context, TripsModel tripsModel,String chairId,String chairDoc) =>
    GestureDetector(
      onTap: ()async{
         NavigatePages.persistentNavBarNavigator(DisplayCartTripsDetails(tripsState: tripsState, tripsModel: tripsModel, chairId: chairId, chairDoc: chairDoc,), context);
      },
      child: Stack(
        children: [
          Container(
            decoration:  BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 7)]),
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
                      style:  Theme.of(context).textTheme.displaySmall,
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
                          tripsModel.time.substring(0,5),
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
                          '${getLang(context, 'price')} : ${tripsModel.price}',
                          style: const TextStyle(
                              fontSize: 10, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text(
                          '${getLang(context, 'chair')} : $chairId',
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
              SuperCubit.get(context).deleteCartTrips(tripsModel, chairId,chairDoc);
              var collectionReference = FirebaseFirestore.instance
                  .collection('Trips')
                  .doc(tripsModel.categoryID.trim())
                  .collection(tripsModel.categoryName.trim())
                  .doc(tripsModel.tripID.trim())
                  .collection('Chairs');
              collectionReference.doc(chairDoc).update({
                'isAvailable':'true',
                'passengerID':'null',
              });
            },
           ),
          ),
        ],
      ),
    );

Future customBottomSheetCustomWallets(UserModel userModel ,String chairsNumber ,String total ,double walletMoney ,context)async{
  var c =SuperCubit.get(context);
  c.getType();
  var res = FirebaseFirestore.instance.collection('Accounts').doc('1').collection(c.type.trim()).doc(c.uId.trim());
  return   showModalBottomSheet(
    backgroundColor: Colors.white,
      elevation:5.5,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0)),
      ),
      builder: (context) {
        return StreamBuilder(
            stream: res.snapshots(),
            builder:(context,snapshot){
          if(snapshot.hasData){
            return  Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30,),
                              customWalletRowSheetButton(text: 'Name : ${userModel.name}', color: Colors.black),
                              customWalletRowSheetButton(text: 'Email : ${userModel.email}', color: Colors.black),
                              customWalletRowSheetButton(text: 'Phone : ${userModel.phone}', color: Colors.black),
                              customWalletRowSheetButton(text: 'The Wallet : ${snapshot.data!['wallet']} EG', color: Colors.black),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Center(
                              child: Image.asset(AppImage.wallet)),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        const Text(
                          'Chairs :  ',
                          style:  TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          chairsNumber,
                          style:  const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      children: [
                        const Text(
                          'Total :  ',
                          style:  TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          '$total EG',
                          style:  const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap:(){
                        if(double.parse(snapshot.data!['wallet']) >= double.parse(total)){
                          print('paaaaaaaaaaaaaaaaaaaay=============');
                          c.payWallet(context,total);
                        }else{
                          showToast('Your wallet is ${snapshot.data!['wallet']} , Not enough to pay , The Total trips is $total', ToastStates.error, context);
                        }
                      },
                      child: Container(
                        height:
                        MediaQuery.of(context).size.width *
                            0.115,
                        width: MediaQuery.of(context).size.width *
                            0.8,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            boxShadow: const [BoxShadow(color: Colors.black54,blurRadius: 5)],
                            borderRadius: const BorderRadius.all(
                                Radius.circular(30))),
                        child:  const Center(
                            child: Text(
                              'Pay',
                              style: TextStyle(
                                  color: Colors.white,
                                  shadows:  [BoxShadow(color: Colors.black54,blurRadius: 4)],

                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        height:
                        MediaQuery.of(context).size.width *
                            0.115,
                        width: MediaQuery.of(context).size.width *
                            0.8,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            boxShadow: const [BoxShadow(color: Colors.black54,blurRadius: 5)],
                            borderRadius: const BorderRadius.all(
                                Radius.circular(30))),
                        child: const Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.white,
                                  shadows:  [BoxShadow(color: Colors.black54,blurRadius: 4)],
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),

                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        });

      });
}

Widget customWalletRowSheetButton({required String text,required Color? color}){
  return   Padding(
    padding: const EdgeInsets.only(top:5.0),
    child: Text(
      text,
      style:  TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
          fontSize: 13),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    ),
  );
}