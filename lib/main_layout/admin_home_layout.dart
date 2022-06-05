import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:intl/intl.dart';
import 'package:memoire_mobile/modules/login/cubit/cubit.dart';
import 'package:memoire_mobile/modules/login/login_screen_mobile.dart';
import 'package:memoire_mobile/modules/Reservations/cubit/reservation_cubit.dart';
import 'package:memoire_mobile/modules/settings/settings_screen.dart';
import 'package:memoire_mobile/modules/users/users_list.dart';
import 'package:memoire_mobile/shared/components/mobile_constants.dart';
import 'package:memoire_mobile/shared/network/cache_helper.dart';
import 'package:memoire_mobile/shared/styles/colors.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../modules/Reservations/add_reservation.dart';
import '../modules/classrooms/cubit/add_cubit.dart';
import '../modules/search/search_screen.dart';
import '../shared/components/mobile_components.dart';
import '../shared/styles/icons.dart';
import '../modules/Materials/materials_list.dart';
import '../modules/classrooms/classroom_screen_admin.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final advancedDrawerController = AdvancedDrawerController();
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    List items=AddCubit.get(context).salleName;
    return AdvancedDrawer(
      backdropColor: Colors.green.withOpacity(.4),
      controller: advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius:  BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.withOpacity(.05),

          leading: IconButton(
            onPressed: (){
              setState(() {
                advancedDrawerController.showDrawer();
              });
            },
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration:const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          actions: [
               Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap:(){
                 navigateTo(context, SearchWidget());
                  },
                          child: CircleAvatar(
                              backgroundColor:  Colors.grey.withOpacity(.2),
                              child:const Icon(IconBroken.Search,color: Colors.green,)),
                        ),

                      ],
                    ),
                  ),
                ),
            const SizedBox(width: 10.0,),
          ],
        ),
        body: Container(
          height: getHeight(context),
          color: Colors.green.withOpacity(.05),
          child: SingleChildScrollView(
            padding:const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child:Column(
                children: [
                  SizedBox(height: 80,),

                  socialMedia('Facebook',Colors.blue,'https://web.facebook.com/faculteNTICUC2'),
                  SizedBox(height: 20,),
                  socialMedia('Twitter',Colors.blue.withOpacity(.5),'https://twitter.com/fac_ntic_UC2'),
                  SizedBox(height: 20,),

                InkWell(
                  onTap: (){
                    sendEmail('fac.ntic@univ-constantine2.dz', '');
                  },
                  child:   Container(

                      alignment: AlignmentDirectional.center,
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:customText(text: 'Email',color: Colors.white)

                  ),
                ),
                  SizedBox(height: 20,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Icon(IconBroken.Call),
                     SizedBox(width: 30,),
                     customText(text: '031783173'),
                   ],
                 ),
                  SizedBox(height: 20,),

                  Divider(endIndent:20,indent: 20,color: Colors.green,),
                  SizedBox(height: 90,),
                 InkWell(
                      onTap: (){
                        sendEmail('sara.bensalem@univ-constantine2.dz', 'App Problem');
                      },
                        child: customText(text: 'Report a problem')),

                ],
              ),
            ),
          ),
        ),
      ),
      drawer: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSizedBox(getHeight(context)/6),
            /*customListTile(icon: Icons.settings, text: 'Settings',onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>Settings()));
            }),
            customListTile(icon: Icons.list, text: 'My reservations'),
            customListTile(icon: IconBroken.Logout, text: 'Log Out'),*/
            Padding(
              padding: const EdgeInsets.only(left: 20.0,bottom: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(text: '${CacheHelper.getData(key: 'first_name')} ${CacheHelper.getData(key: 'last_name')} ',color: Colors.white,fontSize: 19.0),
                  const SizedBox(height: 4,),
                  customText(text: ('${CacheHelper.getData(key: 'grade')}'),color: Colors.grey,fontSize: 14.0,fontWeight: FontWeight.normal)
                ],
              ),
            ),
            customListTile(icon: Icons.list, text: 'Classrooms',onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ClassroomsScreen()));
            }),
            customListTile(icon: IconBroken.User, text: 'Teachers & Reservations',onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const UsersScreen()));
              // LoginCubit.get(context).userUpdate();
            }),
            customListTile(icon: Icons.keyboard, text: 'Materials',onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> MaterialScreen()));
              // LoginCubit.get(context).userUpdate();
            }),
            customListTile(icon: Icons.privacy_tip, text: 'Privacy&Policy', onTap: ()async{
              var urllaunchable =
                  await canLaunch('https://www.freeprivacypolicy.com/live/ff2de365-f95c-4f05-8dc4-b7e18f2b6c71'); //canLaunch is from url_launcher package
              if (urllaunchable) {
                await launch('https://www.freeprivacypolicy.com/live/ff2de365-f95c-4f05-8dc4-b7e18f2b6c71'); //launch is from url_launcher package to launch URL
              } else {
                print("URL can't be launched.");
              }
            },),
            const Spacer(),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    logout(context);
                  },
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    height: 50,
                    margin:const EdgeInsets.symmetric(horizontal: 20),
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.grey)
                    ),
                      child: customText(text: 'Log Out',color: Colors.white)),
                ),
                InkWell(
                  onTap: (){
                    deleteConfirmation(context, text1: 'your account?',function: (){
                      LoginCubit.get(context)
                          .deleteAccount(
                          CacheHelper.getData(key: 'ID'), context);                });
                  },
                  child: Container(
                      alignment: AlignmentDirectional.center,
                      height: 50,
                      margin:const EdgeInsets.symmetric(horizontal: 20),
                      width: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.red)
                      ),
                      child: customText(text: 'Delete',color: Colors.red)),
                ),
              ],
            ),
            const SizedBox(height: 10,),


            const SizedBox(height: 40,),
            //customListTile(icon: IconBroken.Delete, text: ''),
           // const Spacer(),
            DefaultTextStyle(
              style:const TextStyle(
                fontSize: 12,
                color: Colors.white54,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child:const Text('  © 2022 The President of Abdelhamid MEHRI College'),
              ),
            ),
            const SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}


