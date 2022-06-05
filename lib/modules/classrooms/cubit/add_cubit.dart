import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire_mobile/models/class_model/class_model.dart';
import 'package:memoire_mobile/models/reservation_model/reservation_model.dart';
import 'package:memoire_mobile/modules/classrooms/classroom_screen_admin.dart';
import 'package:memoire_mobile/shared/network/cache_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/components/mobile_components.dart';
import '../../../shared/network/dio_helper.dart';
import '../../login/cubit/cubit.dart';
import 'add_states.dart';



class AddCubit extends Cubit<AddStates>{
  AddCubit( ) : super(AddInitialState());

  static AddCubit get(context)=>BlocProvider.of(context);
  late ClassModel classModel;
  late ReservationModel reservationModel;
  late Data data;
  void userUpdate(){
    emit(LoginUpdateLoadingState());
    DioHelper.updateData(url: 'http://10.0.2.2:8000/api/updateuser/1', data: {
      'first_name':'hello world',
      'last_name':'hello world',
      'grade':'hello world',
      'place':'hello world',
      'role':'admin',
     // 'password':'hello world',

    }).then((value) {
      print('all updated !');
      // print(value.data);
      //salles=value.data;
      // print(salles);
      emit(LoginUpdateSuccessState());
    }).catchError((onError){
      emit(LoginUpdateErrorState(onError));
    });
  }
// add a classroom
  void addClass({
   required String  name,
    required String type,
   required etage,
    required capacity,
    required particulier,
  }){
    emit(AddLoadingState());
    DioHelper.postData(url: 'http://10.0.2.2:8000/api/addsalle', data:{
      'name':name,
      'type':type,
      'etage':etage,
      'capcity':capacity,
      'particulier':particulier=='True'?true:false,
    },).then((value)  {

      getSalle();
      classModel=ClassModel.fromJson(value.data);
      print(classModel.data!.name);
      print('salle added');
       emit(AddSuccessState());
    }).catchError((onError){
      print('this is the error $onError');
      emit(AddErrorState(onError.toString()));
    });
  }

  // get  all classrooms
  List<Data> salles=[];
  List salleName=[];
  void getSalle(){
    salles=[];
    salleName=[];
    // print(classModel!.data!.name);
    emit(getDataState());
    DioHelper.getData(url: 'http://10.0.2.2:8000/api/salle').then((value) {
      //print('hello world');
      // classModel=ClassModel.fromJson(value.data);
      value.data.forEach((e){
        data=Data.fromJson(e);
       // print(data.name);
        salleName.add(data.name!);
        print(salleName.length);
        //print(data.)
        salles.add(Data.fromJson(e));
      });
      for (var element in salleName) {
        print(element);
      }
      // this one worked fine
      emit(GetSuccessState());
    }).catchError((onError){
      print(onError);
      emit(GetErrorState());
    });
  }
var element;
  Future getSalleByID(id)async{
    // print(classModel!.data!.name);
    emit(getDataState());
    DioHelper.getData(url: 'http://10.0.2.2:8000/api/salle/$id').then((value) async {
    //  print('calue i want ${value.data['particulier']}');
      element=value.data['particulier'];
      //print(' data i want $element');
      emit(GetSuccessState());
      CacheHelper.saveData(key: 'partc', val: value.data['particulier']);
      //print('hello world');
      // classModel=ClassModel.fromJson(value.data);
      // this one worked fine
    }).catchError((onError){
      print('error here $onError');
      emit(GetErrorState());
    });
  }
  // update a classroom
  void updateSalle(context,id,{
    required etage,
    required capcity,
    required particular
  }){
    emit(UpdateDataState());
    DioHelper.updateData(url: 'http://10.0.2.2:8000/api/salle/$id', data: {
      'etage':etage,
      'capcity':capcity,
      'particulier':particular=='yes'?true:false,
    }).then((value) {
      print('all updated !');
      flutterToast(msg: 'updated successfully', state: toastStates.success).then((value) {
        getSalle();
        //navigateTo(context, ClassroomScreen());});
      emit(UpdateSuccessState());
    }).then((value) =>  Navigator.pop(context)).catchError((onError){
      flutterToast(msg: 'Someone went wrong ,try again!', state: toastStates.error);

      emit(UpdateErrorState());
    });
      // print(value.data);
      //salles=value.data;
      // print(salles);
      emit(UpdateSuccessState());
    }).catchError((onError){
      emit(UpdateErrorState());
    });
  }

 /* void updateS(){
    emit(UpdateDataState());
    DioHelper.updateData(url: 'http://10.0.2.2:8000/api/reservation/4', data: {
      'time':'etage',
      'date':'capcity',
      'goal':'capcity',
      'id_classroom':'2',
      'id_user':'1',

    }).then((value) {
      print('all updated !');
      // print(value.data);
      //salles=value.data;
      // print(salles);
      emit(UpdateSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(UpdateErrorState());
    });
  }*/
// delete classroom
  void deleteSalle(id,context){
    DioHelper.deleteData(url:'http://10.0.2.2:8000/api/salle/$id' ).then((value){
      print(value.data);
      flutterToast(msg: '${value.data}', state: toastStates.error).then((value) { navigateTo(context, ClassroomsScreen());
      getSalle();
      });
      print(value.data);// this shows that salle deleted that i put in my api
      emit(DeleteSuccessState());
    }).catchError((onError){
      print(onError);
      flutterToast(msg: 'Something went wrong,try again!', state: toastStates.error).then((value)=>navigateTo(context, ClassroomsScreen()));
      emit(DeleteErrorState());
    });
  }

  List search=[];

  searchData(value){
    search=[];
    emit(SearchLoadingState());
    DioHelper.postData(url: 'http://10.0.2.2:8000/api/searchData', data: {
      'data':'$value',
    }).
    then((v) {
      print('data i want ${v.toString()}');
      print('data i want dataa ${v}');
      search=v.data;
      print('data lenght is ${search.length}');
      emit(SearchState());
    }).catchError((onError){
      emit(SearchErrorState());
    });
  }



}