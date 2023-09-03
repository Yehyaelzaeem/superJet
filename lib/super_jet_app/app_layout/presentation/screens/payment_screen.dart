import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                      child: customCartGridView(cubit.listCartTrips,cubit.chairsId,state,context),
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
                          SuperJetPaymentManager.makePayment(cubit.total.toInt(),"EGP");
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
