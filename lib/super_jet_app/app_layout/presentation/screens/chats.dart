import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/core/services/routeing_page/reoute.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/state.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/widgets/chat_widgets.dart';
import 'package:superjet/super_jet_app/auth/data/models/user_model.dart';

import '../../data/models/admin_users_model.dart';
import 'chat_details.dart';
class Chats extends StatelessWidget {
  const Chats({super.key, required this.userModel});
 final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    List<UsersTableModel> chatNewList = [];
    var cubit= SuperCubit.get(context);

    return Scaffold(
       appBar: AppBar(
         systemOverlayStyle:  const SystemUiOverlayStyle(
           statusBarColor: Colors.white,
             statusBarIconBrightness:Brightness.dark,),
         leading: BackButton(
           color: Colors.black87,
           onPressed: (){
             Navigator.pop(context);
           },
         ),
         backgroundColor: Colors.white,
         title: const Text('Chats',
         style: TextStyle(
             fontSize: 25,
             fontWeight: FontWeight.bold,
             color: Colors.black87
         ),),
         actions: [
           IconButton(
               onPressed: (){

               },
               icon:  const Icon(Icons.notifications_active_rounded,color: Colors.black87)),
           IconButton(
               onPressed: (){

               },
               icon:  const Icon(Icons.search,color: Colors.black87)),
         ],
       ),
      body:
      BlocConsumer<SuperCubit,AppSuperStates>(
          builder: (context,state){
            chatNewList=[];
           if(userModel.type=='user'){
             chatNewList = [ cubit.adminList,  cubit.branchesList,].expand((x) => x).toList();
           }else if(userModel.type=='branch'){
             chatNewList = [ cubit.adminList, cubit.usersList].expand((x) => x).toList();
           }else{
             chatNewList = [ cubit.adminList,  cubit.branchesList,  cubit.usersList].expand((x) => x).toList();
           }

            return  ConditionalBuilder(
                condition: chatNewList.isNotEmpty,
                builder: (context){
                  return  ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: chatNewList.length,
                      itemBuilder: (context ,i){
                       return customRowChatPerson(
                          image:  chatNewList[i].profileImage,
                          name: chatNewList[i].type=='admin'?'Admin/ ${chatNewList[i].name}' : chatNewList[i].type=='user'? chatNewList[i].name:'Br/ ${chatNewList[i].name}',
                          onTap: () {
                            cubit.getMessages(userModelSender: userModel, userModelReceiver: chatNewList[i]);
                            NavigatePages.pushToPage(ChatDetails(userModelReceiver:chatNewList[i], userModelSender: userModel,), context);
                          },);
                        // if(chatNewList[i].uId !=userModel.uId){
                        //   return    customRowChatPerson(
                        //     image:  chatNewList[i].profileImage,
                        //     name: chatNewList[i].type=='admin'?'Admin/ ${chatNewList[i].name}' : chatNewList[i].type=='user'? chatNewList[i].name:'Br/ ${chatNewList[i].name}',
                        //     onTap: () {
                        //       cubit.getMessages(userModelSender: userModel, userModelReceiver: chatNewList[i]);
                        //       NavigatePages.pushToPage(ChatDetails(userModelReceiver:chatNewList[i], userModelSender: userModel,), context);
                        //     },);
                        // }
                      },
                      separatorBuilder: (BuildContext context, int index)=>
                      const SizedBox(height: 5));

                },
                fallback: (context)=>const Center(child: CircularProgressIndicator(),));


          },
          listener: (context,state){},

      )



    );
  }
}
