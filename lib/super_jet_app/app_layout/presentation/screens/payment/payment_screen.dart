import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:superjet/core/global/localization/appLocale.dart';
import 'package:superjet/core/utils/enums.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/trip_model.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/trips_bloc.dart';
import '../../../../../core/image/image.dart';
import '../../../../stripe_payment/payment_manager.dart';
import '../../bloc/state.dart';
import '../../widgets/payment_widget.dart';
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var m =MediaQuery.of(context).size;
    SuperCubit.get(context).getID();
    return Scaffold(
      body:
      BlocConsumer<SuperCubit,AppSuperStates>(
        builder: (context, state) {
          var state= context.read<TripsBloc>().state;
          var cubit=SuperCubit.get(context);
          return  Stack(
            children: [
              SingleChildScrollView(
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customPaymentDetails(cubit.listCartTrips,cubit.chairsId,cubit.total,cubit.suTotal,cubit.tax,cubit.discount,context),
                    const SizedBox(height: 20,),
                    cubit.listCartTrips.isEmpty?
                    Column(
                      children: [
                        SizedBox(height: m.height*0.15,),
                         Center(child: Text('${getLang(context, 'noTrips')}',
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 18
                          ),
                        ),),
                      ],
                    ):
                    customCartGridView(cubit.listCartTrips,cubit.chairsId,cubit.chairsDoc,state,context),
                    const SizedBox(height: 50,)
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child:
                  FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height:  m.height*0.12,
                            child: Center(
                              child: Container(
                                decoration: const BoxDecoration(
                                    boxShadow: [BoxShadow(color: Colors.white,blurRadius: 5)],
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                width: m.width*0.4,
                                height: m.height*0.07,
                                child: MaterialButton(
                                  onPressed: (){
                                    cubit.getType();
                                    cubit.getID();
                                    if(cubit.total==0 ||cubit.total<0){
                                      showToast("${getLang(context, 'totalEqualZero')}", ToastStates.error, context);
                                    }else{

                                      SuperJetPaymentManager.makePayment(cubit.total.toInt(),"EGP",context).then((value){
                                        if(cubit.isPay==true){
                                          for(var i =0;i<=cubit.listCartTrips.length-1;i++){
                                            TripsModel list =cubit.listCartTrips[i];
                                            var chair=cubit.chairsId[i];
                                            var chairId=cubit.chairsDoc[i];
                                            var collectionReference = FirebaseFirestore.instance
                                                .collection('Trips').doc(list.categoryID.trim())
                                                .collection(list.categoryName.trim())
                                                .doc(list.tripID.trim()).collection('Chairs');
                                            collectionReference.doc(chairId.toString().trim()).update({'isPaid': 'true'});
                                            var d = FirebaseFirestore.instance.collection('Accounts').doc('1').collection(cubit.type).doc(cubit.uId!.trim());
                                            d.update({
                                              'trips':FieldValue.arrayUnion([
                                                {
                                                  'chairID': int.parse(chair),
                                                  'tripID': list.tripID,
                                                }
                                              ]),
                                            });
                                          }
                                        }else{

                                        }
                                        cubit.removeCart();
                                      });

                                    }

                                  },
                                  color:Colors.grey.shade200,
                                  shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ),
                                  child:    Image.asset(AppImage.visa)
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          SizedBox(
                            height:  m.height*0.12,
                            child: Center(
                              child: Container(
                                decoration: const BoxDecoration(
                                    boxShadow: [BoxShadow(color: Colors.white,blurRadius: 5)],
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                width: m.width*0.4,
                                height: m.height*0.07,
                                child: MaterialButton(
                                  onPressed: (){
                                    showToast('Fawry', ToastStates.success, context);
                                  },
                                  color:Colors.grey.shade200,
                                  shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ),
                                  child:  Image.asset(AppImage.fawry)
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          SizedBox(
                            height:  m.height*0.12,
                            child: Center(
                              child: Container(
                                decoration: const BoxDecoration(
                                    boxShadow: [BoxShadow(color: Colors.white,blurRadius: 5)],
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                width: m.width*0.4,
                                height: m.height*0.07,
                                child: MaterialButton(
                                  onPressed: (){
                                    if(cubit.total==0 ||cubit.total<0){
                                      showToast("${getLang(context, 'totalEqualZero')}", ToastStates.error, context);
                                    }
                                    else{
                                      context.read<TripsBloc>().add(GetProfileEvent(context));
                                      var user= context.read<TripsBloc>().state.userModel[0];
                                      if(double.parse(user.wallet) > 0.0){
                                        showToast("${getLang(context, 'wallet')} ${user.wallet} ", ToastStates.success, context);
                                        customBottomSheetCustomWallets(user, cubit.listCartTrips.length.toString(),cubit.total.toString(),double.parse(user.wallet),context);
                                      }else{
                                        showToast("${getLang(context, 'wallet')}${getLang(context, 'zero')} ", ToastStates.error, context);
                                      }
                                    }
                                  },
                                  color:Colors.grey.shade200,
                                  shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)) ),
                                  child:  Image.asset(AppImage.wallet)
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )

              )
            ],
          );
        },
        listener: (context,state){},

      ),
    );
  }
}
