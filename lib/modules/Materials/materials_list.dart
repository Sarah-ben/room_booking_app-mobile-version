import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:memoire_mobile/models/login_model/login_model.dart';
import 'package:memoire_mobile/models/material_model/material_model.dart';
import 'package:memoire_mobile/modules/Materials/cubit/material_states.dart';
import 'package:memoire_mobile/modules/Reservations/material_cubit/material_reservation_cubit.dart';
import 'package:memoire_mobile/modules/login/cubit/cubit.dart';
import 'package:memoire_mobile/modules/Reservations/cubit/reservation_cubit.dart';
import 'package:memoire_mobile/shared/components/mobile_components.dart';
import 'package:memoire_mobile/shared/network/cache_helper.dart';

import '../../main_layout/cubit/app_cubit.dart';
import '../../models/class_model/class_model.dart';
import '../../shared/components/mobile_constants.dart';
import '../../shared/styles/icons.dart';
import '../classrooms/cubit/add_cubit.dart';
import '../classrooms/update_classroom_screen.dart';
import 'cubit/material_cubit.dart';

class MaterialScreen extends StatelessWidget {
  String selectedValue='Computer component';
  List<String> materialType = [
    'Data show',
    'Computer component',
    'Others',

  ];
  var _nameController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MaterialCubit,MaterialStates>(builder: (context,state){
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: (){
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  //backgroundColor:
                  // dark(context) ? Colors.black : Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.0))),
                    content: StatefulBuilder(
                      builder:
                          (BuildContext context, StateSetter setState) {
                        return Builder(
                          builder: (context) {
                            return SizedBox(
                              height: 260,
                              width: (getWidth(context)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0,vertical: 20.0),
                                    child: SizedBox(
                                      child: Form(
                                        key: formKey,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            //customFormField(sallename),
                                            DropdownButtonFormField2(
                                              style:const TextStyle(
                                                //color: dark(context)?Colors.white:Colors.black
                                              ),
                                              selectedItemHighlightColor: Colors.grey,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(15),
                                                    borderSide:const BorderSide(color: Colors.white
                                                    )
                                                ),
                                              ),
                                              isExpanded: true,
                                              hint:  const Text(
                                                'Choose a class name',
                                                style: TextStyle(fontSize: 14,color:Colors.black),
                                              ),
                                              icon:const  Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black,
                                              ),
                                              iconSize: 30,
                                              buttonHeight: 60,
                                              buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                              dropdownDecoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              items: materialType
                                                  .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black
                                                      ),
                                                    ),
                                                  ))
                                                  .toList(),
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'Please select a category.';
                                                }
                                              },
                                              onChanged: (value) {
                                                selectedValue=value.toString();
                                              },
                                            ),
                                            verticalSizedBox( 20.0,),
                                            customTextField( controller:_nameController , label: '  Name', textInputType: TextInputType.text,color:Colors.black54 ),
                                            verticalSizedBox( 30.0,),
                                            SizedBox(
                                                width: 300.0,
                                                child:defaultButton(function: (){
                                                  MaterialCubit.get(context).addMaterial(category: selectedValue.toString(), name: _nameController.text);
                                                }, text: 'Add') ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    )));
          },
          child:const Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:const Text('Material List'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child:SizedBox(
            // color: Color.fromRGBO(205, 209, 147, .8),
            width: getWidth(context),
            height: getHeight(context),
            child:  Padding(
              padding: const EdgeInsets.all(15.0),
              child:ConditionalBuilder(
                  builder: (BuildContext context)  =>ListView.separated(itemBuilder: (context,index)=>buildMaterialItem(MaterialCubit.get(context).materials[index], context), separatorBuilder:(context,index)=>const Divider(), itemCount: MaterialCubit.get(context).materials.length),
                  condition: MaterialCubit.get(context).materials.length>0,
                  fallback: (BuildContext context) =>customProgressIndicator()),
            ),
          )
        ),
      );
    }, listener: (BuildContext context, Object? state) {  });
  }
}
Widget buildMaterialItem(MaterialData data,BuildContext context)=>InkWell(
    child:SizedBox(
      height: 100,
      child: Stack(
     //   alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20,right: 10),
            color:const Color.fromRGBO(205, 209, 147, .1),
          height: 90,
            child:Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                       data.name!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            height: 2),
                      ),
                      Text(   'Material ID :${data.id}', style: const TextStyle(color: Colors.black)),
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
                 /* InkWell(
                    onTap:(){},
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
                  ),*/
                  InkWell(
                    onTap:(){
                      deleteConfirmation(context, text1: 'This material',function: (){
                        MaterialCubit.get(context).deleteMaterial(data.id, context);
                        Navigator.pop(context);
                      });

                    },
                    child:const Card(
                      elevation: 2,
                        child: Padding(
                          padding:  EdgeInsets.all(3.0),
                          child: Icon(IconBroken.Delete,color: Colors.red,),
                        )),
                  ),
                  InkWell(
                    onTap:(){
                      var reservationTime=TextEditingController();
                      var reservationDate=TextEditingController();
                      var reservationGoal=TextEditingController();

                      showDialog(

                          context: context, builder: (context){
                        return Dialog(
                          elevation: 0,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SingleChildScrollView(
                            child: SizedBox(
                              width: 300,
                              height: 380.0,
                              child:Column(
                                children: [
                                  Padding(padding: const EdgeInsets.all(25.0),
                                      child: Form(
                                        key: formKey,
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 10,),
                                            customTextField(
                                                controller: reservationGoal,
                                                label: 'Goal',
                                                textInputType: TextInputType.text,),
                                            verticalSizedBox(10.0),
                                            customUpdateItem(context, controller: reservationTime,onPressed: (){
                                              showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                              ).then((value) =>
                                              reservationTime.text = value!.format(context).toString());
                                            }),
                                            verticalSizedBox(10.0),
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
                                            verticalSizedBox(15.0),
                                            defaultButton(
                                                function:(){
                                                  if(formKey.currentState!.validate()){
                                                    MaterialReservationCubit.get(context).addReservation(context:context,date: reservationDate.text, time: reservationTime.text, goal: reservationGoal.text, id_user: CacheHelper.getData(key: 'ID'), id_material:  data.id);
                                                  }
                                                  // ReservationCubit.get(context).updateReservation(id: id,context: context,time: reservationTime.text, date: reservationDate.text, goal: reservationGoal.text);
                                                },
                                                text: 'Add'),
                                          ],
                                        ),
                                      )),


                                ],
                              ),

                            ),
                          ),
                        );
                      });
                     // MaterialCubit.get(context).deleteMaterial(data.id, context);
                    },
                    child:const Card(
                        elevation: 2,
                        child: Padding(
                          padding:  EdgeInsets.all(3.0),
                          child: Icon(Icons.add,color: Colors.green,),
                        )),
                  ),

                ],
              ))
        ],
      ),
    )

);
void _showSheetWithoutList(context,Data data) {
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



