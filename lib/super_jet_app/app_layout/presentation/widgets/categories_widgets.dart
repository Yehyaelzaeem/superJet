import 'package:flutter/material.dart';
import 'package:superjet/super_jet_app/app_layout/data/models/categories_model.dart';

Widget rowCategories(context, CategoriesModel categoriesModel) =>
    Padding(
     padding: const EdgeInsets.all(8.0),
     child: Container(
       decoration: BoxDecoration(
           borderRadius: const BorderRadius.all(Radius.circular(20)),
           color: Colors.grey.shade200,
           border: Border.all(color: Colors.white,width: 2),
           boxShadow: const [
             BoxShadow(color: Colors.black54, blurRadius: 2)
           ]),
       height: 120,
       child: Center(
         child: Row(
           children: [
             SizedBox(
               height: 120,
               width: MediaQuery.of(context).size.width * 0.3,
               child: ClipRRect(
                 borderRadius: const BorderRadius.all(Radius.circular(20)),
                 child: Image(
                   image: NetworkImage(
                     categoriesModel.image,
                   ),
                   fit: BoxFit.fill,
                 ),
               ),
             ),
             const SizedBox(
               width: 20,
             ),
             SizedBox(
               width: MediaQuery.of(context).size.width * 0.4,
               child:
                   Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                          "${categoriesModel.masterCity} - ${categoriesModel.city}",
                         textAlign:TextAlign.start,
                         style: const TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 18,
                         ),
                         maxLines: 1,
                         overflow: TextOverflow.ellipsis,

                       ),
                       const SizedBox(height: 5,),
                       customRowCategoriesDetails('Name Of Category : ', categoriesModel.name,),
                       customRowCategoriesDetails('First Type : ',categoriesModel.categoryName),
                       customRowCategoriesDetails('Second Type : ',categoriesModel.categorySecondName),
                       customRowCategoriesDetails('Number Of Trips: ', categoriesModel.numberOfTrips),
                     ],
                   )
             ),
             const Spacer(),
             Center(
                 child: IconButton(
                     onPressed: () {},
                     icon: const Icon(Icons.arrow_forward_ios))),
           ],
         ),
       ),
     ),
      );

Widget customRowCategoriesDetails(String constText,String data)=> Row(children: [
   Text(
    constText,
    style: const TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.grey,
      fontSize: 8,
    ),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  ),
  Text(
    data,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    ),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  ),
],);
