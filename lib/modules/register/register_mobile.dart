import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire_mobile/shared/components/mobile_constants.dart';
import 'package:memoire_mobile/modules/register/register_cubit/register_cubit.dart';
import 'package:memoire_mobile/modules/register/register_cubit/register_states.dart';
import '../../main_layout/admin_home_layout.dart';
import '../../shared/components/mobile_components.dart';
import '../../shared/components/mobile_constants.dart';
import '../../shared/network/cache_helper.dart';

enum role { admin, teacher }
role _role = role.teacher;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubits,RegisterState>(builder: (BuildContext context, state) {
      return Scaffold(
        appBar: AppBar(title: Text('Register'),),
        body: SizedBox(
          width: getWidth(context),
          height: getHeight(context),

          child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SizedBox(
                 child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        verticalSizedBox( 30.0,),
                        customTextField( controller: firstNameController,label: 'First name', textInputType: TextInputType.name
                          ,),
                        verticalSizedBox(10.0,),
                        customTextField( controller: lastNameController,label: 'Last name', textInputType: TextInputType.name
                          ,),
                        verticalSizedBox(10.0,),
                        customTextField( controller: gradeController,label: 'Grade',icon: Icons.grade_outlined, textInputType: TextInputType.emailAddress
                          ,),
                        verticalSizedBox(10.0,),
                        customTextField( controller: placeController,label: 'Place', icon: Icons.location_on_outlined, textInputType: TextInputType.emailAddress
                          ,),
                        verticalSizedBox(10.0,),
                        customTextField( controller: emailController,label: 'Email', icon: Icons.alternate_email, textInputType: TextInputType.emailAddress
                          ,),
                        verticalSizedBox(10.0,),
                        customTextField( controller: passwordController,label: 'Password', icon: Icons.lock_outline, textInputType: TextInputType.text,obscureText: true
                        ),
                        verticalSizedBox(10.0,),
                        customTextField( controller: passwordConfirmationController,label: 'Confirm password', icon: Icons.lock_outline, textInputType: TextInputType.text,obscureText: true
                        ),
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
                        verticalSizedBox(10.0,),
                        verticalSizedBox( 50.0,),
                        defaultButton(function: (){
                          if(formKey.currentState!.validate()){
                            RegisterCubits.get(context).userRegister(
                                email: emailController
                                    .text,
                                firstName:
                                firstNameController
                                    .text,
                                lastName:
                                lastNameController
                                    .text,
                                grade:
                                gradeController
                                    .text,
                                place:
                                placeController
                                    .text,
                                role: _role.name,
                                password:
                                passwordController
                                    .text,
                                passwordConfirmation:
                                passwordController
                                    .text);
                          }
                        }, text: 'Register'),
                        verticalSizedBox(10.0,),

                      ],
                    ),
                  ),),
              )
          ),
        ),
      );
    }, listener: (BuildContext context, Object? state) {
      if (state is RegisterSuccessState){
        CacheHelper.saveData(
            key: 'token', val: state.loginModel.token).then((value) =>print('${CacheHelper.getData(key: 'token')}')).
        then((value) => navigateTo(context, AdminHomeScreen()));
      }
    },);
  }
}
