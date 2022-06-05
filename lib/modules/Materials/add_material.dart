import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/components/mobile_components.dart';
import '../../shared/components/mobile_constants.dart';
import '../../shared/styles/icons.dart';
String selectedValue='Computer component';
List<String> materialType = [
  'Data show',
  'Computer component',
  'Others',

];
TextEditingController _nameController=TextEditingController();
void showSheetWithoutList(context) {
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
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: [
                      //customFormField(sallename),
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        isExpanded: true,
                        hint: const Text(
                          'Choose a class name',
                          style: TextStyle(fontSize: 14),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 30,
                        buttonHeight: 60,
                        buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                        dropdownDecoration: BoxDecoration(
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
                                ),
                              ),
                            ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a type';
                          }
                        },
                        onChanged: (value) {
                          selectedValue=value.toString();
                        },
                      ),
                      verticalSizedBox( 20.0,),
                      customTextField(controller:_nameController , label: '  Name', textInputType: TextInputType.text,color: Colors.black54),

                      verticalSizedBox( 30.0,),
                      SizedBox(
                          width: 300.0,
                          child:defaultButton(function: (){
                            //AddCubit.get(context).getSalle();
                            //AddCubit.get(context).addClass(name: selectedValue.toString(), type:_type.name , etage: int.parse(salleEtage.text), capacity: int.parse(salleCapacity.text),particulier:_particular.name );
                          }, text: 'Add') ),
                    ],
                  ),
                ),

              ],
            ),
          )

      );
    },
    bodyBuilder: (context, offset) {
      return SliverChildListDelegate(
          [

          ]
      );
    },
    anchors: [.2, 0.5, .8],
  );
}

