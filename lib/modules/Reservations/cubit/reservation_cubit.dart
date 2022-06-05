import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire_mobile/main_layout/cubit/app_cubit.dart';
import 'package:memoire_mobile/models/reservation_model/reservation_model.dart';
import 'package:memoire_mobile/modules/Reservations/cubit/reservation_list.dart';
import 'package:memoire_mobile/modules/classrooms/cubit/add_cubit.dart';
import 'package:memoire_mobile/modules/users/users_list.dart';
import 'package:memoire_mobile/shared/network/cache_helper.dart';

import '../../../shared/components/mobile_components.dart';
import '../../../shared/network/dio_helper.dart';
import '../../classrooms/classroom_screen_admin.dart';
import '../../login/cubit/cubit.dart';

class ReservationCubit extends Cubit<ReservationStates>{
  ReservationCubit() : super(ReservationInitialState());
  static ReservationCubit get(context)=>BlocProvider.of(context);
late ReservationModel reservationModel;
late ReservationData reservationData;
  void addReservation({
    required String  time,
    required String  date,
    required String goal,
    required id_user,
    required id_classroom,
    required etat,
    required context
  }){
    emit(ReservationAddLoadingState());
    DioHelper.postData(url: 'http://10.0.2.2:8000/api/reservation/add', data:{
      'time':time,
      'date':date,
      'goal':goal,
      'id_classroom':id_classroom,
      'id_user':id_user,
      'etat':CacheHelper.getData(key: 'role')=='admin'?etat='accepted':etat==true?'waiting':'accepted'

    },).then((value) {
      reservationModel=ReservationModel.fromJson(value.data);
      print('data used ${reservationModel.data!.etat}');
      print(value.data);
      print('salle added');
      flutterToast(msg: 'reservation Added Successfully', state: toastStates.success).then((value) {
        Navigator.pop(context);
        //navigateTo(context, ClassroomScreen());
        getReservation(context);

      });
      emit(ReservationADDSuccessState());
    }).catchError((onError){
      flutterToast(msg: 'classroom already reserved!', state: toastStates.success).then((value) =>navigateTo(context, ClassroomsScreen()));
      print(onError);
      emit(ReservationAddErrorState(onError.toString()));
    });
  }

  // get reservation by id

  List<ReservationData> reservations=[];
  void getReservation(context){
    //getReservationall(context, id);
    reservations=[];
    // print(classModel!.data!.name);
    emit(ReservationGetLoadingState());
    DioHelper.getData(url: 'http://10.0.2.2:8000/api/findList/${CacheHelper.getData(key: 'ID')}').then((value) {
      //print('hello world');
      // classModel=ClassModel.fromJson(value.data);
      value.data.forEach((e){
        reservationData=ReservationData.fromJson(e);
        print(reservationData.time);
        reservations.add(ReservationData.fromJson(e));
        print(reservations.length);
      });
      emit(ReservationGetSuccessState());
    }).catchError((onError){
      print(onError);
      emit(ReservationGetErrorState());
    });
  }

  List<ReservationData> allreservations=[];
   getReservationall(context,id){
    allreservations=[];
    // print(classModel!.data!.name);
    emit(ReservationallGetLoadingState());
    DioHelper.getData(url: 'http://10.0.2.2:8000/api/findList/$id').then((value) {
      //print('hello world');
      // classModel=ClassModel.fromJson(value.data);
      print(' list data is ${value.data}');
      value.data.forEach((e){
        reservationData=ReservationData.fromJson(e);
        print(reservationData.time);
          allreservations.add(ReservationData.fromJson(e));
      });
      // this one worked fine
      emit(ReservationallGetSuccessState());
    }).catchError((onError){
      print(onError);
      emit(ReservationallGetErrorState());
    });
    return allreservations.length;
  }
// update a reservation

  void updateReservation({
   required id,
    context,
    required String  time,
    required String  date,
    required String goal,

}){
    emit(ReservationUpdateLoadingState());
    DioHelper.updateData(url: 'http://10.0.2.2:8000/api/reservation/$id', data: {
      'time':time,
      'date':date,
      'goal':goal,
      'id_classroom':'${reservationData.id_classroom}',
      'id_user':'${CacheHelper.getData(key: 'ID')}',

    }).then((value) {
      print(value.data);
      print('all updated !');
      // print(value.data);
      //salles=value.data;
      // print(salles);
      emit(ReservationUpdateSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(ReservationUpdateErrorState());
    });
  }


  void updateReservationForAdmin({
    required id,
    context,
    required String  time,
    required String  date,
    required String goal,
    required id_user
  }){
    emit(ReservationUpdateLoadingState());
    DioHelper.updateData(url: 'http://10.0.2.2:8000/api/reservation/$id', data: {
      'time':time,
      'date':date,
      'goal':goal,
      'id_classroom':'${reservationData.id_classroom}',
      'id_user':id_user,

    }).then((value) {
      print(value.data);
      print('all updated !');
      // print(value.data);
      //salles=value.data;
      // print(salles);
      emit(ReservationUpdateSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(ReservationUpdateErrorState());
    });
  }

  //delete a reservation
  void deleteReservation(id,context){
    getReservation(context);
    // getReservation(context);
    //  getAllReservationsByID(context, id);
    DioHelper.deleteData(url:'http://10.0.2.2:8000/api/reservation/$id' ).then((value){
      flutterToast(msg: 'Reservation deleted!', state: toastStates.success).then((value) {
        navigateTo(context, UsersScreen());
        getReservation(context);

      });
      // getReservation(context);
      print(value.data);// this shows that salle deleted that i put in my api
      emit(ReservationDeleteSuccessState());
    }).catchError((onError){
      print(onError);
      flutterToast(msg: 'Something went wrong,try again!', state: toastStates.error).then((value) =>navigateTo(context, ClassroomsScreen()));
      emit(ReservationDeleteErrorState());
    });
  }

}