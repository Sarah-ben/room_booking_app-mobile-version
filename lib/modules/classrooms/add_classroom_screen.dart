
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:memoire_mobile/shared/components/mobile_components.dart';
import '../../shared/components/mobile_components.dart';

import '../../shared/components/mobile_constants.dart';
import '../login/cubit/states.dart';
import 'cubit/add_cubit.dart';
import 'cubit/add_states.dart';

class AddClassroom extends StatefulWidget {
  const AddClassroom({Key? key}) : super(key: key);
  @override
  State<AddClassroom> createState() => _AddClassroomState();
}
String selectedClassroom = 'TD Classroom';
List<String> classType = [
  'TD Classroom',
  'TP Classroom',
  'Amphitheatre',
];

String selectedClassroomNumber = 'TD Classroom';
List<int> classNumber = [
1,
2,
3,
4,
5,
6,
7,
8,
9,
10,
11,
12,
13,
14,
15,
16,
17,
18,
19,
20,
21,
22,
23,
24,
25,
26,
27,
28,
29,
30,
31,
32,
33,
34,
35,
36,
37,
38,
39,
40,
41,
42,
43,
44,
45,
46,
47,
48,
49,
50,
51,
52,
53,
54,
55,
56,
57,
58,
59,
60];

var salleName=TextEditingController();
var salleType=TextEditingController();

enum particular { True, False }
particular _particular = particular.False;

enum type { salle, amphi }
type _type = type.salle;

List<String> _status = ["Pending", "Released", "Blocked"];
class _AddClassroomState extends State<AddClassroom> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCubit,AddStates>(builder: (BuildContext context, state) {
      return Scaffold(
        appBar: AppBar(
          title:const Text('Add Salle',style: TextStyle(color: Colors.black),),
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
                            items: classType
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
                                return 'Please select gender.';
                              }
                            },
                            onChanged: (value) {
                              selectedClassroom=value.toString();
                            },
                          ),
                          verticalSizedBox( 20.0,),
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
                            items: classNumber
                                .map((item) =>
                                DropdownMenuItem<int>(
                                  value: item,
                                  child: Text(
                                    '${item}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select gender.';
                              }
                            },
                            onChanged: (value) {
                              selectedClassroomNumber=value.toString();
                            },
                          ),
                          verticalSizedBox( 20.0,),
                          customTextField(controller:salleEtage , label: '  Etage', textInputType: TextInputType.text,color: Colors.black54),
                          verticalSizedBox( 10.0,),
                          customTextField(controller:salleCapacity , label: '  capacity', textInputType: TextInputType.text,color: Colors.black54),

                          verticalSizedBox( 30.0,),
                          const Text('Choose the type',style: TextStyle(fontWeight: FontWeight.bold),),
                          verticalSizedBox( 20.0,),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 150,
                                child: ListTile(
                                  title:const Text('Class',
                                      style: TextStyle(
                                          color:Colors
                                              .black)),
                                  leading:
                                  Radio<type>(
                                    fillColor:
                                    MaterialStateColor
                                        .resolveWith(
                                            (states) =>
                                        Colors
                                            .green),
                                    value: type.salle,
                                    groupValue:
                                    _type,
                                    onChanged:
                                        (type?
                                    value) {
                                      setState(() {
                                        _type =
                                        value!;
                                        print(_type.name);

                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 170,
                                child: ListTile(
                                  title:const Text('Amphi',
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
                                    value: type.amphi,
                                    groupValue:
                                    _type,
                                    onChanged:
                                        (type?
                                    value) {
                                      setState(() {

                                        _type =
                                        value!;
                                        print(_type.name);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          verticalSizedBox( 20.0,),
                          /* DropdownButtonFormField2(
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'Choose a class or Amphi',
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
                            items: type
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
                                return 'Please select gender.';
                              }
                            },
                            onChanged: (value) {
                              selectedType=value.toString();
                            },
                          ),*/
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
                                    _particular,
                                    onChanged:
                                        (particular?
                                    value) {
                                      setState(() {

                                        _particular =
                                        value!;
                                        print(_particular.name);
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
                                    _particular,
                                    onChanged:
                                        (particular?
                                    value) {
                                      setState(() {
                                        _particular =
                                        value!;
                                        print(_particular.name);

                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                           verticalSizedBox( 30.0,),
                          SizedBox(
                            width: 300.0,
                            child:defaultButton(function: (){
                              if(formKey.currentState!.validate()){
                                AddCubit.get(context).addClass(name: '${selectedClassroom.toString()} ${selectedClassroomNumber.toString()}', type:_type.name , etage: int.parse(salleEtage.text), capacity: int.parse(salleCapacity.text),particulier:_particular.name );

                              }
                              //AddCubit.get(context).getSalle();
                            }, text: 'Add') ),
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
    }, listener: (BuildContext context, Object? state) {  },);
  }


}
