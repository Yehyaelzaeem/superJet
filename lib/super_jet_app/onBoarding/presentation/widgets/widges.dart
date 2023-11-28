import 'package:flutter/material.dart';
import '../../../../core/global/localization/appLocale.dart';
import '../../data/models/model.dart';

Widget customPageViewColum(OnBoardingModel onBoardingModel,context)=> SingleChildScrollView(
  child:   Column(

      mainAxisAlignment: MainAxisAlignment.center,

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        SizedBox(height:

        MediaQuery.of(context).size.height*0.15,

        ),

        SizedBox(

          height: MediaQuery.of(context).size.height*0.35,

          width: MediaQuery.of(context).size.width,

          child: ClipRRect(

              borderRadius: const BorderRadius.all(Radius.circular(20)),

              child: Image.asset(onBoardingModel.image,

              fit: BoxFit.cover,

              )),

        ),

         SizedBox(height:

         MediaQuery.of(context).size.height*0.15,

         ),

         Text('${AppLocale.of(context).getTranslated('onBoardingTitle${onBoardingModel.number}')}',
            style:  TextStyle(

                color:Theme.of(context).hintColor,

                fontSize: 25,

                fontWeight: FontWeight.bold

            )),

        const SizedBox(height: 15,),

         Text('${AppLocale.of(context).getTranslated('onBoardingDescription${onBoardingModel.number}')}',

            style: const TextStyle(

                color: Colors.grey,

                fontSize: 18,

                fontWeight: FontWeight.bold

            )),

      ]

  ),
);