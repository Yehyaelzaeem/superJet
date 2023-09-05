import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/core/utils/enums.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/trip_model.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/trips_bloc.dart';
import '../../../stripe_payment/payment_manager.dart';
import '../bloc/state.dart';
import '../widgets/payment_widget.dart';
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var m =MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
                    cubit.listCartTrips.isEmpty?Column(
                      children: [
                        SizedBox(height: m.height*0.15,),
                        const Center(child: Text('There are no trips currently',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18
                        ),
                        ),),
                      ],
                    ):
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: customCartGridView(cubit.listCartTrips,cubit.chairsId,cubit.chairsDoc,state,context),
                    ),
                    const SizedBox(height: 50,)
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: SizedBox(
                  height:  m.height*0.12,
                  child: Center(
                    child: Container(
                      decoration: const BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.white,blurRadius: 5)],
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      width: m.width*0.4,
                      height: m.height*0.06,
                      child: MaterialButton(
                        onPressed: (){
                          if(cubit.total==0 ||cubit.total<0){
                            showToast("The total mustn't equal zero or less ", ToastStates.error, context);
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
                                    collectionReference.doc(chairId).update({'isPaid': 'true','isAvailable':'false','passengerID':state.userModel!.uId});
                                    var d = FirebaseFirestore.instance.collection('Accounts').doc('1').collection('user').doc(state.userModel!.uId.trim());
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
                        child:   const Text('Pay',
                          style: TextStyle(
                            color:Colors.black54,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
        listener: (context,state){},

      )
    );
  }
}
