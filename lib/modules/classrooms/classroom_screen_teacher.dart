import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:memoire_mobile/models/login_model/login_model.dart';
import 'package:memoire_mobile/modules/classrooms/add_classroom_screen.dart';
import 'package:memoire_mobile/modules/classrooms/update_classroom_screen.dart';
import 'package:memoire_mobile/modules/login/cubit/cubit.dart';
import 'package:memoire_mobile/modules/Reservations/cubit/reservation_cubit.dart';
import 'package:memoire_mobile/shared/components/mobile_components.dart';
import 'package:memoire_mobile/shared/network/cache_helper.dart';

import '../../main_layout/cubit/app_cubit.dart';
import '../../models/class_model/class_model.dart';
import '../../shared/components/mobile_constants.dart';
import '../../shared/styles/icons.dart';
import '../emails/emails_list.dart';
import '../search/search_screen.dart';
import 'cubit/add_cubit.dart';
import 'cubit/add_states.dart';

class Classrooms extends StatelessWidget {
  const Classrooms({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCubit,AddStates>(builder: (context,state){
      return Scaffold(
appBar: AppBar(
  title: Text('Classrooms'),
  automaticallyImplyLeading: false,
  elevation: 0,
  backgroundColor: Colors.transparent,
  actions: [
    Card(
      elevation: 2,
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
            InkWell(
              onTap:(){
                navigateTo(context, EmailsList());
              },
              child: CircleAvatar(
                  backgroundColor:  Colors.grey.withOpacity(.2),
                  child:const Icon(Icons.email_rounded,color: Colors.red,)),
            ),

          ],
        ),
      ),
    ),
    const SizedBox(width: 10.0,),
  ],
),
        body: Container(
          color:const  Color.fromRGBO(205, 209, 147, .1),
          width: getWidth(context),
          height: getHeight(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0,bottom: 10,top: 15,right: 15),
            child: SingleChildScrollView(
              physics:const BouncingScrollPhysics(),
              child:AddCubit.get(context).salles.length>0?
              ConditionalBuilder(
                  builder: (BuildContext context)  =>Container(
                      width: getWidth(context),
                      height: getHeight(context),
                      child: ListView.separated(itemBuilder: (context,index)=>buildClassItem(AddCubit.get(context).salles[index], context), separatorBuilder:(context,index)=>const Divider(), itemCount: AddCubit.get(context).salles.length)),
                  condition: AddCubit.get(context).salles.isNotEmpty,
                  fallback: (BuildContext context) =>customProgressIndicator()):
              SizedBox(
                width: getWidth(context),
                height: getHeight(context),
                child:  Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(text: 'No Classrooms yet',color: Colors.grey),
                  ],
                )),
              ),
            ),
          ),
        ),
      );
    }, listener: (BuildContext context, Object? state) {  });
  }
}
Widget buildClassItem(Data data,BuildContext context)=>InkWell(
    child:  SizedBox(
        width:getWidth(context),
        height: 100,
        child:  InkWell(
          onTap: (){
            _showSheetWithoutList(context,data);
          },
          child:
          SizedBox(
            // margin: const EdgeInsets.symmetric(vertical: 2.0),
            height: 120.0,
            width: double.infinity,
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 0,
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Classroom ID : ${data.id}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              height: 2),
                        ),

                        Text(  'Type : ${data.type!}', style: const TextStyle(color: Colors.black54)),
                      ],
                    ),
                  ),
                  Row(
                    children: [

                      const SizedBox(width: 20,),
                      InkWell(
                        onTap: (){
                          showDialog(context: context, builder: (context){
                            return Dialog(
                              elevation: 0,
                              backgroundColor:const Color(0xffffffff),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  height: 383,
                                  child:Column(
                                    children: [
                                      Padding(padding: const EdgeInsets.all(25.0),
                                          child:Column(
                                            children: [
                                              customTextField(
                                                  controller: reservationGoal,
                                                  label: 'Goal',
                                                  textInputType: TextInputType.text),
                                              verticalSizedBox(15.0),
                                              customUpdateItem(context, controller: reservationTime,onPressed: (){

                                                showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                ).then((value) =>
                                                reservationTime.text = value!.format(context).toString());

                                              }),
                                              verticalSizedBox(15.0),
                                              customUpdateItem(context, controller: reservationDate,onPressed: (){
                                                showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime(2050))
                                                    .then((value) =>
                                                reservationDate.text =
                                                    DateFormat.yMMMd()
                                                        .format(value!));
                                              }),
                                            ],
                                          )),
                                      Container(color: Colors.grey.withOpacity(.15),height: 1,),
                                      verticalSizedBox(5.0),
                                      defaultTextButton(function: (){
                                        ReservationCubit.get(context).addReservation(context:context,time: reservationTime.text,date: reservationDate.text, goal: reservationGoal.text, id_user:CacheHelper.getData(key: 'ID'), id_classroom: data.id,etat: data.particulier,);
                                        // print('${data.id}');
                                        //  print('${LoginCubit.get(context).loginModel.userData!.id}');
                                        //   ReservationCubit.get(context).updateReservation();
                                      }, text: 'Add',fontSize: 19.0,color: Colors.blueAccent),
                                      verticalSizedBox(5.0),
                                      Container(color: Colors.grey.withOpacity(.15),height: 1,),
                                      verticalSizedBox(5.0),
                                      defaultTextButton(function: (){
                                        Navigator.pop(context);
                                      }, text: 'Cancel',fontSize: 18.0,color: Colors.red),
                                    ],
                                  ),

                                ),
                              ),
                            );
                          });
                        },
                        child:const Icon(
                          Icons.add,
                          size: 25.0,
                          color: Colors.green,
                        ),
                      ),
                      const  SizedBox(width: 10,),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    )
);
void _showSheetWithoutList(context,Data data) {
  showStickyFlexibleBottomSheet<void>(
    minHeight: 0,
    initHeight: 0.5,
    maxHeight: .8,
    headerHeight: 380,
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
          height: 380,
          decoration: BoxDecoration(
            color:const Color.fromRGBO(205, 209, 147, .1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(offset == 0.8 ? 0 : 40),
              topRight: Radius.circular(offset == 0.8 ? 0 : 40),
            ),
          ),
          child:
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                customText(text: 'Details :',fontSize: 19),
                const SizedBox(height: 25,),
                classInfoItem(text: 'ID ', info: '${data.id}'),
                const Divider(),
                classInfoItem(text: 'Name ', info: data.name!),
                const Divider(),
                classInfoItem(text: 'Type ', info: data.type!),
                const Divider(),
                classInfoItem(text: 'Stage ', info: '${data.etage!}'),
                const Divider(),
                classInfoItem(text: 'Capacity ', info: '${data.capcity!}'),
                const Divider(),
                classInfoItem(text: 'Particularity ', info: '${data.particulier!}'),
                const Divider(),
              ],
            ),
          )
      );
    },
    bodyBuilder: (context, offset) {
      return SliverChildListDelegate(
          [
            /* Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 InkWell(
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateClass(data)));
                     //AppCubit.get(context).deleteSalle(data.id!,context);
                   },
                   child:const Icon(
                     IconBroken.Edit,
                     size: 25.0,
                     color: Colors.green,
                   ),
                 ),
                 const SizedBox(width: 40,),
                 InkWell(
                   onTap: (){
                     AddCubit.get(context).deleteSalle(data.id,context);
                   },
                   child:const Icon(
                     IconBroken.Delete,
                     size: 25.0,
                     color: Colors.green,
                   ),
                 ),
                 const  SizedBox(width: 20,),
               ],
             ),*/
          ]
      );
    },
    anchors: [.2, 0.5, .8],
  );
}



