import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire_mobile/models/login_model/login_model.dart';
import 'package:memoire_mobile/modules/register/register_cubit/register_states.dart';

import '../../../shared/network/dio_helper.dart';
import 'package:memoire_mobile/shared/network/cache_helper.dart';


class RegisterCubits extends Cubit<RegisterState>{
  RegisterCubits() : super(RegisterinitialState());
  static RegisterCubits get(context)=>BlocProvider.of(context);
  late LoginModel loginModel;
  void userRegister({
    required String email,
    required String firstName,
    required String lastName,
    required String grade,
    required String place,
    required String role,
    required String password,
    required String passwordConfirmation
  }){
    emit(RegisterLoadingState());
    DioHelper.postData(url: 'http://10.0.2.2:8000/api/register', data:{
      'first_name':firstName,
      'last_name':lastName,
      'place':place,
      'grade':grade,
      'email':email,
      'role':role,
      'password':password,
      'password_confirmation':passwordConfirmation
    },).then((value)  {
      print(value.data);
      loginModel=LoginModel.fromJson(value.data);
      print('this is the token ${loginModel.token}');
      print('the name ${loginModel.userData!.first_name}');
      print(loginModel.userData!.id);
      CacheHelper.saveData(key: 'ID', val:loginModel.userData!.id );
      // print('$email');
      emit(RegisterSuccessState(loginModel));
    }).catchError((onError){
      print(onError);
      emit(RegisterErrorState(onError.toString()));
    });
  }

}