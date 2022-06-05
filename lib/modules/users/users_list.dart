import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:memoire_mobile/models/login_model/login_model.dart';
import 'package:memoire_mobile/models/reservation_model/reservation_model.dart';
import 'package:memoire_mobile/modules/Reservations/material_cubit/material_reservation_cubit.dart';
import 'package:memoire_mobile/modules/edit_profile/edit_profile.dart';
import 'package:memoire_mobile/modules/login/cubit/cubit.dart';
import 'package:memoire_mobile/modules/login/cubit/states.dart';
import 'package:memoire_mobile/modules/Reservations/cubit/reservation_cubit.dart';
import 'package:memoire_mobile/modules/Reservations/reservation_by_user.dart';
import 'package:memoire_mobile/modules/register/register_mobile.dart';
import 'package:memoire_mobile/shared/components/mobile_components.dart';
import 'package:memoire_mobile/shared/network/cache_helper.dart';

import '../../main_layout/cubit/app_cubit.dart';
import '../../models/class_model/class_model.dart';
import '../../shared/components/mobile_constants.dart';
import '../../shared/styles/icons.dart';
import '../Reservations/material_reservation_by_user.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginStates>(builder: (context,state){
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 3,
          backgroundColor: Colors.green,
          onPressed: (){
            navigateTo(context,const RegisterScreen());
          },
          child:const Icon(IconBroken.Add_User),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:const Text('Users List'),
          elevation: 1,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            // color: Color.fromRGBO(205, 209, 147, .1),
            width: getWidth(context),
            height: getHeight(context),
            child:  Padding(
              padding: const EdgeInsets.all(15.0),
              child: ConditionalBuilder(condition:LoginCubit.get(context).users.length>0 ,
                fallback: (BuildContext context) =>customProgressIndicator(),
                builder: (BuildContext context) => ListView.separated(itemBuilder: (context,index)=>buildClassItem(LoginCubit.get(context).users[index], context), separatorBuilder:(context,index)=>const Divider(), itemCount: LoginCubit.get(context).users.length),
              )
             // ListView.separated(itemBuilder: (context,index)=>buildClassItem(LoginCubit.get(context).users[index], context), separatorBuilder:(context,index)=>const Divider(), itemCount: LoginCubit.get(context).users.length),
            ),
          )
        ),
      );
    }, listener: (BuildContext context, Object? state) {  });
  }
}
Widget buildClassItem(UserData data,BuildContext context)=>InkWell(
    child:   InkWell(
          onTap: (){
           //  ReservationCubit.get(context).getReservationall(context, data.id);
            showSheetWithoutList(context,data,
            );
          },
          child:
          Container(
            decoration: BoxDecoration(
                color:const Color.fromRGBO(205, 209, 147, .1),
                borderRadius: BorderRadius.circular(15.0)
            ),
            // margin: const EdgeInsets.symmetric(vertical: 2.0),
            height: 100.0,
            width: double.infinity,
            child:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   // VerticalDivider(thickness: 2,color: Colors.green,indent: 10,endIndent: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${data.first_name!} ${data.last_name!}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                height: 1.5),
                          ),
                          Text(data.grade!, style: const TextStyle(color: Colors.grey)),

                        ],
                      ),
                    ),
                    if(data.id==CacheHelper.getData(key: 'ID'))
                      customText(text: 'You '),

                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateClass(data)));
                            //AppCubit.get(context).deleteSalle(data.id!,context);
                          },
                          child:const Icon(
                            IconBroken.Arrow___Right_2,
                            size: 25.0,
                            color: Colors.green,
                          ),
                        ),


                      ],
                    ),
                  ],
                ),
            ),


          ),
        )
);
void showSheetWithoutList(context,UserData data) {
  ReservationCubit.get(context).getReservationall(context, data.id);
  MaterialReservationCubit.get(context).getAllReservationsByID(context, data.id);
  print('the user data id :${data.id}');
  showStickyFlexibleBottomSheet<void>(
    minHeight: 0,
    initHeight: 0.6,
    maxHeight: .9,
    headerHeight: getHeight(context)/1.1,
    context: context,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40.0),
        topRight: Radius.circular(40.0),
      ),
    ),
    headerBuilder: (context, offset) {
      return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          height: getHeight(context)/1.1,
          decoration: BoxDecoration(
            color:const Color.fromRGBO(205, 209, 147, .15),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(offset == 0.8 ? 0 : 40),
              topRight: Radius.circular(offset == 0.8 ? 0 : 40),
            ),
          ),
          child:
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(text: 'Profile Info',fontSize: 20.0),
                const SizedBox(height: 30,),
                userInfoItem(icon: IconBroken.User, text: data.first_name! ,subText: data.last_name!,label: 'Full Name'),
                const SizedBox(height: 20.0,),
                InkWell(
                  onTap: (){
sendEmail( data.email!, 'Booking App');
                  },
                    child: userInfoItem(icon: Icons.email_outlined, text: data.email!,label: 'Email Address')),
                const SizedBox(height: 20.0,),
                userInfoItem(icon: Icons.grade_outlined, text: data.grade!,label: 'Grade'),
                const SizedBox(height: 20.0,),
                userInfoItem(icon: IconBroken.Location, text: data.place!,label:'Place'),
                const SizedBox(height: 20.0,),
                InkWell(
                  child: userInfoItem( text:'0${ReservationCubit.get(context).allreservations.length +MaterialReservationCubit.get(context).allReservationsByID.length}',label:'Classrooms Reservation'),onTap: (){
                    print('material list lenght ${MaterialReservationCubit.get(context).allReservationsByID.length}');
                    print('classroom list lenght ${ReservationCubit.get(context).allreservations.length}');
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>reservationlistperuser(data.id)));
                },),
                const SizedBox(height: 20.0,),
                InkWell(
                  child: userInfoItem(see:'Manage material reservations' , text:'',label:'Material Reservation'),onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>materialReservationlistperuser(7)));
                },),
                const Spacer(),
                Row(
                  children: [
                    Expanded(child: defaultButton(function: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile(data.id)));
                    }, text: 'Edit')),
                    const SizedBox(width: 10.0,),
                    Expanded(child: defaultButton(function: (){
                    LoginCubit.get(context).deleteUser(data.id,context);
                    }, text: 'Delete',color1: Colors.red,color2: Colors.red.withOpacity(.9),color3: Colors.red.withOpacity(.7),color4: Colors.red.withOpacity(.5))),
                  ],
                ),
              ],
            ),
          )

      );
    },
    bodyBuilder: (context, offset) {
      return SliverChildListDelegate(
          [
            /*SizedBox(
              height: 100,
              child: ListView.separated(itemBuilder:(context,index){
                return  buildresrvItem(ReservationCubit.get(context).allreservations[index],context);
              }, separatorBuilder: (context,index)=>Divider(), itemCount: ReservationCubit.get(context).allreservations.length),
            )*/
          ]
      );
    },
    anchors: [.2, 0.5, .8],
  );
}

Widget buildresrvItem(ReservationData data,BuildContext context)=>InkWell(
child: Container(
  color: Colors.black12,
  height: 50,
    child: Column(
      children: [
        Text('id classroom ${data.id_classroom}'),
        Text(' id user ${data.id_user}'),

      ],
    )),
);



