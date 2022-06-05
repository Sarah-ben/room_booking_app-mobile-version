import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire_mobile/modules/login/cubit/states.dart';
import 'package:memoire_mobile/modules/onBoardingScreen/welcome_screen.dart';
import 'package:memoire_mobile/shared/network/cache_helper.dart';

import '../../../models/login_model/login_model.dart';
import '../../../shared/components/mobile_components.dart';
import '../../../shared/network/dio_helper.dart';



class LoginCubit extends Cubit<LoginStates>{
  LoginCubit( ) : super(LoginInitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);
  late LoginModel loginModel;
  late UserData userData;
  void userLogin({
    required String email,
    required String password
  }){
    emit(LoginLoadingState());
    DioHelper.postData(url: 'http://10.0.2.2:8000/api/login', data:{
      'email':email,
      'password':password
    },).then((value)  {
    //  print(value.data);
      loginModel=LoginModel.fromJson(value.data);
      print('this is the token ${loginModel.token}');
      print('the name ${loginModel.userData!.first_name}');
      //print(loginModel.userData!.id);
      CacheHelper.saveData(key: 'ID', val:loginModel.userData!.id );
      CacheHelper.saveData(key: 'first_name', val:loginModel.userData!.first_name );
      CacheHelper.saveData(key: 'last_name', val:loginModel.userData!.last_name );
      CacheHelper.saveData(key: 'grade', val:loginModel.userData!.grade );
      CacheHelper.saveData(key: 'role', val:loginModel.userData!.role );

     // print('$email');
      emit(LoginSuccessState(loginModel));
    }).catchError((onError){
      flutterToast(msg: 'Wrong information! try again.', state: toastStates.error);
      print(onError);
      emit(LoginErrorState(onError.toString()));
    });
  }
  List<UserData> users=[];
  List<String>emails=[];
  void getUsers(){
    users=[];
    emails=[];
    // print(classModel!.data!.name);
    emit(getDataState());
    DioHelper.getData(url: 'http://10.0.2.2:8000/api/getUsers').then((value) {
      //print('hello world');
      print('data');
      // classModel=ClassModel.fromJson(value.data);
      print(value.data);
      value.data.forEach((e){
        userData=UserData.fromJson(e);
        print(userData.first_name);
        print(userData.id);
        //print(data.id);
        users.add(UserData.fromJson(e));
        emails.add(userData.email!);
        print('emais lenght${emails.length}');
      });
      // this one worked fine

      emit(GetSuccessState());
    }).catchError((onError){
      print(onError);
      //emit(GetErrorState());
    });
  }

  void userUpdate({
    required id,
  String? first_name,
  String? last_name,
  String? grade,
  String? place,
  String? role,
}){
    emit(LoginUpdateLoadingState());
    DioHelper.updateData(url: 'http://10.0.2.2:8000/api/updateuser/$id', data: {
      'first_name':first_name,
      'last_name':last_name,
      'grade':grade,
      'place':place,
      'role':role,
      // 'password':'hello world',

    }).then((value) {
      getUsers();
      print('all updated !');
      // print(value.data);
      //salles=value.data;
      // print(salles);
      emit(LoginUpdateSuccessState());
    }).catchError((onError){
      emit(LoginUpdateErrorState(onError));
    });
  }
  
  void deleteUser(id,context){
    DioHelper.deleteData(url: 'http://10.0.2.2:8000/api/delete/$id').then((value) {
      print(value.data);
      getUsers();
      emit(DeleteUserSuccessState());
      flutterToast(msg: 'Account Deleted!', state: toastStates.error);
      Navigator.pop(context);
    }).catchError((onError){
      flutterToast(msg: 'something went wrong!', state: toastStates.error);

      emit(DeleteUserErrorState());

    });
  }
  void deleteAccount(id,context){
    DioHelper.deleteData(url: 'http://127.0.0.1:8000/api/delete/$id').then((value) {
      getUsers();
      print(value.data);
      emit(DeleteUserSuccessState());
      flutterToast(msg: 'Account Deleted!', state: toastStates.error).then((value) {
        CacheHelper.clearData();
        navigateAndReplace(context, OnBoardingScreen());} );
    }).catchError((onError){
      flutterToast(msg: 'something went wrong!', state: toastStates.error);

      emit(DeleteUserErrorState());

    });
  }

}