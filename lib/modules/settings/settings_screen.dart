import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/components/mobile_components.dart';
import '../../shared/components/mobile_constants.dart';
import '../../shared/network/cache_helper.dart';
import '../../shared/styles/icons.dart';
import '../edit_profile/edit_profile.dart';
import '../login/cubit/cubit.dart';

class Settings extends StatelessWidget {
  role _role = role.teacher;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 40,),
                  customText( text: CacheHelper.getData(key: 'first_name'),color: Colors.black),
                  const SizedBox(width: 5,),
                  customText( text: CacheHelper.getData(key: 'last_name'),color: Colors.black),
                  Spacer(),
                  InkWell(
                      onTap: (){
                      navigateTo(context, EditProfile(CacheHelper.getData(key: 'ID')));
                      },
                      child: const Icon(Icons.edit,color: Colors.green,))
                ],
              ),
              SizedBox(height: 50,),
              customListTile(icon: IconBroken.Call, text: 'Contact US',onTap: (){
                sendEmail('djihane.laadjal@univ-constantine2.dz', 'Contact Developer');
              },textColor: Colors.black),
              customListTile(icon: Icons.privacy_tip_outlined, text: 'Privacy&policy',onTap: (){
                launchUrl('https://www.freeprivacypolicy.com/live/ff2de365-f95c-4f05-8dc4-b7e18f2b6c71');
              },textColor: Colors.black),
              customListTile(icon: IconBroken.Logout, text: 'Log Out',onTap: (){
                logout(context);
              },textColor: Colors.black),
              customListTile(icon: IconBroken.Delete, text: 'Delete Account',color: Colors.red,onTap: (){
                deleteConfirmation(context, text1: 'your account?',function: (){
                  LoginCubit.get(context)
                      .deleteAccount(
                      CacheHelper.getData(key: 'ID'), context); });
              },textColor: Colors.black),
            ],
          ),
        ),
      ),
    );
  }

}

