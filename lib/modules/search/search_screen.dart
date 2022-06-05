import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:memoire_mobile/modules/classrooms/cubit/add_cubit.dart';
import 'package:memoire_mobile/modules/classrooms/cubit/add_states.dart';

import '../../shared/components/mobile_components.dart';
import '../../shared/components/mobile_constants.dart';
import '../../shared/network/cache_helper.dart';
import '../../shared/styles/icons.dart';
import '../Reservations/cubit/reservation_cubit.dart';
import '../classrooms/update_classroom_screen.dart';


class SearchWidget extends StatelessWidget {
  TextEditingController searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCubit, AddStates>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                toolbarHeight: 100,
                title:   SizedBox(
                  width: 400.0,
                  //  padding: const EdgeInsets.all(100.0),
                  child: customTextField(controller: searchController,
                      label: 'Search',
                      //suffix: Icons.search,
                      onChanged: (value){
                        AddCubit.get(context).searchData(value);
                      }, textInputType: TextInputType.text),
                ),
                leading: InkWell(
                  onTap: ()=>Navigator.pop(context),
                  child: Icon(IconBroken.Arrow___Left_2,color:Colors.black ,),
                ),
                
              ),
              body: Padding(
                  padding: const EdgeInsets.only(left:45.0,right: 45.0,top: 20,),
                  child:
                  state is! SearchErrorState?
                  ListView.separated(
                      physics:const BouncingScrollPhysics(),
                      itemBuilder: (context,index){
                        return buildSearchItem(AddCubit.get(context).search[index],context);
                      }, separatorBuilder: (c,i)=>const SizedBox(), itemCount:AddCubit.get(context).search.length )
                      :const Center(child: Text('no data',style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  )))

              )
          );
        },
        listener: (context, state) {});
  }
}
Widget buildSearchItem(dynamic data,BuildContext context)=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 280.0,
    width: 280,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 250.0,
          width: 280,
          decoration: BoxDecoration(
              color: Colors.green.withOpacity(.3),
              borderRadius: BorderRadius.circular(15)
          ),
          padding: EdgeInsets.all(20),
          child:CacheHelper.getData(key: 'role')=='teacher'? Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('id : ${data['id']}',style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color:  Colors.black
              ),maxLines: 4,overflow: TextOverflow.ellipsis,),

              Text('name : ${data['name']}',style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color:  Colors.black
              ),maxLines: 4,overflow: TextOverflow.ellipsis,),

              Text('type : ${data['type']}',style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color:  Colors.black
              ),maxLines: 4,overflow: TextOverflow.ellipsis,),

              Text('stage : ${data['etage']}',style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color:  Colors.black
              ),maxLines: 4,overflow: TextOverflow.ellipsis,),

              Text('capacity : ${data['capcity']}',style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color:  Colors.black
              ),maxLines: 4,overflow: TextOverflow.ellipsis,),

              Text('particular : ${data['particulier']}',style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color:  Colors.black
              ),maxLines: 4,overflow: TextOverflow.ellipsis,),
              Divider(color: Colors.grey,),
              InkWell(
                onTap:(){
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
                child: customText( text: 'Reserve',color:Colors.green),
              ),
            ],
          ):
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('id : ${data['id']}',style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color:  Colors.black
              ),maxLines: 4,overflow: TextOverflow.ellipsis,),

              Text('name : ${data['name']}',style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color:  Colors.black
              ),maxLines: 4,overflow: TextOverflow.ellipsis,),

              Text('type : ${data['type']}',style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color:  Colors.black
              ),maxLines: 4,overflow: TextOverflow.ellipsis,),

              Text('stage : ${data['etage']}',style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color:  Colors.black
              ),maxLines: 4,overflow: TextOverflow.ellipsis,),

              Text('capacity : ${data['capcity']}',style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color:  Colors.black
              ),maxLines: 4,overflow: TextOverflow.ellipsis,),

              Text('particular : ${data['particulier']}',style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color:  Colors.black
              ),maxLines: 4,overflow: TextOverflow.ellipsis,),
              Divider(color: Colors.grey,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap:(){
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
                                    ReservationCubit.get(context).addReservation(context:context,time: reservationTime.text,date: reservationDate.text, goal: reservationGoal.text, id_user:CacheHelper.getData(key: 'ID'), id_classroom: data['id'],etat: data['particulier'],);
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
                    child: customText( text: 'Reserve',color: Colors.black),
                  ),
                  InkWell(
                    onTap:(){
                      TextEditingController _classStage=TextEditingController(text: '${data['etage']}');
                      TextEditingController _classCapacity=TextEditingController(text: '${data['capcity']}');
                      updateClassDialog(context,id:data['id'],name:data['name'],classStage: _classStage,classCapacity: _classCapacity);

                    },
                    child: customText( text: 'Edit',color:Colors.green),
                  ),
                  InkWell(
                    onTap:(){
                      deleteConfirmation(context, text1: data.name!,function: (){
                        AddCubit.get(context).deleteSalle(
                            data['id'], context);
                      });
                    },
                    child: customText( text: 'Delete',color:Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

