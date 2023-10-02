import 'package:flutter/material.dart';
import '../../../../core/services/routeing_page/reoute.dart';
import '../bloc/cubit.dart';
import '../screens/login.dart';

Widget customCheckUserButton(String type ,context)=>
    Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [BoxShadow(color: Colors.black54,blurRadius: 7)]
      ),
      width: MediaQuery.of(context).size.width*0.5,
      height: MediaQuery.of(context).size.height*0.15,
      child: MaterialButton(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        color: Theme.of(context).primaryColor,
        onPressed: (){
          if(type =='user'){
            AuthCubit.get(context).isKnowType='user';
            NavigatePages.pushToPage(const LoginScreen(type: 'user',), context);
            AuthCubit.get(context).chickUsers(type);
          }
          else{
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  icon:  const Icon(Icons.manage_accounts_rounded,size: 50,color: Colors.white,),
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.95),
                  title:   const Text('Administrator',
                  style: TextStyle(color: Colors.white,
                  fontSize: 25
                  ),
                  ),
                  content:   Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: InkWell(
                          onTap: (){
                            AuthCubit.get(context).isKnowType='admin';
                            NavigatePages.pushToPage(const LoginScreen(type: 'admin',), context);
                            AuthCubit.get(context).chickUsers('admin');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 15),
                              decoration:  BoxDecoration(
                                color: Colors.grey.shade200,
                                boxShadow: const [BoxShadow(color: Colors.white,blurRadius: 10)],
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              child:   Text('Admin',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blue.shade600,
                                    fontWeight: FontWeight.bold
                                ),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: InkWell(
                          onTap: (){
                            AuthCubit.get(context).isKnowType='branch';
                            NavigatePages.pushToPage(const LoginScreen(type: 'branch',), context);
                            AuthCubit.get(context).chickUsers('branch');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 15),
                              decoration:  BoxDecoration(
                                color: Colors.grey.shade200,
                                boxShadow: const [BoxShadow(color: Colors.white,blurRadius: 10)],
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              child:   Text('Branch',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blue.shade600,
                                    fontWeight: FontWeight.bold
                                ),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 15),
                              decoration:  BoxDecoration(
                                color: Colors.grey.shade200,
                                boxShadow: const [BoxShadow(color: Colors.white,blurRadius: 10)],
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              child:   Text('Cancel',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blue.shade600,
                                    fontWeight: FontWeight.bold
                                ),
                              )),
                        ),
                      ),


                    ],
                  ),
                );
              },
            );
          }

        },
        child:  Text(type,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30
          ),
        ),
      ),
    );