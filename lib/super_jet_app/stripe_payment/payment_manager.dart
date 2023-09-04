import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import '../../core/utils/constants.dart';

abstract class SuperJetPaymentManager{
 static Future<void>makePayment(int amount,String currency,context)async{
  try {
   var c =SuperCubit.get(context);
   String clientSecret=await _getClientSecret((amount*100).toString(), currency,context);
   await _initializePaymentSheet(clientSecret);
   await Stripe.instance.presentPaymentSheet().then((value) {
    c.isPay=true;
   });
  } catch (error) {
   throw Exception(error.toString());
  }
 }

 static Future<void>_initializePaymentSheet(String clientSecret)async{
  await Stripe.instance.initPaymentSheet(
   paymentSheetParameters: SetupPaymentSheetParameters(
    paymentIntentClientSecret: clientSecret,
    merchantDisplayName: "SuperJet",
   ),
  );
 }

 static Future<String> _getClientSecret(String amount,String currency,context)async{
  var c =SuperCubit.get(context);
  c.isPay=false;
  Dio dio=Dio();
  var response= await dio.post(
   'https://api.stripe.com/v1/payment_intents',
   options: Options(
    headers: {
     'Authorization': 'Bearer ${App.secretKey}',
     'Content-Type': 'application/x-www-form-urlencoded'
    },
   ),
   data: {
    'amount': amount,
    'currency': currency,
   },
  );
  if (response.statusCode == 200) {
   print(response.statusMessage);
   print('======================================success');
   // log("Transaction Id ${data['data'][0]['balanceTransaction']}");
  }
  return response.data["client_secret"];
 }

}