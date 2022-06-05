import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire_mobile/modules/login/cubit/cubit.dart';
import 'package:memoire_mobile/modules/login/cubit/states.dart';
import 'package:memoire_mobile/shared/components/mobile_constants.dart';
import 'package:memoire_mobile/modules/register/register_cubit/register_cubit.dart';
import 'package:memoire_mobile/modules/register/register_cubit/register_states.dart';
import '../../shared/components/mobile_components.dart';
import '../../shared/components/mobile_constants.dart';
import '../../shared/styles/icons.dart';

enum role { admin, teacher }
role _role = role.teacher;

class EditProfile extends StatefulWidget {
   EditProfile(this.id);
  final id;
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginStates>(builder: (BuildContext context, state) {
      return Scaffold(

        appBar: AppBar(automaticallyImplyLeading: false,title:const Text('Edit Profile'),),
        body: SizedBox(
          width: getWidth(context),
          height: getHeight(context),
          child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                  width: getWidth(context),
                  height: getHeight(context),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        verticalSizedBox( 60.0,),
                        customTextField( controller: firstNameController,label: 'First name', textInputType: TextInputType.name
                          ,),
                        verticalSizedBox(13.0,),
                        customTextField( controller: lastNameController,label: 'Last name', textInputType: TextInputType.name
                          ,),
                        verticalSizedBox(13.0,),

                        customTextField( controller: placeController,label: 'Place', textInputType: TextInputType.emailAddress
                          ,),
                        verticalSizedBox(13.0,),
                        customTextField( controller: gradeController,label: 'Grade', textInputType: TextInputType.emailAddress
                          ,),
                        verticalSizedBox(13.0,),

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 170,
                              child: ListTile(
                                title: Text('Teacher',
                                    style: TextStyle(
                                        color:  Colors
                                            .black)),
                                leading: Radio<role>(
                                  fillColor:
                                  MaterialStateColor
                                      .resolveWith(
                                          (states) =>
                                      Colors
                                          .green),
                                  value: role.teacher,
                                  groupValue: _role,
                                  onChanged:
                                      (role? value) {
                                    setState(() {
                                      _role = value!;
                                      print(_role.name);
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 170,
                              child: ListTile(
                                title: Text('Admin',
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
                                  value: role.admin,
                                  groupValue: _role,
                                  onChanged:
                                      (role? value) {
                                    setState(() {
                                      _role = value!;
                                      print(_role.name);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 60,),
                        Row(
                            children: [
                              Container(
                                  alignment: AlignmentDirectional.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  width: 50,
                                  height:50 ,
                                  child: IconButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, icon:const Icon(IconBroken.Arrow___Left_2))),
                              const SizedBox(width: 20,),
                              Expanded(child: defaultButton(function: (){
                                if(formKey.currentState!.validate()){
                                  LoginCubit.get(context).userUpdate(id: widget.id,first_name:firstNameController.text,last_name: lastNameController.text,grade: gradeController.text,place: placeController.text,role: _role.name );

                                }
                              }, text: 'Save',color2: Colors.green,color3: Colors.green,color4: Colors.green,radius: 15))
                            ],
                          ),
                        const SizedBox(height: 80,),
                      ],
                    ),
                  ),),
              )
          ),
        ),
      );
    }, listener: (BuildContext context, Object? state) {  },);
  }
}

/*
 Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
             children: [
               Container(
                 alignment: AlignmentDirectional.center,
                   decoration: BoxDecoration(
                     border: Border.all(color: Colors.black12),
                     borderRadius: BorderRadius.circular(15)
                   ),
                   width: 50,
                   height:50 ,
                   child: IconButton(onPressed: (){
                     Navigator.pop(context);
                   }, icon:const Icon(IconBroken.Arrow___Left_2))),
               const SizedBox(width: 20,),
               Expanded(child: defaultButton(function: (){}, text: 'Save',color2: Colors.green,color3: Colors.green,color4: Colors.green,radius: 15))
             ],
         ),
          )
         ,
         SizedBox(height: 30,),
 */
