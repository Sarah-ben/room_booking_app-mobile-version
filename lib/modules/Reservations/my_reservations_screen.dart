import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:memoire_mobile/models/login_model/login_model.dart';
import 'package:memoire_mobile/models/reservation_model/reservation_model.dart';
import 'package:memoire_mobile/modules/classrooms/classroom_screen_teacher.dart';
import 'package:memoire_mobile/modules/login/cubit/cubit.dart';
import 'package:memoire_mobile/shared/components/mobile_components.dart';
import 'package:memoire_mobile/shared/network/cache_helper.dart';

import '../../main_layout/cubit/app_cubit.dart';
import '../../models/class_model/class_model.dart';
import '../../shared/components/mobile_constants.dart';
import '../../shared/styles/icons.dart';
import 'cubit/reservation_cubit.dart';
import 'cubit/reservation_list.dart';

class reservationlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(ReservationCubit.get(context).reservations.length);
    return BlocConsumer<ReservationCubit, ReservationStates>(
        builder: (context, state) {
          return Scaffold(

            body: SingleChildScrollView(
              physics:const BouncingScrollPhysics(),
              child:ReservationCubit.get(context).reservations.length>0? Container(
                padding: const EdgeInsets.all(20.0),
                width: getWidth(context),
                height: getHeight(context),
                child: ListView.separated(
                    itemBuilder: (context, index) => buildResItem(
                        ReservationCubit.get(context).reservations[index],
                        context),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount:
                    ReservationCubit.get(context).reservations.length),
              ):SizedBox(
                width: getWidth(context),
                height: getHeight(context),
                child:  Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(text: 'No reservations yet',color: Colors.grey),
                    defaultTextButton(function: (){
navigateTo(context, Classrooms());
                    }, text: 'Add nes reservation',color: Colors.green)
                  ],
                )),
              )
            ),
          );
        },
        listener: (BuildContext context, Object? state) {});
  }
}

Widget buildResItem(ReservationData data, BuildContext context) {
   return
     InkWell(
      child: 
      Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: SizedBox(
            height: 100,
            child: Stack(
              //   alignment: AlignmentDirectional.bottomEnd,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green.withOpacity(.1),
                  ),
                  padding:const EdgeInsets.only(left: 20,right: 10),
                  height: 90,
                  child:Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Reservation ID : ${data.id}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  height: 2),
                            ),
                            Text(   '${data.date} AT ${data.time}', style: const TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),


                    ],
                  ) ,
                ),
                Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                         InkWell(
                      onTap:(){
                        updateReservation(context, data);
                      },
                      child:const Card(
                          elevation: 2,
                          child: Padding(
                            padding:  EdgeInsets.all(3.0),
                            child:  Icon(
                              IconBroken.Edit,
                              size: 25.0,
                              color: Colors.grey,
                            ),
                          )),
                    ),
                        InkWell(
                          onTap:(){
                            deleteConfirmation(context, text1: 'Confirm deleting this ID ${data.id_classroom}',function: ()=>ReservationCubit.get(context).deleteReservation(data.id, context));
                          },
                          child:const Card(
                              elevation: 2,
                              child: Padding(
                                padding:  EdgeInsets.all(3.0),
                                child: Icon(IconBroken.Delete,color: Colors.red,),
                              )),
                        ),

                      ],
                    ))
              ],
            ),
          )),
    );}
Future updateReservation(context, ReservationData model) {
  return showDialog(context: context, builder: (context){
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
                print('${model.id}');
                print('${CacheHelper.getData(key: 'ID')}');
                ReservationCubit.get(context).updateReservation(id: model.id,context: context,time: reservationTime.text, date: reservationDate.text, goal: reservationGoal.text);
              }, text: 'Update',fontSize: 19.0,color: Colors.blueAccent),
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
}
/*void showSheetWithoutList(context,ReservationData model) {
  showStickyFlexibleBottomSheet<void>(
    minHeight: 0,
    initHeight: 0.5,
    maxHeight: .8,
    headerHeight: 280,
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
          height: 280,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(offset == 0.8 ? 0 : 40),
              topRight: Radius.circular(offset == 0.8 ? 0 : 40),
            ),
          ),
          child:
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                classInfoItem(text: 'Name ', info: model.time!),
                const Divider(),
               // classInfoItem(text: 'Type ', info: model.date!),
                const Divider(),
                classInfoItem(text: 'Stage ', info: '${model.goal!}'),


              ],
            ),
          )

      );
    },
    bodyBuilder: (context, offset) {
      return SliverChildListDelegate(
          [
            Row(
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
            ),
          ]
      );
    },
    anchors: [.2, 0.5, .8],
  );
}
*/
/*void updateReservation(context, ReservationData model) {
  showStickyFlexibleBottomSheet<void>(
    minHeight: 0,
    initHeight: 0.5,
    maxHeight: .8,
    headerHeight: 400,
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
          height: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(offset == 0.8 ? 0 : 40),
              topRight: Radius.circular(offset == 0.8 ? 0 : 40),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: [
                customTextField(
                    controller: reservationGoal,
                    label: 'Goal',
                    textInputType: TextInputType.text),
                verticalSizedBox(15.0),
                Row(
                  children: [
                    Expanded(
                      child: customTextField(
                          controller: reservationTime,
                          label: 'Time',
                          textInputType: TextInputType.text,
                          enabled: false,
                          onTap: () {
                            print('clicked');
                          }),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    FloatingActionButton(
                      heroTag: 'addTime',
                      onPressed: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) => reservationTime.text =
                            value!.format(context).toString());
                      },
                      mini: true,
                      child: Icon(Icons.edit),
                    )
                  ],
                ),
                verticalSizedBox(15.0),
                Row(
                  children: [
                    Expanded(
                      child: customTextField(
                          controller: reservationDate,
                          label: 'Date',
                          textInputType: TextInputType.text,
                          enabled: false,
                          onTap: () {
                            print('clicked');
                          }),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    FloatingActionButton(
                      heroTag: 'addTime',
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050))
                            .then((value) => reservationDate.text =
                                DateFormat.yMMMd().format(value!));
                      },
                      mini: true,
                      child: Icon(Icons.edit),
                    )
                  ],
                ),
              ],
            ),
          ));
    },
    bodyBuilder: (context, offset) {
      return SliverChildListDelegate([
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                //  updateReservation(context);
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateClass(data)));
                //AppCubit.get(context).deleteSalle(data.id!,context);
              },
              child: const Icon(
                IconBroken.Edit,
                size: 25.0,
                color: Colors.green,
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            InkWell(
              onTap: () {
                //  AddCubit.get(context).deleteSalle(data.id,context);
              },
              child: const Icon(
                IconBroken.Delete,
                size: 25.0,
                color: Colors.green,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ]);
    },
    anchors: [.2, 0.5, .8],
  );
}
*/
/*Future updateReservation(context, ReservationData model,)=>showModalBottomSheet(context: context, builder: (context){
  return Container(
    color: Colors.red,
    child: Text('${model.time}'),
  );
});*/
