import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/cubit.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/state.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/bloc/trips_bloc.dart';
import 'package:superjet/super_jet_app/app_layout/presentation/widgets/chat_widgets.dart';
import 'package:superjet/super_jet_app/auth/data/models/user_model.dart';
import '../../../../../core/services/services_locator.dart';
import '../../../../../core/utils/enums.dart';
import '../../../data/models/admin_users_model.dart';


class ChatDetails extends StatelessWidget {
  const ChatDetails({super.key, required this.userModelReceiver});
  final UsersTableModel userModelReceiver ;

  @override
  Widget build(BuildContext context) {
    SuperCubit.get(context).removeNotificationListOfNameChats();
    var cubit =SuperCubit.get(context);
    // c.getMessages(userModelSender: userModelSender, userModelReceiver: userModelReceiver);

    return
      BlocProvider(create: (context)=>TripsBloc(sl())..add(GetProfileEvent(context)),
        child: BlocBuilder<TripsBloc,TripsState>(
          builder: (context,state){
            if(state.userModel.isNotEmpty){
              var collectionReference = FirebaseFirestore.instance.collection('Accounts').doc('1').collection(
                  state.userModel[0].type).doc(state.userModel[0].uId)
                  .collection('Chat').doc(userModelReceiver.uId).collection('Message')
                  .orderBy('dateTime', descending: true);
              return  SafeArea(
                child: Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      systemOverlayStyle:  const SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness:Brightness.dark,
                      ),
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
                                ),
                            ),
                            const SizedBox(width: 5,),
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(userModelReceiver.profileImage),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(userModelReceiver.name,
                            style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),

                      ),

                    ),
                    body:
                    StreamBuilder(
                      stream:collectionReference.snapshots() ,
                      builder: (context ,snapshot ){
                        if(snapshot.hasData){
                          return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:
                              Column(
                                children: [
                                  Expanded(
                                    child: ListView.separated(
                                      reverse: true,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context,i){
                                        if(snapshot.data!.docs[i]['senderId']==state.userModel[0].uId.trim()) {
                                          return designMyMessage(snapshot.data!.docs[i]['text'],snapshot.data!.docs[i]['dateTime'], context);
                                        }
                                        else{
                                          return designMessage(snapshot.data!.docs[i]['text'],snapshot.data!.docs[i]['dateTime'], context);
                                        }
                                      },
                                      separatorBuilder: (context,i)=> const SizedBox(height: 15,),),
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
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black
                                                ),
                                                controller:cubit.chatController ,
                                                keyboardType: TextInputType.multiline,
                                                maxLines: null,
                                                decoration: const InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'type your message here ... ',
                                                    hintStyle: TextStyle(
                                                      color: Colors.grey
                                                    )
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
                                                cubit.sendMessage(userModelSender: state.userModel[0], userModelReceiver: userModelReceiver);
                                                cubit.chatController.text='';
                                              });

                                            }, icon: const Icon(Icons.send,color: Colors.blue,),),
                                            const SizedBox(width: 10,),

                                          ],
                                        );
                                      })
                                  )
                                ],
                              ));
                        }
                        else if (snapshot.connectionState==ConnectionState.waiting){
                          return const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                              Center(
                                child: Text("loading"),
                              ),
                            ],
                          );
                        }
                        else{
                          showToast('Error', ToastStates.error, context);
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                ),
              );
            }
            else{
              return const Scaffold(
                body: Center(child: CircularProgressIndicator(),),
              );
            }


          },
        ),
      );
  }
}
/*
BlocConsumer<SuperCubit,AppSuperStates>(
            builder: (context,state){
              return
              Padding(
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
 */