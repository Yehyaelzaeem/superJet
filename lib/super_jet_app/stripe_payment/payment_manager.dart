import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../core/utils/constants.dart';

abstract class SuperJetPaymentManager{

 static Future<void>makePayment(int amount,String currency)async{
  try {
   String clientSecret=await _getClientSecret((amount*100).toString(), currency);
   await _initializePaymentSheet(clientSecret);
   await Stripe.instance.presentPaymentSheet();

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

 static Future<String> _getClientSecret(String amount,String currency)async{
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
  return response.data["client_secret"];
 }

}