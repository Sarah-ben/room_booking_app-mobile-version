import 'package:flutter/cupertino.dart';

getWidth(context)=> MediaQuery.of(context).size.width;
getHeight(context)=> MediaQuery.of(context).size.height;
TextEditingController emailController=TextEditingController();
TextEditingController firstNameController=TextEditingController();
TextEditingController lastNameController=TextEditingController();
TextEditingController phoneController=TextEditingController();
TextEditingController gradeController=TextEditingController();
TextEditingController placeController=TextEditingController();
TextEditingController passwordController=TextEditingController();
TextEditingController passwordConfirmationController=TextEditingController();
TextEditingController salleNameController=TextEditingController();
TextEditingController salleTypeController=TextEditingController();
GlobalKey<FormState> formKey=GlobalKey();
var salleEtage=TextEditingController();
var salleCapacity=TextEditingController();
enum particular { True, False }
particular particularClass = particular.False;
var reservationTime=TextEditingController();
var reservationDate=TextEditingController();
var reservationGoal=TextEditingController();
