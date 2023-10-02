import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

Widget customRowChatPerson(
    {required String image, required String name, void Function()? onTap}) {
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
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          )
        ],
      ),
    ),
  );
}

Widget designMyMessage(String text , context) {
  return ChatBubble(
    clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
    alignment: Alignment.topRight,
    margin: const EdgeInsets.only(top: 20),
    backGroundColor: Colors.blue,
    child: Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      child:  Text(text,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget designMessage(String text , context) {
  return ChatBubble(
    clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
    backGroundColor: const Color(0xffE7E7ED),
    margin: const EdgeInsets.only(top: 20),
    child: Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
    ),
  );
}
