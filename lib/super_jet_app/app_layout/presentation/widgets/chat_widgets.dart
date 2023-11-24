import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart' as badges;

import '../bloc/cubit.dart';
import '../bloc/state.dart';
Widget customRowChatPerson(
    {required String image, required String name,required String nameID, void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(image),
          ),
          const SizedBox(
            width: 20,
          ),
          BlocConsumer<SuperCubit,AppSuperStates>(
            builder: (context, state) {
              int i =0;
              bool  isFound=false;
              return StatefulBuilder(builder: (context,setState){
                if(SuperCubit.get(context).listOfNameChats.isNotEmpty){
                  for(var x in  SuperCubit.get(context).listOfNameChats){
                    if(x==nameID.trim()){
                     setState((){
                       i++;
                       isFound=true;
                     });
                    }
                  }
                  return
                    isFound==true?
                    badges.Badge(
                      badgeContent: Text(i.toString(),style: const TextStyle(color: Colors.white),),
                      badgeStyle:const badges.BadgeStyle(badgeColor: Colors.red) ,
                      child:  Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Text(
                          name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),):
                    Text(name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    );
                }else{
                  return   Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  );
                }
              });
          },
            listener: (context, state){},),

        ],
      ),
    ),
  );
}

Widget designMyMessage(String text ,String time, context) {
  var dateTime=DateTime.parse(time.toString());
  var formatterTime = DateFormat('hh:mm a');
  String newTime = formatterTime.format(dateTime);
  return ChatBubble(
    clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
    alignment: Alignment.topRight,
    margin: const EdgeInsets.only(top: 20),
    backGroundColor: Theme.of(context).primaryColor,
    child: Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(text,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black87),
          ),
          Text(newTime,
            style:  const TextStyle(
                fontSize: 12,
                color: Colors.grey),
          ),
          // Text(date,
          //   style:  TextStyle(
          //       fontSize: 13,
          //       color: Colors.grey.shade300),
          // ),
        ],
      ),
    ),
  );
}

Widget designMessage(String text ,String time , context) {
  DateTime dateTime =DateTime.parse(time);
  var formatterTime = DateFormat('hh:mm a');
  String newTime = formatterTime.format(dateTime);
  return ChatBubble(
    clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
    backGroundColor: const Color(0xffE7E7ED),
    margin: const EdgeInsets.only(top: 20),
    child: Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(text,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black87),
          ),
          Text(newTime,
            style:  const TextStyle(
                fontSize: 12,
                color: Colors.grey),
          ),
          // Text(date,
          //   style:  TextStyle(
          //       fontSize: 13,
          //       color: Colors.grey.shade300),
          // ),
        ],

      ),
    ),
  );
}
