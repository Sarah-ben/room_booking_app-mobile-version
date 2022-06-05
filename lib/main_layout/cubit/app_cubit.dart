import 'package:bloc/bloc.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire_mobile/models/class_model/class_model.dart';
import 'package:memoire_mobile/modules/settings/settings_screen.dart';
import 'package:memoire_mobile/shared/styles/colors.dart';

import '../../modules/Reservations/my_reservations_screen.dart';
import '../../modules/classrooms/classroom_screen_teacher.dart';
import '../../shared/network/cache_helper.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  List<BottomBarItem> items=[
    BottomBarItem(
      icon:const Icon(Icons.home),
      title:const Text('Home'),
      activeColor: secondColor,
      darkActiveColor: Colors.greenAccent.shade400,
    ),
    BottomBarItem(
      icon:const Icon(Icons.list_outlined),
      title:const Text('My Reservations'),
      activeColor: secondColor,
      darkActiveColor: Colors.greenAccent.shade400,  // Optional
    ),
    BottomBarItem(
      icon:const  Icon(Icons.settings),
      title:const Text('Settings'),
      activeColor: secondColor,
      darkActiveColor: Colors.greenAccent.shade400, // Optional
    ),
  ];
  List<Widget> pages=[
    const Classrooms(),
    reservationlist(),
     Settings()
  ];
 int currentPage=0;
  void changeBottom(int index){
    currentPage=index;
    emit(HomeChangeBottomNavState());
  }
  // late Data data;
  bool isDark=false;
  ThemeMode appMode=ThemeMode.dark;

  void changeAppMode({ bool? Dark}) {
    if (Dark != null) {
      isDark = Dark;
      emit(NewsChangeAppTheme());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', val: isDark).then((value) {
        emit(NewsChangeAppTheme());
      });
    }
  }
 /*List<Data> salles=[];
  void getSalle(){
     salles=[];
    // print(classModel!.data!.name);
    emit(getDataState());
    DioHelper.getData(url: 'http://10.0.2.2:8000/api/salle').then((value) {
      //print('hello world');
     // classModel=ClassModel.fromJson(value.data);
      value.data.forEach((e){
        data=Data.fromJson(e);
        print(data.name);
        print(data.id);
        salles.add(Data.fromJson(e));
      });
     // this one worked fine
      /*salles=value.data;
      print(salles);
      print(value.data[0]);
       data=Data.fromJson(value.data[0]);
      print(data.name);*/


     // print(classModel);
      //salles.add(value.data);
      //print(value.data);
   //  salles=value.data;
     // print(salles.length);
      //print(s);
    /* s.forEach((element) {
      // print(element['id']);
      classModel=ClassModel.fromJson(element['id']);
      print(ClassModel.fromJson(element['id']));
     });*/
     //print(salles.length);
     //
      //print(salles[0][1]['name']);
      //print(salles[0][0]['name']);
     // salles.forEach((element) {
       // s=element.data();
     //  print(element);
      // classModel=ClassModel.fromJson(element);
       // s.add(element.data());
       // print('the sec list is $s');
     // });
      emit(GetSuccessState());
    }).catchError((onError){
      print(onError);
      emit(GetErrorState());
    });
  }

  void updateSalle(id,{
    required etage,
    required capcity,
    required particular
  }){
    emit(getDataState());
    DioHelper.updateData(url: 'http://10.0.2.2:8000/api/salle/$id', data: {
    'etage':etage,
    'capcity':capcity,
    'particulier':particular=='True'?true:false,
    }).then((value) {
      print('all updated !');
      // print(value.data);
      //salles=value.data;
     // print(salles);
      emit(GetSuccessState());
    }).catchError((onError){
      emit(GetErrorState());
    });
  }


  void deleteSalle(id,context){
    DioHelper.deleteData(url:'http://10.0.2.2:8000/api/salle/$id' ).then((value){
      getSalle();
      print(value.data);// this shows that salle deleted that i put in my api
      emit(DeleteSuccessState());
    }).catchError((onError){
      emit(DeleteErrorState());
    });
  }
*/
}