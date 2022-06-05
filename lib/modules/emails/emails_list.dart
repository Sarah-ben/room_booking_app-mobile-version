import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memoire_mobile/modules/login/cubit/cubit.dart';
import 'package:memoire_mobile/shared/components/mobile_components.dart';
import 'package:memoire_mobile/shared/components/mobile_constants.dart';

class EmailsList extends StatelessWidget {
  const EmailsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emails'),
      ),
      body: SizedBox(
        height: getHeight(context),
        width: getWidth(context),
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 40),
          child: SingleChildScrollView(
            child: SizedBox(
              height: getHeight(context),
              width: getWidth(context),

              child: ListView.separated(itemBuilder: (context,index){
                return buildEmailItem(LoginCubit.get(context).emails[index],context);
              }, separatorBuilder: (context,index)=>Divider(), itemCount: LoginCubit.get(context).emails.length),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmailItem(String email,context) =>InkWell(
    onTap: (){
      sendEmail(email, '');
    },
    child: Container(
      padding: EdgeInsets.all(7),
      alignment: AlignmentDirectional.center,
      height: 60,
      width: getWidth(context),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(.2),
borderRadius: BorderRadius.circular(30)
      ),
      child: customText(text: email,fontWeight: FontWeight.w600,fontSize:15.0 ),
    ),
  );
}
