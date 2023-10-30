import 'package:flutter/material.dart';
import 'package:superjet/core/utils/enums.dart';
import '../../../../auth/presentation/widgets/widget.dart';
import '../../bloc/cubit.dart';

class AdminNotification extends StatelessWidget {
  const AdminNotification({super.key, required this.text, required this.token});
  final String text;
  final String token;
  @override
  Widget build(BuildContext context) {
    var m =MediaQuery.of(context).size;
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: m.height*0.1,),
                 Center(
                  child: Icon(Icons.notifications_active_rounded,
                  color: Colors.blue.shade900,
                  size: 100,),
                ),
                 Center(
                  child: Text('Notification',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.blue.shade900,
                  ),
                  ),
                ),
                SizedBox(height: m.height*0.08,),
                 Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(text,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.black54
                    ),
                  ),
                ),
                SizedBox(height: m.height*0.02,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius:
                      const BorderRadius.all(Radius.circular(30))),
                  child: customTextField(
                    textColor: Colors.black87,
                    hintTextColor:  Colors.black54,
                    colorIcon: Colors.black87,
                    isPassword: false,
                    context: context,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {}
                      return null;
                    },
                    controller: SuperCubit.get(context).controllerTitleNotification,
                    hintText: 'title',
                    iconData: Icons.title,
                    obscureText: false,
                  ),
                ),
                SizedBox(height: m.height*0.03,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius:
                      const BorderRadius.all(Radius.circular(30))),
                  child: customTextField(
                    textColor: Colors.black87,
                    hintTextColor:  Colors.black54,
                    colorIcon: Colors.black87,
                    isPassword: false,
                    context: context,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value!.isEmpty) {}
                      return null;
                    },
                    controller: SuperCubit.get(context).controllerBodyNotification,
                    hintText: 'body',
                    iconData: Icons.menu,
                    obscureText: false,
                  ),
                ),
                SizedBox(height: m.height*0.13,),

                Center(
                  child: MaterialButton(
                    onPressed: (){
                      if( SuperCubit.get(context).controllerTitleNotification.text.isNotEmpty &&
                          SuperCubit.get(context).controllerBodyNotification.text.isNotEmpty){
                        SuperCubit.get(context).sendNotification(
                            SuperCubit.get(context).controllerTitleNotification.text.trim(),
                            SuperCubit.get(context).controllerBodyNotification.text.trim(),
                            'all',
                            token);
                      }
                      else{
                        showToast('please sure the title or body not empty ', ToastStates.error, context);
                      }

                  },
                    color: Colors.grey.shade300,
                    shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  child:  Padding(
                    padding: const EdgeInsets.only(left: 60.0,right: 60,top: 15,bottom: 15),
                    child: Text('Send Notification',
                    style: TextStyle(
                      fontSize: 20,
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
