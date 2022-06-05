import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memoire_mobile/models/class_model/class_model.dart';

import '../../main_layout/cubit/app_cubit.dart';
import '../../shared/components/mobile_components.dart';
import '../../shared/components/mobile_constants.dart';
import 'cubit/add_cubit.dart';

class UpdateClass extends StatefulWidget {
  UpdateClass(this. model);
  Data model ;

  @override
  State<UpdateClass> createState() => _UpdateClassState();
}

class _UpdateClassState extends State<UpdateClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model.name!,style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: (getHeight(context)),
          width: (getWidth(context) ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,vertical: 20.0),
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
                        customTextField(controller:salleEtage , label: 'Etage', textInputType: TextInputType.text,color: Colors.black54),
                        verticalSizedBox( 10.0,),
                        customTextField(controller:salleCapacity , label: '  capacity', textInputType: TextInputType.text,color: Colors.black54),
                        verticalSizedBox( 30.0,),
                        const Text('Is it particular?',style: TextStyle(fontWeight: FontWeight.bold),),
                        verticalSizedBox( 20.0,),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 170,
                              child: ListTile(
                                title:const Text('No',
                                    style: TextStyle(
                                        color:Colors
                                            .black)),
                                leading: Radio(
                                  fillColor:
                                  MaterialStateColor
                                      .resolveWith(
                                          (states) =>
                                      Colors
                                          .green),
                                  focusColor:
                                  MaterialStateColor
                                      .resolveWith(
                                          (states) =>
                                      Colors
                                          .green),
                                  value: particular.False,
                                  groupValue:
                                  particularClass,
                                  onChanged:
                                      (particular?
                                  value) {
                                   setState(() {

                                      particularClass =
                                      value!;
                                      print(particularClass.name);
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: ListTile(
                                title:const Text('Yes',
                                    style: TextStyle(
                                        color:Colors
                                            .black)),
                                leading:
                                Radio<particular>(
                                  fillColor:
                                  MaterialStateColor
                                      .resolveWith(
                                          (states) =>
                                      Colors
                                          .green),
                                  value: particular.True,
                                  groupValue:
                                  particularClass,
                                  onChanged:
                                      (particular?
                                  value) {
                                    setState(() {
                                      particularClass =
                                      value!;
                                      print(particularClass.name);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        verticalSizedBox(30.0,),
                        SizedBox(
                            width: 300.0,
                            child:defaultButton(function: (){
                              if(formKey.currentState!.validate()){
                                AddCubit.get(context).updateSalle(context,widget.model.id!, etage: int.parse(salleEtage.text), capcity:  int.parse(salleCapacity.text), particular: particularClass.name);
                              }
                              // AddCubit.get(context).addClass(name: selectedValue.toString(), type:_type.name , etage: salleEtage.text, capacity: salleCapacity.text,particulier:_particular.name );
                            }, text: 'Add')),
                       /* SizedBox(
                            width: 300.0,
                            child:defaultButton(function: (){
                              AddCubit.get(context).userUpdate();    // AddCubit.get(context).addClass(name: selectedValue.toString(), type:_type.name , etage: salleEtage.text, capacity: salleCapacity.text,particulier:_particular.name );
                            }, text: 'Add') ),*/
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





