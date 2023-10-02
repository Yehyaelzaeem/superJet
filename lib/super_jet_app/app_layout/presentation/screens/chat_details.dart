import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/state.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/widgets/chat_widgets.dart';
import 'package:superjet/super_jet_app/auth/data/models/user_model.dart';

import '../../data/models/admin_users_model.dart';


class ChatDetails extends StatelessWidget {
  const ChatDetails({super.key, required this.userModelReceiver, required this.userModelSender});
  final UsersTableModel userModelReceiver ;
  final UserModel userModelSender ;

  @override
  Widget build(BuildContext context) {
    var c =SuperCubit.get(context);
    c.getMessages(userModelSender: userModelSender, userModelReceiver: userModelReceiver);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          systemOverlayStyle:  const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness:Brightness.dark,
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 60,
          title:
          Container(
            alignment: AlignmentDirectional.centerStart,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,),
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(userModelReceiver.profileImage),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(userModelReceiver.name,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                )
              ],
            ),
            
          ),

        ),
        body:
          BlocConsumer<SuperCubit,AppSuperStates>(
            builder: (context,state){
              return  Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:
                  Column(
                    children: [
                  Expanded(
                    child: ConditionalBuilder(
                    condition: c.chatDetailsList.isNotEmpty,
                        builder: (context){
                          return
                            ListView.separated(
                            reverse: true,
                            itemCount: c.chatDetailsList.length,
                            itemBuilder: (context,i){
                              if(c.chatDetailsList[i].senderId==userModelSender.uId) {
                                return designMyMessage(c.chatDetailsList[i].text, context);
                              }
                              return designMessage(c.chatDetailsList[i].text, context);
                            },
                            separatorBuilder: (context,i)=> const SizedBox(height: 15,),);
                        },
                        fallback: (context)=>const Center(child:CircularProgressIndicator())),
                  ),
                      const SizedBox(height: 10,),
                      Container(
                          decoration: BoxDecoration(
                              boxShadow: const [BoxShadow(color: Colors.black45,blurRadius: 2)],
                              color: Colors.grey.shade200,
                              border: Border.all(color: Colors.grey.shade300,width: 1),
                              borderRadius: const BorderRadius.all(Radius.circular(12))
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: StatefulBuilder(builder: (context,setState){
                            return   Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(onPressed: ()async{

                                },
                                    icon: const Icon(
                                      Icons.emoji_emotions_outlined,color: Colors.black54,
                                      size: 28,
                                    )),
                                const SizedBox(width: 15,),
                                Expanded(
                                  child:
                                  TextField(
                                    controller:c.chatController ,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'type your message here ... '
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: VerticalDivider(
                                    color: Colors.grey.shade300,
                                    thickness: 1,
                                  ),
                                ),
                                IconButton(onPressed: (){
                                  setState((){
                                    c.sendMessage(userModelSender: userModelSender, userModelReceiver: userModelReceiver);
                                    c.chatController.text='';
                                  });

                                }, icon: const Icon(Icons.send,color: Colors.blue,),),
                                const SizedBox(width: 10,),

                              ],
                            );
                          })
                      )
                    ],
                  ));

                
            },
            listener: (context,state){},
          ),


      ),
    );
  }
}
